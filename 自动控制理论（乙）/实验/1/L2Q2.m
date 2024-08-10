omega_n=1;
theta=0.5;
Tr=(pi-acos(theta))/(omega_n*sqrt(1-theta^2))
Tp=pi/(omega_n*sqrt(1-theta^2))
sigma=exp(-theta*pi/sqrt(1-theta^2))
Ts=abs(log(0.05*sqrt(1-theta^2))/(theta*omega_n))
t=0:0.01:20;
Yt=[];
for n=1:1:2001
    Yt(n)=1-(1/sqrt(1-theta^2))*exp(-theta*omega_n*t(n))*sin(omega_n*sqrt(1-theta^2)*t(n)+acos(theta));
end 
plot(t,Yt);