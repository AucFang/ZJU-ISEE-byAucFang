clear;
s = tf('s');
Hs = 50/((s+1)*(s+5)*(s-2));
sys = tf(Hs/(1+Hs));
nyquist(tf(Hs));
impulse(sys);
