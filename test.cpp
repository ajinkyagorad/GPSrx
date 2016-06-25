#include <cstring>       //for memset, memmove functions
#include <stdlib.h>      //for rand()   
#include <stdio.h>       //for printf
#include <cmath>         //for sin, log etc
#include <inttypes.h>    //for int64_t datatype
#include <iostream>      //for cout
#include <ctime>         // for time(NULL) in srand
#include <bitset>
using namespace std;
typedef long long __int64;

const double PI = 3.14159265358979323846;


struct CACODE { // GPS coarse acquisition (C/A) gold code generator.  Sequence length = 1023.

   char g1[11], g2[11];
   int  tap0, tap1;

   CACODE(int t0, int t1) { // Each satellite has unique taps
      tap0 = t0;
      tap1 = t1;
      memset(g1+1, 1, 10);
      memset(g2+1, 1, 10);
   }

   int Chip() {
      return g1[10] ^ g2[tap0] ^ g2[tap1] ? 1 : -1;
   }

   void Clock() {
      g1[0] = g1[3] ^ g1[10];
      g2[0] = g2[2] ^ g2[3] ^ g2[6] ^ g2[8] ^ g2[9] ^ g2[10];
      memmove(g1+1, g1, 10);
      memmove(g2+1, g2, 10);
   }
};

double Noise() { // Unity RMS amplitude white Gaussian noise
    static double x1, x2;
    static int i;

    if (i=!i) {
        // x1,x2 = Uniformly distributed random pair in (0,1]
        //srand(time(NULL));
        x1 = (rand()+1)/2147483648.0; //rand() returns integer in [1, RAND_MAX]
        x2 = (rand()+1)/2147483648.0; // and RAND_MAX here is 2^31-1 (check by cout<<RAND_MAX)

        // Box-Muller transform
        return sqrt(-2*log(x1))*cos(2*PI*x2);
    } else
        return sqrt(-2*log(x1))*sin(2*PI*x2);
}

int main()
{

   #define BP 50           // Binary places after fixed point

    const double Ac = 100;      // -130 dBm = 71nV RMS = 100nV Peak = GPS signal @ antenna
    const double An = 630;      // -174 dBm/Hz + 63 dB.Hz = -111 dBm = 630nV RMS thermal noise in 2 MHz BW
    const double DC =  50;      // Antenna-referred DC offset

    const double fc = 9975e3;   // IF centre frequency (as S53MV design)
    const double fs = 6138e3;   // Sampling rate (as S53MV design)

    // Initial phase & frequency of local oscillator and code recovery NCOs
    __int64 lo_rate = __int64(2301.1e3 / fs * pow(2, BP)), lo_phase = 0; //fc - 2*fs = 2301 ==> signal spectrum with lowest frequency...
    __int64 ca_rate = __int64(1023.1e3 / fs * pow(2, BP)), ca_phase = 1000LL<<BP; //...on sampling at fs //0.1 is just added to demo... 
    printf("%"PRId64"\n",lo_rate );                                               //...locking later

    // Three space vehicles in view
    CACODE sv1(2,6), sv2(3,7), sv3(4,8), *target = &sv2;

    char code[1023];
    for (int i=0; i<1023; target->Clock()) code[i++] = target->Chip();

    double t=0;

    const __int64 dither = 1LL<<(BP-1);        // Half-chip = 1i64<<(BP-1); full chip = 1i64<<(BP-0)

#if 1
    const int lo_sin[] = {1,1,-1,-1};
    const int lo_cos[] = {1,-1,-1,1};
#else
    const int lo_sin[] = {0,1,0,-1};
    const int lo_cos[] = {1,0,-1,0};
#endif

    for (int b=0; b<200; b++) { // Data bits

        int I=0, Q=0;

        for (int r=0; r<20; r++) {  // 20 code repeats in 20ms; GPS data rate = 50bps

            int ie=0, qe=0, ip=0, qp=0, il=0, ql=0; // 1ms decimation integrators

            for (int j=0; j<1023; j++) {    // Code length = 1023
                for (int k=0; k<6; k++) {   // 6 samples per chip as per S53MV design (fs=6*1023=6138)

                    double y = sin(2*PI*fc*t);

                    // BPSK signals plus noise
                    double v = Ac * sv1.Chip() * (((b>>0)&2)-1) * y // Data  = 00110011 ...
                             + Ac * sv2.Chip() * (((b>>1)&2)-1) * y // 0000111100001111 ...
                             + Ac * sv3.Chip() * (((b>>2)&2)-1) * y // 0000000011111111 ...
                             + An * Noise();

                    // DC offset & distortion
                    v += DC + v*v + v*v*v;

                    // Sampling, down-conversion to 2.301 MHz and 1-bit hard limiting
                    int d = v>0? 1 : -1;

                    // Local oscillator
                    int LO_I = lo_sin[lo_phase>>(BP-2)];
                    int LO_Q = lo_cos[lo_phase>>(BP-2)];

                    // Early, late & punctual code
                    int ca_e = code[((ca_phase+dither)>>BP) % 1023];
                    int ca_p = code[ (ca_phase        >>BP) % 1023];
                    int ca_l = code[((ca_phase-dither)>>BP) % 1023];

                    // XOR mixers despread and down-convert to baseband; outputs integrated over 1ms
                    ie += d*ca_e*LO_I; qe += d*ca_e*LO_Q;
                    ip += d*ca_p*LO_I; qp += d*ca_p*LO_Q;
                    il += d*ca_l*LO_I; ql += d*ca_l*LO_Q;

                    // Code NCO
                    ca_phase += ca_rate;
                    ca_phase %= 1023LL<<BP;

                    // Carrier NCO
                    lo_phase += lo_rate;
                    lo_phase &= (1LL<<BP) - 1;

                    t += 1/fs;
                }

                sv1.Clock(), sv2.Clock(), sv3.Clock();
            }

            I += ip;
            Q += qp;

            // Power(E) - Power(L) = (IE^2+QE^2) - (IL^2+QL^2) = (IE+IL)*(IE-IL) + (QE+QL)*(QE-QL)
            __int64 err = (ie+il) * (ie-il) + (qe+ql) * (qe-ql);

            // Code lock PI controller
            ca_phase += err << (BP-19);
            ca_rate  += err << (BP-40);

            // Costas loop balanced mixer: I*Q = data(t)^2 * sin(2*phase_error) / 2
            err = (ip * qp) >> 1;
#if 0
            // ATAN method
            double theta = atan2(double(qp), double(ip));
            lo_phase += theta/2/PI * pow(2, BP);
            //fprintf(fp, "%g\n", theta);
#else
            // Carrier lock PI controller
            lo_phase += err << (BP-19);
            lo_rate  += err << (BP-40);
#endif
            // Wrap-around
            ca_phase += 1023LL<<BP;
            ca_phase %= 1023LL<<BP;
            lo_phase &= (1LL<<BP) - 1;
        }

        printf("%-3d %8.1f %7d %7d %9.3f %7.0f  %9.0f  %9.0f\n",
            b,
            double(ca_phase>>(BP-4))/16,
            I, Q,
            atan2(double(Q),double(I))/2/PI,
            sqrt(I*I+Q*Q),
            lo_rate * fs / pow(2, BP),
            ca_rate * fs / pow(2, BP)
        );
    }


}
