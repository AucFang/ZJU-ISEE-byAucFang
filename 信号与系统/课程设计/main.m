clear;
x = [1,1,4,5,1,4];
h = [1,9,1,9,8,1,2,3,3,2,9,7];

figure(1);
stem(x);grid('on');title('离散序列x[n]时域图');
%fft
%实际值
X = fftNew(x);
figure(2);
subplot(1,2,1);stem(0:2*pi/length(X):2*pi*(length(X)-1)/length(X),abs(X));grid('on');
xlabel('\omega');ylabel('Amplitude');title('离散序列x[n]的FFT结果X[n]的幅值计算结果');
subplot(1,2,2);stem(0:2*pi/length(X):2*pi*(length(X)-1)/length(X),angle(X));grid('on');
xlabel('\omega');ylabel('Angle');title('离散序列x[n]的FFT结果X[n]的相位计算结果');
%理论值
Xt = fft(x);
figure(3);
subplot(1,2,1);stem(0:2*pi/length(Xt):2*pi*(length(Xt)-1)/length(Xt),abs(Xt));grid('on');
xlabel('\omega');ylabel('Amplitude');title('离散序列x[n]的FFT结果X[n]的幅值理论值');
subplot(1,2,2);stem(0:2*pi/length(Xt):2*pi*(length(Xt)-1)/length(Xt),angle(Xt));grid('on');
xlabel('\omega');ylabel('Angle');title('离散序列x[n]的FFT结果X[n]的相位理论值');
%误差
err = abs(Xt - X)./abs(Xt);
figure(4);
stem(0:2*pi/length(err):2*pi*(length(err)-1)/length(err),err);grid('on');title('幅度误差');

%新序列fft
x = [5,9,2,9,8,7,68,62,5,1,36,1,4,5,7,5,6];

figure(5);
stem(x);grid('on');title('离散序列x[n]时域图');
%实际值
X = fftNew(x);
figure(6);
subplot(1,2,1);stem(0:2*pi/length(X):2*pi*(length(X)-1)/length(X),abs(X));grid('on');
xlabel('\omega');ylabel('Amplitude');title('离散序列x[n]的FFT结果X[n]的幅值计算结果');
subplot(1,2,2);stem(0:2*pi/length(X):2*pi*(length(X)-1)/length(X),angle(X));grid('on');
xlabel('\omega');ylabel('Angle');title('离散序列x[n]的FFT结果X[n]的相位计算结果');
%理论值
Xt = fft(x);
figure(7);
subplot(1,2,1);stem(0:2*pi/length(Xt):2*pi*(length(Xt)-1)/length(Xt),abs(Xt));grid('on');
xlabel('\omega');ylabel('Amplitude');title('离散序列x[n]的FFT结果X[n]的幅值理论值');
subplot(1,2,2);stem(0:2*pi/length(Xt):2*pi*(length(Xt)-1)/length(Xt),angle(Xt));grid('on');
xlabel('\omega');ylabel('Angle');title('离散序列x[n]的FFT结果X[n]的相位理论值');
%误差
err = abs(Xt - X)./abs(Xt);
figure(8);
stem(0:2*pi/length(err):2*pi*(length(err)-1)/length(err),err);grid('on');title('幅度误差');

%ifft
X = [2,9,5,3,7,12,14,2,6,35,1];
figure(9);
stem(X);grid('on');title('离散序列X[n]频域图');
%实际值
x = ifftNew(X);
figure(10);
subplot(1,2,1);stem(abs(x));grid('on');
xlabel('n');ylabel('Amplitude');title('离散序列X[n]的IFFT结果x[n]的幅值计算结果');
subplot(1,2,2);stem(angle(x));grid('on');
xlabel('n');ylabel('Angle');title('离散序列X[n]的IFFT结果x[n]的相位计算结果');
%理论值
xt = ifft(X);
figure(11);
subplot(1,2,1);stem(abs(xt));grid('on');
xlabel('n');ylabel('Amplitude');title('离散序列X[n]的IFFT结果x[n]的幅值理论值');
subplot(1,2,2);stem(angle(xt));grid('on');
xlabel('n');ylabel('Angle');title('离散序列X[n]的IFFT结果x[n]的相位理论值');
%误差
err = abs(xt - x)./abs(xt);
figure(12);
stem(err);grid('on');title('幅度误差');

%线性卷积
y = DiscreteConvolutionUsingFFT(x,h);
figure(13);
subplot(1,2,1);
stem(abs(y));grid('on');title('y[n]=x[n]*h[n]幅值计算结果');
yt = conv(x,h);
subplot(1,2,2);stem(abs(yt));grid('on');title('y[n]=x[n]*h[n]幅值理论值');
figure(14);
subplot(1,2,1);stem(angle(y));grid('on');title('y[n]=x[n]*h[n]相位计算结果');
subplot(1,2,2);stem(angle(yt));grid('on');title('y[n]=x[n]*h[n]相位理论值');
%误差
err = abs(yt - y)./abs(yt);
perr = angle(yt) - angle(y);
figure(15);
subplot(1,2,1);stem(abs(err));grid('on');title('幅度误差');
subplot(1,2,2);stem(abs(perr));grid('on');title('相位误差');
%长序列线性卷积
x = rand(1,6120);
h = rand(1,206);
y = DiscreteConvolutionUsingFFT(x,h);
figure(16)
subplot(1,2,1);plot(0:length(y)-1,abs(y));title('y[n]=x[n]*h[n]计算结果');grid('on');
yt = conv(x,h);
err = abs(yt - y)./abs(yt);
subplot(1,2,2);plot(abs(err));grid('on');title('幅度误差');


