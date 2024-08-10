%L2Q1
t=0:0.01:10;
omega_n=6;
figure(1);
hold on;
Yt=[];
for i=1:1:9
    theta=0.1*i;
    for n=1:1:1001
    Yt(n)=1-(1/sqrt(1-theta^2))*exp(-theta*omega_n*t(n))*sin(omega_n*sqrt(1-theta^2)*t(n)+acos(theta));
    end
    plot(t,Yt);
    xlabel('t');
    ylabel('Y(t)');
end
for n=1:1:1001
    Yt(n)=1-exp(-omega_n*t(n))*(1+omega_n*t(n));
end
plot(t,Yt);
xlabel('t');
ylabel('Y(t)');
theta=2;
T1=1/(omega_n*(theta+sqrt(1-theta^2)));
T2=1/(omega_n*(theta-sqrt(1-theta^2)));
for n=1:1:1001
    Yt(n)=1+exp(-t(n)/T1)/(T2/T1-1)+exp(-t(n)/T2)/(T1/T2-1);
end
plot(t,Yt);
xlabel('t');
ylabel('Y(t)');
hold off;
theta=0.7;
figure(2);
hold on;
for i=1:1:6
    omega_n=2*i;
    for n=1:1:1001
        Yt(n)=1-(1/sqrt(1-theta^2))*exp(-theta*omega_n*t(n))*sin(omega_n*sqrt(1-theta^2)*t(n)+acos(theta));
    end
    plot(t,Yt);
    xlabel('t');
    ylabel('Y(t)');
end
hold off;
