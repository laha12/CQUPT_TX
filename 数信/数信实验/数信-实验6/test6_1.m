%% 问题一
clear all;
clc;
clf;
% 数字滤波器技术指标
wp=0.2*pi;
ws=0.35*pi;
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
% 可视化
subplot(2,2,1);
plot(w/pi,abs(H),'LineWidth',1.5);grid on;
ylabel('|H(e^{j\omega})|');title('幅度特性');axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn,ripple,1]);
subplot(2,2,2);
plot(w/pi,angle(H)/pi,'LineWidth',1.5);grid on;
ylabel('\phi');title('相频特性');axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);
subplot(2,2,3);
plot(w/pi,dbH,'LineWidth',1.5);grid on;
ylabel('dB');xlabel('频率(\pi)');title('衰减曲线');axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,1]);
set(gca,'YTickMode','manual','YTick',[-50,-15,-1,0]);
subplot(2,2,4);
zplane(bd,ad);grid on;axis([-1.1,1.1,-1.1,1.1]);
title('零极图');
[z,p,k]=tf2zp(bd,ad);
z
p
figure;
zplane(bd,ad);grid on;axis([-1.1,1.1,-1.1,1.1]);