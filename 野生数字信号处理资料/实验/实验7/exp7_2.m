% 实验内容 2
clc;clear;close all;
% 设定滤波器参数
wp=0.24*pi;
ws=0.3*pi;
As=60;
Rp=0.1;
h=fir_lowpass_filter(wp,ws,As); % 设计的滤波器
% 叠加高频噪声
figure;
fs=1000;
[xt,t]=xtg(fs);
yt=fftfilt(h,xt);
Hyk=abs(fft(yt));

figure;
subplot(211);plot(t/fs,yt);grid on;
xlabel('t/s');title('经过滤波器滤波后的波形');

k=0:0.5*length(Hyk)-1;
subplot(212);stem(k*fs*1/length(Hyk),1/fs*Hyk(1:0.5*length(Hyk)));grid on
xlabel('\omega/\pi(rad/s)');title('滤波后的离散幅度谱')





