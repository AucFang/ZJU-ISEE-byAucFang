[x1,fs] = audioread('voice1.wma');
[x2,fs] = audioread('voice2.wma');

%只取左声道
x1 = x1(:,1);
x2 = x2(:,1);

%统一两个信号的长度。
len1 = length(x1);
len2 = length(x2);
if len1>len2
    x2(len2+1:len1) = 0;
else
    x1(len1+1:len2) = 0;
end

derta_fs = fs/length(x1);

%低通滤波（FIR滤波器），在《数字信号处理》中要专门讲滤波器设计。
fp = 3000;
N1 = 2*pi*0.9/(0.1*pi);
wc1 = 2*pi*fp/fs;
if rem(N1,2)
    N1 = N1+1;
end
Window = blackman(N1+1);
b1 = fir1(N1,wc1/pi,Window);%低通滤波器，b1只有19个数，精度不算高。
figure(1);
freqz(b1,1,512);
title('低通滤波器的频率响应');
x1_low = filter(b1,1,x1);%将x1低通滤波
x2_low = filter(b1,1,x2);%将x2低通滤波

audiowrite('voice1AfterLowpassFilter.wav', x1_low, fs);

audiowrite('voice2AfterLowpassFilter.wav', x2_low, fs);%把低通滤波结果保存

%调制
x3 = zeros(1,len1);
fc1 = 8000; 
fc2 = 20000;%以上两句分别定义了wc1和wc2.
for i =1:length(x3)
    x3(i) = x1_low(i)*cos(2*pi*fc1*(i-1)/fs)+x2_low(i)*cos(2*pi*fc2*(i-1)/fs);%两个加起来
end
audiowrite('voice1and2AfterModulation.wav', x3, fs);

%解调
x1_afterModulation = zeros(1,len1);
x2_afterModulation = zeros(1,len1);
for i =1:length(x3)
    x1_afterModulation(i) = x3(i)*cos(2*pi*fc1*(i-1)/fs);
    x2_afterModulation(i) = x3(i)*cos(2*pi*fc2*(i-1)/fs);%两个信号各自乘以相应的载波
end
x1_afterModulation = filter(b1,1,x1_afterModulation);
x2_afterModulation = filter(b1,1,x2_afterModulation);%低通滤波。
audiowrite('voice1AfterDemodulation.wav', x1_afterModulation, fs);
audiowrite('voice2AfterDemodulation.wav', x2_afterModulation, fs);