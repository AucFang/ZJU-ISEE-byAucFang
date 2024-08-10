clear;
a = 44;
b = 36;
l = 40;
for m = 0:1:200
    for n = 0:1:200
        for p = 0:1:200
            if 2/sqrt((m/a)^2+(n/b)^2+(p/l)^2)>12.15 && 2/sqrt((m/a)^2+(n/b)^2+(p/l)^2)<12.34
                fprintf('m = %d, n = %d, p = %d \n',m,n,p);
            end
        end
    end
    
end
disp('输出各存储单元的数据：'),Xk = A;
disp('调用FFT函数运算的结果：'),fftxn = fft(xn,N);