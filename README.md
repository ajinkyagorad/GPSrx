# GPSrx
##Reception of GPS signals from RTL-SDR and getting raw GPS data
* Using GNU radio software to realize the incoming data and plot its spectrum.
* GPS signals are well below the thermal noise, but can be received because it uses C/A signals which uses Spectrum spreading using PRN (Pseudo Random) Codes.
* By correlating the received signal (which looks like noise) by the C/A PRN code, GPS receivers receive data from satellites

##Results
* How PRN gold codes look like?, here are g5 and g17 C/A codes
  ![Img](https://raw.githubusercontent.com/ajinkyagorad/GPSrx/master/img/PRNgcode.jpg)
* Results Yet, correlation of raw signal with all the 37 CA codes
  ![Img](https://raw.githubusercontent.com/ajinkyagorad/GPSrx/master/img/all37_1.jpg)
* With self simulated data without noise, the power of correlation
* ![Img](https://raw.githubusercontent.com/ajinkyagorad/GPSrx/master/img/cdmaGPSsim.jpg)
####Check List!!!
* -[x] check the CA code correlation on the simulated noise!
* -[x] Correlate Code spreaded data with the cacode, simulation
* -[ ] construct time domain sinc filtered signal from gold codes with data representation similar to GPS signal
* -[ ] resample the signal simulating Doppler effect due to satellite and predict Doppler shift from GPS signal buried under noise

##Following links were referenced :
* C/A Code Generator in [python](https://natronics.github.io/blag/2014/gps-spreading/)
[ MATLAB](http://www.mathworks.com/matlabcentral/fileexchange/14670-gps-c-a-code-generator/content/cacode.m)
* [Information about CDMA band allocation ](http://niviuk.free.fr/cdma_band.php)
* [Hobbyiest Guide to RTL-SDR](http://www.qsl.net/yo4tnv/docs/The%20Hobbyists%20Guide%20To%20RTL-SDR%20-%20Carl%20Laufer.pdf) an interesting read
* [Soft GPS Project Page](http://kom.aau.dk/project/softgps/data.php)
* [1 bit ADC](http://www.paulallenengineering.com/blog/noise-oversampling-and-a-1-bit-ad) and a short video description [here](https://www.youtube.com/watch?v=DTCtx9eNHXE)
* [1 bit processing  of BOC](http://www.tesa.prd.fr/docs/journalTESA/1-bit%20Processing%20of%20Composite%20BOC%20(CBOC)%20Signals%20and%20Extension%20to%20Time-Multiplexed%20BOC%20(TMBOC)%20Signals.pdf)
* [GNSS SDR](http://gnss-sdr.org/node/50), contains specs about RTL-SDR
* [A homemade GPS Receiver](http://www.aholme.co.uk/GPS/Main.htm)
* [Satellite Signal Acquisition, Tracking, and Data Demodulation] (http://www.artechhouse.com/uploads/public/documents/chapters/kaplan_894_CH05.pdf)
* [A homemade receiver for GPS & GLONASS satellites](http://lea.hamradio.si/~s53mv/navsats/theory.html)
* [GPS simulated signal Generation](http://www.insidegnss.com/special/elib/National_Instruments_GPS_Rx_Testing_tutorial.pdf)
