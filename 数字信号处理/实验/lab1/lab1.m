clc;clear;
% x(n)=cos⁡(0.24πn)+cos⁡(0.36πn)
N = 10;
n = 1:1:N;
x = [cos(0.24*pi.*n) + cos(0.36*pi.*n),zeros(1,100-N)];
X = fft(x,N);       %10点DFT
figure(1)
subplot(3,1,1);stem(1:1:N,x(1:N),'.');title('N=10,x[n]');
subplot(3,1,2);stem(-pi:2*pi/length(X):pi-2*pi/length(X),abs(X),'.');xlim([-pi pi]);title('10点DFT,|X(k)|');
subplot(3,1,3);stem(-pi:2*pi/length(X):pi-2*pi/length(X),angle(X),'.');xlim([-pi pi]);title('10点DFT,angle(X(k))');
X = fft(x);     %100点DFT
figure(2)
subplot(3,1,1);stem(1:1:N,x(1:N),'.');title('N=10,x[n]');
subplot(3,1,2);stem(-pi:2*pi/length(X):pi-2*pi/length(X),abs(X),'.');xlim([-pi pi]);title('100点DFT,|X(k)|');
subplot(3,1,3);stem(-pi:2*pi/length(X):pi-2*pi/length(X),angle(X),'.');xlim([-pi pi]);title('100点DFT,angle(X(k))');

N = 100;
n = 1:1:N;
x = [cos(0.24*pi.*n) + cos(0.36*pi.*n),zeros(1,100-N)];
X = fft(x,N);    %100点DFT
figure(3)
subplot(3,1,1);stem(1:1:N,x(1:N),'.');title('N=100,x[n]');
subplot(3,1,2);stem(-pi:2*pi/N:pi-2*pi/N,abs(X),'.');xlim([-pi pi]);title('100点DFT,|X(k)|');
subplot(3,1,3);stem(-pi:2*pi/N:pi-2*pi/N,angle(X),'.');xlim([-pi pi]);title('100点DFT,angle(X(k))');

T = 0.000625;N = 32; %第一组谱分析参数
%T = 0.005;N = 32;    %第二组谱分析参数
%T = 0.0046875;N = 32;%第三组谱分析参数
%T = 0.004;N = 32;    %第四组谱分析参数
%T = 0.0025;N = 16;   %第五组谱分析参数
t = 0:0.001:N*T; xt = sin(2*pi*50*t);  %原始信号
n = 0:N-1; xn = sin(2*pi*50*n*T); %抽样结果
X = fft(xn,N);

figure(4); % 时域图像
subplot(2,1,1); plot(t,xt); xlim([0 N*T]);
xlabel('t'); ylabel('x(t)'); title('原信号');
subplot(2,1,2); stem(n,xn,'.');xlim([0 N]);
xlabel('n'); ylabel('x(n)'); title('抽样结果');

figure(5); % 序列频谱
subplot(4,1,1); stem(n,abs(X),'.'); xlim([0 N]); 
xlabel('k'); ylabel('|X|'); title('幅度谱');
max_value = max(abs(X)); % 最大值
max_index = find(abs(X)==max_value); % 寻找最大值的索引
index = max_index(1); % 取第一个最大值的索引
format = sprintf('(%d, %.2f)',(index-1),max_value); 
text((index-1),max_value,format);
subplot(4,1,2); stem(n,real(X),'.'); xlim([0 N]);
xlabel('k'); ylabel('Re\{X\}'); title('频谱实部');
subplot(4,1,3); stem(n,imag(X),'.'); xlim([0 N]);
xlabel('k'); ylabel('Im\{X\}'); title('频谱虚部');
subplot(4,1,4); stem(n,angle(X),'.'); xlim([0 N]);
xlabel('k'); ylabel('angle(X)'); title('频谱相位');