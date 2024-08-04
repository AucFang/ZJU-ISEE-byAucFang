clc;clear;close all;
% Fs = 8000;                     %采样频率8kHz
% N = 2048;
% n = 0:N-1;
% xi = sin(2*pi*400/Fs*n);
% X=fft(xi,N);
% figure(1);
% plot(Fs/N*(-N/2:N/2-1),abs(fftshift(X)));
% xlabel('f(Hz)');ylabel('Abs(X)');
% title('第1个字符的DTMF信号频谱');
N = 41;
n = 0:N-1;
% %Wn = ones(1,N);
% Wn = 0.5-0.5*cos(2*pi*n/(N-1));
% %Wn = 0.54 - 0.46*cos(2*pi*n/(N-1));
% hn =(sin(109/160*pi*(n-(N-1)/2))-sin(51/160*pi*(n-(N-1)/2)))./(pi*(n-(N-1)/2)).*Wn;
% hn((N+1)/2) = 58/160*Wn((N+1)/2);
% figure(1);
% stem(n,hn);
% Hk = fft(hn);
% figure(2);
% plot(n/(N-1)*2*pi,20*log10(abs(Hk)));
% b = [3,-2,3,0,-3,2,-3];
% a = [1,0,0,0,0,0,0];
% [z,p,k] = tf2zp(b,a);
% sos = zp2sos(z,p,k);
% fprintf('SOS = \n');
% disp(sos)
% [C,B,A,rM] = dir2fs_r(b,1);
% fprintf('C = \n');disp(C);fprintf('B = \n');disp(B);fprintf('A = \n');disp(A);fprintf('rm = \n');disp(rM);
k = 0:N-1;
Hk = [0 0 0 0 0 0 0 0.4 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0.4 0 0 0 0 0 0 0];
w = 0:2*pi/N:2*pi-2*pi/N;
for ind1 = 1:N
    sum = 0;
    for ind2 = 1:N
        if (sin(N/2*(w(ind1)-2*pi*(ind2-1)/N))==0)&&(N*sin(w(ind1)/2-pi*(ind2-1)/N)==0)
            sum = sum + Hk(ind2)*exp(j*(ind2-1)*pi*(N-1)/N);
        else
            sum = sum + Hk(ind2)*exp(j*(ind2-1)*pi*(N-1)/N)*(sin(N/2*(w(ind1)-2*pi*(ind2-1)/N))/(N*sin(w(ind1)/2-pi*(ind2-1)/N)));
        end
        
    end
    Hejw(ind1)=sum*exp(-j*w(ind1)*(N-1)/2);
end
plot(w,20*log10(abs(Hejw)));