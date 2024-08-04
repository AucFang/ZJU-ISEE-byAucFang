%DTMF.m
%DTMF编码
clc;clear;close all;
fl = [697 770 852 941];      %低频频率
fh = [1209 1336 1477 1633];  %高频频率
SNR = 15;                    %信噪比
Fs = 8000;                   %采样频率8kHz
N = 440;                     %8000Hz采样率下100ms内有800个点，信号采样点在360~440之间
n = 0:N-1;
x=[];
numString='123456789';%要转换的号码
%生成编码信号 
for i = 1:length(numString)
    switch numString(i)
        case'1'
            freq_low=fl(1);freq_hgh=fh(1);
        case'2'
            freq_low=fl(1);freq_hgh=fh(2);
        case'3'
            freq_low=fl(1);freq_hgh=fh(3);
        case'4'
            freq_low=fl(2);freq_hgh=fh(1);
        case'5'
            freq_low=fl(2);freq_hgh=fh(2);
        case'6'
            freq_low=fl(2);freq_hgh=fh(3);
        case'7'
            freq_low=fl(3);freq_hgh=fh(1);
        case'8'
            freq_low=fl(3);freq_hgh=fh(2);
        case'9'
            freq_low=fl(3);freq_hgh=fh(3);
        case'0'
            freq_low=fl(4);freq_hgh=fh(2);
        case'*'
            freq_low=fl(4);freq_hgh=fh(1);
        case'#'
            freq_low=fl(3);freq_hgh=fh(3);
        otherwise
            error('naive!');
    end
    xi = sin(2*pi*freq_low/Fs*n) + sin(2*pi*freq_hgh/Fs*n);
    xi = [xi,zeros(1,800-N)];   %#ok<*AGROW> %留出静音
    x = [x,xi];                 %将每个按键串在一起
end
x = awgn(x,SNR);                %加入白噪声
figure(1);
plot(x);xlabel('n');ylabel('DTMF编码信号x[n]');title('DTMF编码结果');
%使用FFT进行解码
decode_x_FFT = [];
for i = 1:length(numString)
    xi = x((i-1)*800+1:1:(i-1)*800+N);
    X = fft(xi);
    X = fftshift(X);        %转移到[-pi,pi]的对称区间内
    figure(i+1);
    plot(Fs/N*(-N/2:N/2-1),abs(X));
    xlabel('f(Hz)');ylabel('Abs(X)');
    title(['第',num2str(i),'个字符的DTMF信号频谱']);
    Xtmp = X(N/2+1:N);      %截取正半轴序列，寻找两处峰值对应的频率即为DTMF信号的两个基频
    F1value = max(abs(Xtmp));
    F1index = find(abs(Xtmp)==F1value);
    Xtmp(F1index) = 0;
    F2value = max(abs(Xtmp));
    F2index = find(abs(Xtmp)==F2value);
    freq1 = (F1index+N/2-1)*Fs/N-Fs/2;
    freq2 = (F2index+N/2-1)*Fs/N-Fs/2;
    fHigh = max(freq2,freq1);%高频信号
    fLow = min(freq2,freq1);%低频信号
%     format = '第%d个信号FFT分解结果(fh,fl) = (%.2f,%.2f)\n';
%     fprintf(format,i,fHigh,fLow);
    if (abs(fHigh - fh(1))/fh(1) <= 0.035)      %判断误差并解码
        if(abs(fLow - fl(1))/fl(1) <= 0.035)
            decode_x_FFT(i) = '1';
        elseif(abs(fLow - fl(2))/fl(2) <= 0.035)
            decode_x_FFT(i) = '4';
        elseif(abs(fLow - fl(3))/fl(3) <= 0.035)
            decode_x_FFT(i) = '7';
        elseif(abs(fLow - fl(4))/fl(4) <= 0.035)
            decode_x_FFT(i) = '*'; %#ok<*SAGROW> 
        else
            decode_x_FFT(i) = '?';
            fprintf(['FFT:第',num2str(i),'个字符解码错误:低频信号超出最大允许频率误差\n']);
        end
    elseif (abs(fHigh - fh(2))/fh(2) <= 0.035)
        if(abs(fLow - fl(1))/fl(1) <= 0.035)
            decode_x_FFT(i) = '2';
        elseif(abs(fLow - fl(2))/fl(2) <= 0.035)
            decode_x_FFT(i) = '5';
        elseif(abs(fLow - fl(3))/fl(3) <= 0.035)
            decode_x_FFT(i) = '8';
        elseif(abs(fLow - fl(4))/fl(4) <= 0.035)
            decode_x_FFT(i) = '0';
        else
            decode_x_FFT(i) = '?';
            fprintf(['FFT:第',num2str(i),'个字符解码错误:低频信号超出最大允许频率误差\n']);
        end
    elseif (abs(fHigh - fh(3))/fh(3) <= 0.035)
        if(abs(fLow - fl(1))/fl(1) <= 0.035)
            decode_x_FFT(i) = '3';
        elseif(abs(fLow - fl(2))/fl(2) <= 0.035)
            decode_x_FFT(i) = '6';
        elseif(abs(fLow - fl(3))/fl(3) <= 0.035)
            decode_x_FFT(i) = '9';
        elseif(abs(fLow - fl(4))/fl(4) <= 0.035)
            decode_x_FFT(i) = '#';
        else
            decode_x_FFT(i) = '?';
            fprintf(['FFT:第',num2str(i),'个字符解码错误:低频信号超出最大允许频率误差\n']);
        end
    else
        decode_x_FFT(i) = '?';
        fprintf(['FFT:第',num2str(i),'个字符解码错误:高频信号超出最大允许频率误差\n']);
    end
end
fprintf(['N = ',num2str(N),',']);
fprintf(['FFT解码结果:',decode_x_FFT,'\n']);
%使用Goertzel算法进行解码
k = [18 20 22 24 31 34 38 42];      %一次谐波的离散频率点
k2 = [35 39 43 47 61 67 74 82];     %二次谐波的离散频率点
N1 = 205;                           %一次谐波的FFT点数N1
N2 = 201;                           %二次谐波的FFT点数N2
W_N1 = exp(-1j*2*pi/N1);
W_N2 = exp(-1j*2*pi/N2);
decode_x_Gtl = [];
for i = 1:length(numString)
    xi = x((i-1)*800+1:1:(i-1)*800+N); %分段截取原始信号
    if N1 <=N                          %x1,x2分别为分析一次谐波和二次谐波时的输入序列
        x1 = xi(1:N1);                 %根据N和N1,N2的关系进行截断或补0
    else
        x1 = [xi,zeros(1,N1-N)];
    end
    if N2 <=N
        x2 = xi(1:N2);
    else
        x2 = [xi,zeros(1,N2-N)];
    end
    yk_697_1 = filter([1 -W_N1^k(1)],[1 -2*cos(2*pi*k(1)/N1) 1],x1);    %对每一段信号进行一次谐波和二次谐波的滤波
    yk_697_2 = filter([1 -W_N2^k2(1)],[1 -2*cos(2*pi*k2(1)/N2) 1],x2);
    yk_770_1 = filter([1 -W_N1^k(2)],[1 -2*cos(2*pi*k(2)/N1) 1],x1);
    yk_770_2 = filter([1 -W_N2^k2(2)],[1 -2*cos(2*pi*k2(2)/N2) 1],x2);
    yk_852_1 = filter([1 -W_N1^k(3)],[1 -2*cos(2*pi*k(3)/N1) 1],x1);
    yk_852_2 = filter([1 -W_N2^k2(3)],[1 -2*cos(2*pi*k2(3)/N2) 1],x2);
    yk_941_1 = filter([1 -W_N1^k(4)],[1 -2*cos(2*pi*k(4)/N1) 1],x1);
    yk_941_2 = filter([1 -W_N2^k2(4)],[1 -2*cos(2*pi*k2(4)/N2) 1],x2);
    yk_1209_1 = filter([1 -W_N1^k(5)],[1 -2*cos(2*pi*k(5)/N1) 1],x1);
    yk_1209_2 = filter([1 -W_N2^k2(5)],[1 -2*cos(2*pi*k2(5)/N2) 1],x2);
    yk_1336_1 = filter([1 -W_N1^k(6)],[1 -2*cos(2*pi*k(6)/N1) 1],x1);
    yk_1336_2 = filter([1 -W_N2^k2(6)],[1 -2*cos(2*pi*k2(6)/N2) 1],x2);
    yk_1477_1 = filter([1 -W_N1^k(7)],[1 -2*cos(2*pi*k(7)/N1) 1],x1);
    yk_1477_2 = filter([1 -W_N2^k2(7)],[1 -2*cos(2*pi*k2(7)/N2) 1],x2);
    %yk_1633_1 = filter([1 -W_N1^k(8)],[1 -2*cos(2*pi*k(8)/N1) 1],x1);
    %yk_1633_2 = filter([1 -W_N2^k2(8)],[1 -2*cos(2*pi*k2(8)/N2) 1],x2);
    if (abs(yk_697_1(N1))^2 >= 1000) && (abs(yk_697_2(N2))^2 <= 1000)
        if (abs(yk_1209_1(N1))^2 >= 1000) && (abs(yk_1209_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '1';
        elseif (abs(yk_1336_1(N1))^2 >= 1000) && (abs(yk_1336_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '2';
        elseif (abs(yk_1477_1(N1))^2 >= 1000) && (abs(yk_1477_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '3';
        else 
            decode_x_Gtl(i) = '?';
            fprintf(['Goertzel:第',num2str(i),'个字符解码错误:当前频率下找不到对应键，高频错误\n']);
        end
    elseif (abs(yk_770_1(N1))^2 >= 1000) && (abs(yk_770_2(N2))^2 <= 1000)
        if (abs(yk_1209_1(N1))^2 >= 1000) && (abs(yk_1209_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '4';
        elseif (abs(yk_1336_1(N1))^2 >= 1000) && (abs(yk_1336_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '5';
        elseif (abs(yk_1477_1(N1))^2 >= 1000) && (abs(yk_1477_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '6';
        else 
            decode_x_Gtl(i) = '?';
            fprintf(['Goertzel:第',num2str(i),'个字符解码错误:当前频率下找不到对应键，高频错误\n']);
        end
    elseif (abs(yk_852_1(N1))^2 >= 1000) && (abs(yk_852_2(N2))^2 <= 1000)
        if (abs(yk_1209_1(N1))^2 >= 1000) && (abs(yk_1209_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '7';
        elseif (abs(yk_1336_1(N1))^2 >= 1000) && (abs(yk_1336_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '8';
        elseif (abs(yk_1477_1(N1))^2 >= 1000) && (abs(yk_1477_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '9';
        else 
            decode_x_Gtl(i) = '?';
            fprintf(['Goertzel:第',num2str(i),'个字符解码错误:当前频率下找不到对应键，高频错误\n']);
        end
    elseif (abs(yk_941_1(N1))^2 >= 1000) && (abs(yk_941_2(N2))^2 <= 1000)
        if (abs(yk_1209_1(N1))^2 >= 1000) && (abs(yk_1209_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '*';
        elseif (abs(yk_1336_1(N1))^2 >= 1000) && (abs(yk_1336_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '0';
        elseif (abs(yk_1477_1(N1))^2 >= 1000) && (abs(yk_1477_2(N2))^2 <= 1000)
            decode_x_Gtl(i) = '#';
        else 
            decode_x_Gtl(i) = '?';
            fprintf(['Goertzel:第',num2str(i),'个字符解码错误:当前频率下找不到对应键，高频错误\n']);
        end
    else 
        decode_x_Gtl(i) = '?';
        fprintf(['Goertzel:第',num2str(i),'个字符解码错误:当前频率下找不到对应键，低频错误\n']);
    end
end
fprintf(['N = ',num2str(N),',']);
fprintf(['Goetrzel解码结果:',decode_x_Gtl,'\n']);
