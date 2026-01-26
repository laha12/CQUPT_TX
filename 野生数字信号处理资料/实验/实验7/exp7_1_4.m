% 调用自编函数，设计一个FIR低通滤波器
% wp = 0.24*pi;ws = 0.3*pi;As = 60.0;Rp = 0.1;
wp = 0.24*pi; 
ws = 0.3*pi;
As = 60.0;
Rp = 0.1;
h = fir_lowpass_filter(wp,ws,As);