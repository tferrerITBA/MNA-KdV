function y = inv_fft(x)
  size_x = size(x);
  N = size_x(2);
  L=length(x);
  y=[ ]; % matriz vacia
  k=0:L -1;
  for m=0:N-1
    b=exp((1i*2*k*m*pi)/N);
    s=sum(x.*b)./N;
    y=[y s];
  end
end
