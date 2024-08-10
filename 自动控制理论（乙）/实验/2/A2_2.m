clear;
s = tf('s');
Gs = (s+1)/((s+2)*(s^2+4*s+5));
bode(tf(Gs));