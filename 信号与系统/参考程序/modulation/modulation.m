[x1,fs] = audioread('voice1.wma');
[x2,fs] = audioread('voice2.wma');

%ֻȡ������
x1 = x1(:,1);
x2 = x2(:,1);

%ͳһ�����źŵĳ��ȡ�
len1 = length(x1);
len2 = length(x2);
if len1>len2
    x2(len2+1:len1) = 0;
else
    x1(len1+1:len2) = 0;
end

derta_fs = fs/length(x1);

%��ͨ�˲���FIR�˲��������ڡ������źŴ�����Ҫר�Ž��˲�����ơ�
fp = 3000;
N1 = 2*pi*0.9/(0.1*pi);
wc1 = 2*pi*fp/fs;
if rem(N1,2)
    N1 = N1+1;
end
Window = blackman(N1+1);
b1 = fir1(N1,wc1/pi,Window);%��ͨ�˲�����b1ֻ��19���������Ȳ���ߡ�
figure(1);
freqz(b1,1,512);
title('��ͨ�˲�����Ƶ����Ӧ');
x1_low = filter(b1,1,x1);%��x1��ͨ�˲�
x2_low = filter(b1,1,x2);%��x2��ͨ�˲�

audiowrite('voice1AfterLowpassFilter.wav', x1_low, fs);

audiowrite('voice2AfterLowpassFilter.wav', x2_low, fs);%�ѵ�ͨ�˲��������

%����
x3 = zeros(1,len1);
fc1 = 8000; 
fc2 = 20000;%��������ֱ�����wc1��wc2.
for i =1:length(x3)
    x3(i) = x1_low(i)*cos(2*pi*fc1*(i-1)/fs)+x2_low(i)*cos(2*pi*fc2*(i-1)/fs);%����������
end
audiowrite('voice1and2AfterModulation.wav', x3, fs);

%���
x1_afterModulation = zeros(1,len1);
x2_afterModulation = zeros(1,len1);
for i =1:length(x3)
    x1_afterModulation(i) = x3(i)*cos(2*pi*fc1*(i-1)/fs);
    x2_afterModulation(i) = x3(i)*cos(2*pi*fc2*(i-1)/fs);%�����źŸ��Գ�����Ӧ���ز�
end
x1_afterModulation = filter(b1,1,x1_afterModulation);
x2_afterModulation = filter(b1,1,x2_afterModulation);%��ͨ�˲���
audiowrite('voice1AfterDemodulation.wav', x1_afterModulation, fs);
audiowrite('voice2AfterDemodulation.wav', x2_afterModulation, fs);