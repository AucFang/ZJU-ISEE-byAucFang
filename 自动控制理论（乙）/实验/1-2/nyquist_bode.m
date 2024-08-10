num = [1];
den = [0.2 0.9 1 0];
sys = tf(num,den);
bode(sys);
