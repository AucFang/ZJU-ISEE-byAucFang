clear;clc;close all;
%2-1
wc = 0.2*pi;
tr_width = 0.4*pi;
%Hanning Window
N = ceil(6.2*pi/tr_width);
N = N+mod(N+1,2);           %ensure N is odd
window = hanning(N);
hn = fir1(N-1, wc/pi,"low",window);
[H,W]=freqz(hn,1,512);      % frequency response
mag=abs(H);pha=angle(H);
db=20*log10((mag+eps)/max(mag));
figure;
subplot(2,1,1);plot(W/pi,db);
title('汉宁窗设计FIR滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
subplot(2,1,2);plot(W/pi,pha);
title('汉宁窗函数设计FIR滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');

%Hamming Window
N = ceil(6.6*pi/tr_width);
N = N+mod(N+1,2);           %ensure N is odd
window = hamming(N);
hn = fir1(N-1, wc/pi,"low",window);
[H,W]=freqz(hn,1,512);      % frequency response
mag=abs(H);pha=angle(H);
db=20*log10((mag+eps)/max(mag));
figure;
subplot(2,1,1);plot(W/pi,db);
title('汉明窗设计FIR滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
subplot(2,1,2);plot(W/pi,pha);
title('汉明窗函数设计FIR滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');

%2-2
wc = 0.5*pi; 
N = 31; 
n = 0:N-1;
window1 = (rectwin(N))'; % rectangular window
window2 = (hamming(N))'; % hamming window

h1n = fir1(N-1,wc/pi,window1);  %h[n] of filter 1 using rectangular window
H1k = fft(h1n);                 %DFT of h1n, N-point sampling of frequency response H1(w)
h2n = fir1(N-1,wc/pi,window2);  % h[n] of filter 2 using hamming window
H2k = fft(h2n);                 %DFT of h2n, N-point sampling of frequency response H2(w)

% frequency response of filter 1
[H1,W1] = freqz(h1n,1,512);
mag1=abs(H1);pha1=angle(H1);
db1=20*log10((mag1+eps)/max(mag1));
% frequency response of filter 2
[H2,W2] = freqz(h2n,1,512);
mag2=abs(H2);pha2=angle(H2);
db2=20*log10((mag2+eps)/max(mag2));

figure;
subplot(3,1,1); stem(n,h1n,'filled','.');       % h1[n]
title('用矩形窗设计的滤波器h1[n]'); xlabel('n'); ylabel('magnitude');
subplot(3,1,2); stem(n,abs(H1k),'filled','.');  % |H1(k)|
title('|H1(k)|'); xlabel('k'); ylabel('magnitude');
subplot(3,1,3); plot(W1/pi,db1,LineWidth=1); % H1(w)
title('20lg|H1(\omega)|'); xlabel('frequency in pi units'); ylabel('db');

figure;
subplot(3,1,1); stem(n,h2n,'filled','.');       % h2[n]
title('用汉明窗设计的滤波器h2[n]'); xlabel('n'); ylabel('magnitude');
subplot(3,1,2); stem(n,abs(H2k),'filled','.');  % |H2(k)|
title('|H2(k)|'); xlabel('k'); ylabel('magnitude');
subplot(3,1,3); plot(W2/pi,db2,LineWidth=1);    % H2(w)
title('20lg|H2(\omega)|'); xlabel('frequency in pi units'); ylabel('db');

%compare filter differency
figure;
subplot(3,1,1); stem(n,h1n,'filled');
hold on; stem(n,h2n,':pentagram','filled');
title('两个滤波器的单位抽样响应序列'); xlabel('n'); ylabel('magnitude');
legend('h1[n]','h2[n]');
subplot(3,1,2); stem(n,abs(H1k),'filled');
hold on; stem(n,abs(H2k),':pentagram','filled');
title('两个滤波器的频率响应抽样序列'); xlabel('k'); ylabel('magnitude');
legend('|H1(k)|','|H2(k)|');
subplot(3,1,3); plot(W1/pi,db1,LineWidth=1);
hold on; plot(W2/pi,db2,'-r',LineWidth=1);
title('两个滤波器的频率响应'); xlabel('frequency in pi units'); ylabel('dB');
legend('20lg|H1(\omega)|','20lg|H2(\omega)|');

%2-3、2-4
Nr = 200;              %length of the random sequence
nr = 0:Nr-1;
xr = rand(1,Nr)-0.5;   % generate a random sequence
Xr = fft(xr);          % DFT of random sequence xr
figure;
subplot(2,1,1); stem(nr,xr,'filled','.');
title('随机信号序列x[n]'); xlabel('n'); ylabel('magnitude');
subplot(2,1,2); stem(nr,abs(Xr),'filled','.');
title('随机信号幅度谱'); xlabel('k'); ylabel('magnitude');

N3 = 127;               %length of the third filter
n3 = 0:N3-1;
window3 = rectwin(N3); %rectangular window
h3n = fir1(N3-1,wc/pi,window3); %% h[n] of filter 3 using rectangular window

y1 = filter(h1n,1,xr);  %output of xr after passing through filter 1
Y1 = fft(y1);
y2 = filter(h2n,1,xr);  %output of xr after passing through filter 2
Y2 = fft(y2);
y3 = filter(h3n,1,xr);  %output of xr after passing through filter 3
Y3 = fft(y3);
[H3,W3] = freqz(h3n,1,512);     % frequency response of filter 3
mag3=abs(H3);pha3=angle(H3);
db3=20*log10((mag3+eps)/max(mag3));

figure;          %signal spectrum of filter 1
subplot(2,1,1); stem(nr,abs(Xr),'filled','.');
title('输入信号频谱|X(k)|'); xlabel('k'); ylabel('magnitude');
subplot(2,1,2); stem(nr,abs(Y1),'filled','.');
title('输出信号频谱|Y1(k)|'); xlabel('k'); ylabel('magnitude');

figure;         %signal spectrum of filter 2
subplot(2,1,1); stem(nr,abs(Xr),'filled','.');
title('输入信号频谱|X(k)|'); xlabel('k'); ylabel('magnitude');
subplot(2,1,2); stem(nr,abs(Y2),'filled','.');
title('输出信号频谱|Y2(k)|'); xlabel('k'); ylabel('magnitude');

figure;         %signal spectrum of filter 3
subplot(2,1,1); stem(nr,abs(Xr),'filled','.');
title('输入信号频谱|X(k)|'); xlabel('k'); ylabel('magnitude');
subplot(2,1,2); stem(nr,abs(Y3),'filled','.');
title('输出信号频谱|Y3(k)|'); xlabel('k'); ylabel('magnitude');

%compare output signal spectrum
figure; % |Y1(k)|与|Y2(k)|
stem(nr,abs(Y1),'filled',MarkerSize=4);
hold on; stem(nr,abs(Y2),':pentagram','filled',MarkerSize=4);
title('滤波器1和滤波器2的输出信号频谱'); xlabel('k'); ylabel('magnitude');
legend('|Y1(k)|','|Y2(k)|'); 

figure; % |Y1(k)|与|Y3(k)|
stem(nr,abs(Y1),'filled',MarkerSize=4);
hold on; stem(nr,abs(Y3),':pentagram','filled',MarkerSize=4);
title('滤波器1和滤波器3的输出信号频谱'); xlabel('k'); ylabel('magnitude');
legend('|Y1(k)|','|Y3(k)|');

%compare filter diffency
figure; 
plot(W1/pi,db1,LineWidth=1); 
hold on; plot(W3/pi,db3,'-r',LineWidth=1);
title('滤波器1和滤波器3的频率响应'); xlabel('frequency in pi units'); ylabel('dB');
legend('20lg|H1(\omega)|','20lg|H3(\omega)|'); % 幅频响应

