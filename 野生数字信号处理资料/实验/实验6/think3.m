%% 设计带通滤波器
clc;clear;close all;
wp = [0.2*pi,0.6*pi];
ws = [0.15*pi,0.65*pi];
Rp = 1;
As = 45;
Fs= 4096;
%模拟滤波器指标
T = 1/Fs;
Omagp = (2/T)*tan(wp/2);
Omags = (2/T)*tan(ws/2);
ripple = 10^(-Rp/20);   % 滤波器的通带衰减对应的幅度值|H(jomaga_p)|
Attn   = 10^(-As/20);     % 滤波器的阻带衰减对应的幅度值|H(jomaga_s)|
[N,Omagc]=buttord(Omagp, Omags, Rp, As, 's');   % 滤波器的阶数N和3dB截止频率
[ba, aa] = butter(N, Omagc,'bandpass', 's');   % bandpass,即为带通滤波器
[bd, ad] = bilinear(ba, aa, Fs);    % 用双线性变换法
[H, w] = freqz(bd, ad);     %求数字系统的频率特性
dbH = 20*log10((abs(H)+eps)/max(abs(H)));
% 幅频响应
subplot(311);plot(w/pi, abs(H));    
ylabel('|H(e^{j\omega})|');xlabel('\omega/\pi');
title('幅频响应');axis([0,1,0,1.1]);
% 相频响应
subplot(312);plot(w/pi, angle(H)/pi);  
ylabel('\theta(\omega)');xlabel('\omega/\pi');
title('相频响应');axis([0,1,-1,1]);
% 幅度响应
subplot(313);plot(w/pi, dbH);title('幅度响应(dB)');axis([0,1,-40,5]);
ylabel('dB');xlabel('\omega/\pi');