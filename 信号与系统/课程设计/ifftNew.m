%ifftNew.m
function Y = ifftNew(X)
    not2N = 0;
    Xlen = length(X);
if length(X) == 2
    Y = zeros(1,2);
    Y(1) = X(1)+X(2);
    Y(2) = X(1)-X(2);
else
    if bitand(length(X),(length(X)-1)) ~= 0     %判断序列的长度是否为2的n次幂
        not2N = 1;
        if length(X)<= 2^15
            N = 2^floor(log2(length(X))+4);         %如果不是，就补0至2的n次幂
        elseif length(X)<= 2^17
            N = 2^floor(log2(length(X))+2);
        else
            N = 2^floor(log2(length(X))+1);
        end
        X = [X,zeros(1,N-length(X))];           
    else 
        N = Xlen;
    end
    X1 = X(1:2:N);
    X2 = X(2:2:N);
    Y1 = ifftNew(X1);
    Y2 = ifftNew(X2);
    
    Y = zeros(1,N);
    for k = 2:N/2
        Y2(k) = Y2(k)*exp(1j*2*pi*(k-1)/N);
    end
    for k = 1:N/2
        Y(k) = Y1(k) +Y2(k);
        Y(k+N/2) = Y1(k) - Y2(k);
    end
end
Y= Y/2;
if not2N == 1
        Amp =  N/Xlen;             
        Ytemp = Y;
        Y1 = Y(1);
        Y = zeros(1,Xlen);
        Y(1) = Y1*Amp;
       for i = 2:1:Xlen
            x3 = length(Ytemp)*(i-1)/Xlen+1;
            x1 = floor(length(Ytemp)*(i-1)/Xlen+1);
            x2 = x1 + 1;
            Y(i) = (Ytemp(x1) +(Ytemp(x1)-Ytemp(x2))/(x1-x2)*(x3-x1))*Amp;
       end
end
end