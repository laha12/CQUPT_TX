%% 问题三
clear all;
clc;
clf;
% 音频序列
[xn,fs]=audioread('motherland.wav');
D=2;
yn1=xn(1:D:length(xn));
%% 滤波器设计
wc=pi/D;
wp=wc-0.004*pi;
ws=wc+0.015*pi;
Rp=1;
As=15;
ripple=10^(-Rp/20); %转幅度
Attn=10^(-As/20);    %转幅度
% 模拟滤波器技术指标
Fs=10;
T=1/Fs;
Omegap=(2/T)*tan(wp/2); %修正
Omegas=(2/T)*tan(ws/2);  %修正
% 模拟滤波器设计
[N,Omegac]=buttord(Omegap,Omegas,Rp,As,'s');
[ba,aa]=butter(N,Omegac,'s'); %模拟低通滤波器
% 转为数字滤波器
[bd,ad]=bilinear(ba,aa,Fs);
[H,w]=freqz(bd,ad);
dbH=20*log10((abs(H)+eps)/max(abs(H)));
% 滤波
yn=filter(bd,ad,xn);
% 采样
yn2=yn(1:D:length(yn));
% FFT
N1=10000;
Xn=1/fs*fft(xn(8000:8199),N1);
Yn1=D/fs*fft(yn1(4000:4099),N1);
Yn2=D/fs*fft(yn2(4000:4099),N1);
% 音频播放
% sound(xn,fs);
% pause(length(xn)/fs);
% sound(yn1,fs/D);
% pause(length(yn1)/fs*D);
% sound(yn2,fs/D);
% pause(length(yn2)/fs*D);
% 可视化
subplot(3,1,1);
plot((0:N1/2-1)/N1*fs,abs(Xn(1:N1/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz)');title('原始模拟域幅度谱'); grid on;
subplot(3,1,2);
plot((0:N1/2-1)/N1*fs/D,abs(Yn1(1:N1/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz)');title('未抗混叠采样模拟域幅度谱');grid on;
subplot(3,1,3);
plot((0:N1/2-1)/N1*fs/D,abs(Yn2(1:N1/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz)');title('抗混叠采样模拟域幅度谱');grid on;