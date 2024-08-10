%discreteConvolutionUsingFFT.m
function y = DiscreteConvolutionUsingFFT(x,h)
N1 = length(x);
N2 = length(h);
m = floor(log2(N1+N2-1))+1;
L = 2^m;
x = [x,zeros(1,L-N1)];
h = [h,zeros(1,L-N2)];
X = fftNew(x);
H = fftNew(h);
Y = X.*H;
y = ifftNew(Y);
y = y(1:N1+N2-1);
end