%% 思考
clear all;
clc;
clf;
%% 低通滤波器
% 数字滤波器指标
wp1=0.2*pi;
ws1=0.3*pi;
Rp1=1;
As1=20;
ripple1=10^(-Rp1/20);
Attn1=10^(-As1/20);
% 转为模拟滤波器指标
Fs=10;
T=1/Fs;
Omegap1=(2/T)*tan(wp1/2); %修正
Omegas1=(2/T)*tan(ws1/2);  %修正
% 模拟滤波器设计
[N1,Omegac1]=buttord(Omegap1,Omegas1,Rp1,As1,'s');
[ba1,aa1]=butter(N1,Omegac1,'s'); %模拟低通滤波器
% 转为数字滤波器
[bd1,ad1]=bilinear(ba1,aa1,Fs);
[H1,w1]=freqz(bd1,ad1);
dbH1=20*log10((abs(H1)+eps)/max(abs(H1)));
% 可视化
subplot(2,2,1);
plot(w1/pi,abs(H1),'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('|H(e^{j\omega})|');title('幅度特性');axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn1,ripple1,1]);
subplot(2,2,2);
plot(w1/pi,angle(H1)/pi,'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('\phi');title('相频特性');axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);
subplot(2,2,3);
plot(w1/pi,dbH1,'LineWidth',1.5);grid on;
ylabel('-20lg|H(e^{j\omega})|/dB');xlabel('归一化频率');title('衰减曲线');axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickMode','manual','YTick',[-50,-20,-1,0]);
subplot(2,2,4);
zplane(bd1,ad1);grid on;axis([-1.2,1.2,-1.2,1.2]);
title('零极图');
bd1
ad1
%% 高通滤波器
% 数字滤波器参数
ws2=0.4*pi;
wp2=0.6*pi;
Rp2=2;
As2=30;
ripple2=10^(-Rp2/20);
Attn2=10^(-As2/20);
% 转为模拟滤波器指标
Fs=10;
T=1/Fs;
Omegap2=(2/T)*tan(wp2/2); %修正
Omegas2=(2/T)*tan(ws2/2);  %修正
% 模拟滤波器设计
[N2,Omegac2]=buttord(Omegap2,Omegas2,Rp2,As2,'s');
[ba2,aa2]=butter(N2,Omegac2,'high','s'); %模拟高通滤波器
% 转为数字滤波器
[bd2,ad2]=bilinear(ba2,aa2,Fs);
[H2,w2]=freqz(bd2,ad2);
dbH2=20*log10((abs(H2)+eps)/max(abs(H2)));
% 可视化
figure;
subplot(2,2,1);
plot(w2/pi,abs(H2),'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('|H(e^{j\omega})|');title('幅度特性');axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.4,0.6,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn2,ripple2,1]);
subplot(2,2,2);
plot(w2/pi,angle(H2)/pi,'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('\phi');title('相频特性');axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.4,0.6,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);
subplot(2,2,3);
plot(w2/pi,dbH2,'LineWidth',1.5);grid on;
ylabel('-20lg|H(e^{j\omega})|/dB');xlabel('归一化频率');title('衰减曲线');axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.4,0.6,1]);
set(gca,'YTickMode','manual','YTick',[-50,-30,-2,0]);
subplot(2,2,4);
zplane(bd2,ad2);grid on;axis([-1.2,1.2,-1.2,1.2]);
title('零极图');
bd2
ad2
%% 带通滤波器
wp3=[0.2*pi,0.6*pi];
ws3=[0.15*pi,0.65*pi];
Rp3=1;
As3=45;
ripple3=10^(-Rp3/20);
Attn3=10^(-As3/20);
% 转为模拟滤波器指标
Fs=10;
T=1/Fs;
Omegap3=(2/T)*tan(wp3/2); %修正
Omegas3=(2/T)*tan(ws3/2);  %修正
% 模拟滤波器设计
[N3,Omegac3]=buttord(Omegap3,Omegas3,Rp3,As3,'s');
[ba3,aa3]=butter(N3,Omegac3,'s'); %模拟带通滤波器
% 转为数字滤波器
[bd3,ad3]=bilinear(ba3,aa3,Fs);
[H3,w3]=freqz(bd3,ad3);
dbH3=20*log10((abs(H3)+eps)/max(abs(H3)));
% 可视化
figure;
subplot(2,2,1);
plot(w3/pi,abs(H3),'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('|H(e^{j\omega})|');title('幅度特性');axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.15,0.2,0.6,0.65,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn3,ripple3,1]);
subplot(2,2,2);
plot(w3/pi,angle(H3)/pi,'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('\phi');title('相频特性');axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.15,0.2,0.6,0.65,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);
subplot(2,2,3);
plot(w3/pi,dbH3,'LineWidth',1.5);grid on;
ylabel('-20lg|H(e^{j\omega})|/dB');xlabel('归一化频率');title('衰减曲线');axis([0,1,-50,5]);
set(gca,'XTickMode','manual','XTick',[0,0.15,0.2,0.6,0.65,1]);
set(gca,'YTickMode','manual','YTick',[-50,-45,-1,0]);
subplot(2,2,4);
zplane(bd3,ad3);grid on;axis([-2.1,2.1,-2.1,2.1]);
title('零极图');
%% 带阻滤波器
ws4=[0.2*pi,0.6*pi];
wp4=[0.15*pi,0.65*pi];
Rp4=1;
As4=45;
ripple4=10^(-Rp4/20);
Attn4=10^(-As4/20);
% 转为模拟滤波器指标
Fs=10;
T=1/Fs;
Omegap4=(2/T)*tan(wp4/2); %修正
Omegas4=(2/T)*tan(ws4/2);  %修正
% 模拟滤波器设计
[N4,Omegac4]=buttord(Omegap4,Omegas4,Rp4,As4,'s');
[ba4,aa4]=butter(N4,Omegac4,'stop','s'); %模拟带阻滤波器
% 转为数字滤波器
[bd4,ad4]=bilinear(ba4,aa4,Fs);
[H4,w4]=freqz(bd4,ad4);
dbH4=20*log10((abs(H4)+eps)/max(abs(H4)));
% 可视化
figure;
subplot(2,2,1);
plot(w4/pi,abs(H4),'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('|H(e^{j\omega})|');title('幅度特性');axis([0,1,0,1.1]);
set(gca,'XTickMode','manual','XTick',[0,0.15,0.2,0.6,0.65,1]);
set(gca,'YTickMode','manual','YTick',[0,Attn4,ripple4,1]);
subplot(2,2,2);
plot(w4/pi,angle(H4)/pi,'LineWidth',1.5);grid on;
xlabel('归一化频率');ylabel('\phi');title('相频特性');axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.15,0.2,0.6,0.65,1]);
set(gca,'YTickMode','manual','YTick',[-1,0,1]);
subplot(2,2,3);
plot(w4/pi,dbH4,'LineWidth',1.5);grid on;
ylabel('-20lg|H(e^{j\omega})|/dB');xlabel('归一化频率');title('衰减曲线');axis([0,1,-50,5]);
set(gca,'XTickMode','manual','XTick',[0,0.15,0.2,0.6,0.65,1]);
set(gca,'YTickMode','manual','YTick',[-50,-45,-1,0]);
subplot(2,2,4);
zplane(bd4,ad4);grid on;axis([-1.5,1.5,-1.5,1.5]);
title('零极图');