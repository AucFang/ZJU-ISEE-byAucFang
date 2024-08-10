
T = 4;
T1 = 2;

t = [-10:0.0001:10];
x = zeros(1,length(t));
for i = 1:length(t)
    if t(i)>=round(t(i)/T)*T-T1/2 & t(i)<round(t(i)/T)*T+T1/2
        x(i) = 1;
    end;
end;
subplot(2,1,1);
plot(t,x);
axis([t(1),t(end),0,1.1]);

N = 1000;
omega = 2*pi/T;
y = sin((N+0.5)*omega*t)./sin(0.5*omega*t);
for i = 1:length(t)
    if abs(sin(0.5*omega*t(i)))<1e-3
        y(i) = 2*N+1;
    end;
end;
subplot(2,1,2);
plot(t,y);