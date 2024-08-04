%IIRDesign.m
%IIR滤波器设计
%数字滤波器参数
clc;clear;close all;
fm= 1600; %信号频率最大值，单位Hz
Fs = 1000;    %抽样频率
fp = 100; fs = 300; %数字低通滤波器参数
Rp = 3;         %通带波动
Rs = 20;        %阻带衰减

%冲激响应不变法，无需频率预畸变
%巴特沃斯滤波器
Wp = 2*pi*fp; Ws = 2*pi*fs;
[N,~] = buttord(Wp,Ws,Rp,Rs,'s');    %计算巴特沃斯模拟滤波器参数，'s'表示Wp和Ws都是模拟角频率
[b,a] = butter(N,Wp,'low','s');      %设计巴特沃斯低通滤波器
[H,W]=freqs(b,a);                    %W:模拟角频率，H:模拟滤波器的系统函数
mag=abs(H);                          %幅度
pha=angle(H);                        %相位
db=20*log10((mag+eps)/max(mag));     %转换为分贝
f=W/(2*pi);                          %将模拟角频率转为Hz
figure(1);
subplot(2,1,1);plot(f,db);
title('模拟原型巴特沃斯低通滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
subplot(2,1,2);plot(f,pha);
title('模拟原型巴特沃斯低通滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');
fprintf(['冲激响应不变法设计巴特沃斯滤波器的阶数：',num2str(N),'\n']);
%数字化
[B,A] = impinvar(b,a,Fs);           %冲激响应不变法
[H,W] = freqz(B,A);                 %数字滤波器系统函数
mag = abs(H);                       %幅度
pha = angle(H);                     %相位
db = 20*log10((mag+eps)/max(mag));  %转换为分贝db
f = W*Fs/(2*pi);                    %将数字角频率转换为频率Hz
figure(2);
subplot(2,1,1);plot(f,db,LineWidth=1);
title('冲激响应法设计巴特沃斯数字滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
dbindex = find(db <= -Rp,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('通带截止频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
dbindex = find(db <= -Rs,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('阻带起始频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
subplot(2,1,2);plot(f,pha,LineWidth=1);
title('冲激响应法设计巴特沃斯数字滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');

%切比雪夫滤波器
[N,~]=cheb1ord(Wp,Ws,Rp,Rs,'s');       %计算切比雪夫模拟滤波器参数，‘s’表示Wp和Ws都是模拟角频率
[b,a]=cheby1(N,Rp,Wp,'low','s');       %设计切比雪夫1低通滤波器
[H,W]=freqs(b,a);                    
mag=abs(H);                          
pha=angle(H);                       
db=20*log10((mag+eps)/max(mag));     
f=W/(2*pi);                          
figure(3);
subplot(2,1,1);plot(f,db);
title('模拟原型切比雪夫低通滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
subplot(2,1,2);plot(f,pha);
title('模拟原型切比雪夫低通滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');
fprintf(['冲激响应不变法设计切比雪夫滤波器的阶数：',num2str(N),'\n']);
%数字化
[B,A] = impinvar(b,a,Fs);           %冲激响应不变法
[H,W] = freqz(B,A);                 %数字滤波器系统函数
mag = abs(H);
pha = angle(H);
db = 20*log10((mag+eps)/max(mag));
f = W*Fs/(2*pi);
figure(4);
subplot(2,1,1);plot(f,db,LineWidth=1);
title('冲激响应法设计切比雪夫数字滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
dbindex = find(db >= -Rp,1,"last") + 1;
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('通带截止频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
dbindex = find(db <= -Rs,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('阻带起始频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
subplot(2,1,2);plot(f,pha,LineWidth=1);
title('冲激响应法设计切比雪夫数字滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');

%双线性变换法，需要频率预畸变
wp = 2*pi*fp/Fs; ws=2*pi*fs/Fs;               %转换为数字角频率技术指标
Wp = (2*Fs)*tan(wp/2);Ws =(2*Fs)*tan(ws/2);   %将数字技术指标的反畸变为模拟指标
%巴特沃斯滤波器
[N,~] = buttord(Wp,Ws,Rp,Rs,'s');              %计算巴特沃斯模拟滤波器参数， s 表示Wp和Ws都是模拟角频率
[b,a] = butter(N,Wp,'low','s');                 %设计巴特沃斯低通滤波器
fprintf(['双线性变换法设计巴特沃斯滤波器的阶数：',num2str(N),'\n']);
%数字化
[B,A] = bilinear(b,a,Fs);                       %冲激响应不变法
[H,W] = freqz(B,A);                             %数字滤波器系统函数
mag = abs(H);
pha = angle(H);
db = 20*log10((mag+eps)/max(mag));
f = W*Fs/(2*pi);
figure(5);
subplot(2,1,1);plot(f,db,LineWidth=1);
title('双线性映射法设计巴特沃斯数字滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
dbindex = find(db <= -Rp,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('通带截止频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
dbindex = find(db <= -Rs,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('阻带起始频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
subplot(2,1,2);plot(f,pha,LineWidth=1);
title('双线性映射法设计巴特沃斯数字滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');
%切比雪夫滤波器
[N,~] = cheb1ord(Wp,Ws,Rp,Rs,'s');              %计算切比雪夫模拟滤波器参数， s 表示Wp和Ws都是模拟角频率
[b,a] = cheby1(N,Rp,Wp,'low','s');              %设计切比雪夫1低通滤波器
fprintf(['双线性变换法设计切比雪夫滤波器的阶数：',num2str(N),'\n']);
%数字化
[B,A] = bilinear(b,a,Fs);                       %冲激响应不变法
[H,W] = freqz(B,A);                             %数字滤波器系统函数
mag = abs(H);
pha = angle(H);
db = 20*log10((mag+eps)/max(mag));
f = W*Fs/(2*pi);
figure(6);
subplot(2,1,1);plot(f,db,LineWidth=1);
title('双线性映射法设计切比雪夫数字滤波器幅频曲线');xlabel('频率（Hz）');ylabel('幅度（dB）');
dbindex = find(db <= -Rp,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('通带截止频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
dbindex = find(db <= -Rs,1);
dbvalue = db(dbindex);
findex = find(db==dbvalue,1);
fvalue = f(findex);
format = sprintf('阻带起始频率点(%.2f, %.2f)',fvalue,dbvalue);
text(findex,dbvalue,format);
subplot(2,1,2);plot(f,pha,LineWidth=1);
title('双线性映射法设计切比雪夫数字滤波器相频曲线');xlabel('频率（Hz）');ylabel('相位（rad）');
