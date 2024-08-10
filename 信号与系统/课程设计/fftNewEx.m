%fftNew.m
function Y = fftNewEx(X)
%自己实现的MATLAB中的fft程序。这个程序只能计算N=2^n个点。
if length(X) == 2
    Y = zeros(1,2);
    Y(1) = X(1)+X(2);
    Y(2) = X(1)-X(2);
else
    N = 2^floor(log2(length(X)));
    X = X(1:N);  %这两句讲的是，将X的长度变为2^n.
    X1 = X(1:2:N);
    X2 = X(2:2:N);%这两句说的是，假设N=8,那么第一句取了x[1,3,5,7],第二句取了x[2,4,6,8].
    Y1 = fftNew(X1);
    Y2 = fftNew(X2);%这两句是递归。
    
    %下面这一段讲的就是合并两个四点FFT
    Y = zeros(1,N);
    for k = 2:N/2
        Y2(k) = Y2(k)*exp(-1j*2*pi*(k-1)/N);
    end
    for k = 1:N/2
        Y(k) = Y1(k) +Y2(k);
        Y(k+N/2) = Y1(k) - Y2(k); 
    end
end
end

