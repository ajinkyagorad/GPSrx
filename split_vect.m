% split vector into packets

function y = split_vect(vect,N)
  Z = floor(max(size(vect))/N);
  y = [];
  [p,q]=size(vect);
  if( p > q )
    v = vect';
  else
    v = vect;
  end
  for i=1:Z
    y(i,1:N) = v((i-1)*N+1:i*N);
  end

end

