%% 思考
clear all;
clc;
clf;
%% 数字低通滤波器
% 滤波器参数
wp1=0.2*pi;
ws1=0.3*pi;
deltaw1=ws1-wp1;
wc1=(ws1+wp1)/2/pi;
% 窗函数设计
N0_1=ceil(6.1*pi/deltaw1);%因为衰减要达到24dB,则应该尽可能往大的选，选择三角形窗
N1=N0_1+mod(N0_1+1,2);
windows1=(bartlett(N1))';
% 采用fir1设计
b1=fir1(N1-1,wc1,windows1);
% 频谱求解及分析
M=1000;
[H1,w1]=freqz(b1,1,M,'whole');%零点b,极点1,1000点的频谱；
H1=(H1(1:M/2+1))';
w1=(w1(1:M/2+1))';
mag1=abs(H1);
phi1=angle(H1);
db1=20*log10((mag1+eps)/max(mag1));%衰减函数
n1=0:N1-1;
dw=2*pi/M;
Rp1=-(min(db1(1:(wp1/dw+1))));%求通带最大衰减
As1=-round(max(db1(ws1/dw+1:M/2+1)));%求阻带最小衰减
% 可视化
subplot(2,2,1);
stem(n1,b1);grid on;axis([0,N1,1.1*min(b1),1.1*max(b1)]);
xlabel('n');title('滤波器的脉冲响应');
subplot(2,2,2);
plot(w1/pi,mag1);grid on;axis([0,1,0,1.1]);
xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');title('系统幅频特性曲线');
set(gca,'XTickMode','manual','XTick',[0,wp1/pi,ws1/pi,1]);
subplot(2,2,3);
plot(2*(0:M/2)/M,db1);grid on;axis([0,1,-50,10]);
xlabel('\omega/\pi');ylabel('-20lg|H(e^{j\omega})|');title('滤波器衰减曲线');
set(gca,'XTickMode','manual','XTick',[0,wp1/pi,ws1/pi,1]);
set(gca,'XTickMode','manual','YTick',[-24,-20,-1,0]);
subplot(2,2,4);
plot(2*(0:M/2)/M,phi1);grid on;axis([0,1,-4,4]);
xlabel('\omega/\pi');ylabel('\phi');title('滤波器相频响应曲线');
set(gca,'XTickMode','manual','XTick',[0,wp1/pi,ws1/pi,1]);
set(gca,'XTickMode','manual','YTick',[-3.1416,0,3.1416,4]);
%% 数字高通滤波器
% 滤波器参数
wp2=0.6*pi;
ws2=0.4*pi;
deltaw2=wp2-ws2;
wc2=(ws2+wp2)/2/pi;
% 窗函数设计
N0_2=ceil(6.2*pi/deltaw2);%因为衰减要达到44dB,则应该尽可能往大的选，选择汉宁窗
N2=N0_2+mod(N0_2+1,2);
windows2=hanning(N2);
% 逼近滤波器单位脉冲相应，用理想低通近似
b2=fir1(N2-1,wc2,'high',windows2);
% 频谱求解及分析
M=1000;
[H2,w2]=freqz(b2,1,M,'whole');%零点b,极点1,1000点的频谱；
H2=(H2(1:M/2+1))';
w2=(w2(1:M/2+1))';
mag2=abs(H2);
phi2=angle(H2);
db2=20*log10((mag2+eps)/max(mag2));%衰减函数
n2=0:N2-1;
dw=2*pi/M;
Rp2=-(min(db2(wp2/dw+1:M/2+1)));%求通带最大衰减
As2=-round(max(db2(1:(ws2/dw+1))));%求阻带最小衰减
% 可视化
figure;
subplot(2,2,1);
stem(n2,b2);grid on;axis([0,N2,1.1*min(b2),1.1*max(b2)]);
xlabel('n');title('滤波器的脉冲响应');
subplot(2,2,2);
plot(w2/pi,mag2);grid on;axis([0,1,0,1.1]);
xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');title('系统幅频特性曲线');
set(gca,'XTickMode','manual','XTick',[0,ws2/pi,wp2/pi,1]);
subplot(2,2,3);
plot(2*(0:M/2)/M,db2);grid on;axis([0,1,-50,10]);
xlabel('\omega/\pi');ylabel('-20lg|H(e^{j\omega})|');title('滤波器衰减曲线');
set(gca,'XTickMode','manual','XTick',[0,ws2/pi,wp2/pi,1]);
set(gca,'XTickMode','manual','YTick',[-43,-20,-0.2,0]);
subplot(2,2,4);
plot(2*(0:M/2)/M,phi2);grid on;axis([0,1,-4,4]);
xlabel('\omega/\pi');ylabel('\phi');title('滤波器相频响应曲线');
set(gca,'XTickMode','manual','XTick',[0,ws2/pi,wp2/pi,1]);
set(gca,'XTickMode','manual','YTick',[-3.1416,0,3.1416,4]);
%% 数字带通滤波器
% 滤波器参数
wlp=0.2*pi;
wls=0.15*pi;
wup=0.6*pi;
wus=0.65*pi;
deltaw3=wlp-wls;
wc3=[(wlp+wls)/2/pi,(wup+wus)/2/pi];
% 窗函数设计
N0_3=ceil(6.6*pi/deltaw3);%因为衰减要达到50dB,则应该尽可能往大的选，选择哈明窗
N3=N0_3+mod(N0_3+1,2);
windows3=hamming(N3);
% 逼近滤波器单位脉冲相应，用理想低通近似
b3=fir1(N3-1,wc3,windows3);
% 频谱求解及分析
M=1000;
[H3,w3]=freqz(b3,1,M,'whole');%零点b,极点1,1000点的频谱；
H3=(H3(1:M/2+1))';
w3=(w3(1:M/2+1))';
mag3=abs(H3);
phi3=angle(H3);
db3=20*log10((mag3+eps)/max(mag3));%衰减函数
n3=0:N3-1;
dw=2*pi/M;
Rp3=-(min(db3(wlp/dw+1:wup/dw+1)));%求通带最大衰减
As3=-round(max(max(db3(1:wls/dw+1)),max(db3(wus/dw+1:M/2+1))));%求阻带最小衰减
% 可视化
figure;
subplot(2,2,1);
stem(n3,b3);grid on;axis([0,N3,1.1*min(b3),1.1*max(b3)]);
xlabel('n');title('滤波器的脉冲响应');
subplot(2,2,2);
plot(w3/pi,mag3);grid on;axis([0,1,0,1.1]);
xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');title('系统幅频特性曲线');
set(gca,'XTickMode','manual','XTick',[0,wls/pi,wlp/pi,wup/pi,wus/pi,1]);
subplot(2,2,3);
plot(2*(0:M/2)/M,db3);grid on;axis([0,1,-70,10]);
xlabel('\omega/\pi');ylabel('-20lg|H(e^{j\omega})|');title('滤波器衰减曲线');
set(gca,'XTickMode','manual','XTick',[0,wls/pi,wlp/pi,wup/pi,wus/pi,1]);
set(gca,'XTickMode','manual','YTick',[-50,-20,-1,0]);
subplot(2,2,4);
plot(2*(0:M/2)/M,phi3);grid on;axis([0,1,-4,4]);
xlabel('\omega/\pi');ylabel('\phi');title('滤波器相频响应曲线');
set(gca,'XTickMode','manual','XTick',[0,wls/pi,wlp/pi,wup/pi,wus/pi,1]);
set(gca,'XTickMode','manual','YTick',[-3.1416,0,3.1416,4]);
clear all；
%% 数字带阻滤波器
% 滤波器参数
wlp1=0.15*pi;
wls1=0.2*pi;
wup1=0.65*pi;
wus1=0.6*pi;
deltaw4=wls1-wlp1;
wc4=[(wlp1+wls1)/2/pi,(wup1+wus1)/2/pi];
% 窗函数设计
N0_4=ceil(6.6*pi/deltaw4);%因为衰减要达到45dB,则应该尽可能往大的选，选择哈明窗
N4=N0_4+mod(N0_4+1,2);
windows4=hamming(N4);
% 逼近滤波器单位脉冲相应，用理想低通近似
b4=fir1(N4-1,wc4,'stop',windows4);
% 频谱求解及分析
M=1000;
[H4,w4]=freqz(b4,1,M,'whole');%零点b,极点1,1000点的频谱；
H4=(H4(1:M/2+1))';
w4=(w4(1:M/2+1))';
mag4=abs(H4);
phi4=angle(H4);
db4=20*log10((mag4+eps)/max(mag4));%衰减函数
n4=0:N4-1;
dw=2*pi/M;
Rp4=-(min(min(db4(1:(wlp1/dw+1))),min(db4((wup1/dw+1):(M/2+1)))));%求通带最大衰减
As4=-round(max(db4((wls1/dw+1):(wus1/dw+1))));%求阻带最小衰减
% 可视化
figure;
subplot(2,2,1);
stem(n4,b4);grid on;axis([0,N4,1.1*min(b4),1.1*max(b4)]);
xlabel('n');title('滤波器的脉冲响应');
subplot(2,2,2);
plot(w4/pi,mag4);grid on;axis([0,1,0,1.1]);
xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');title('系统幅频特性曲线');
set(gca,'XTickMode','manual','XTick',[0,wlp1/pi,wls1/pi,wus1/pi,wup1/pi,1]);
subplot(2,2,3);
plot(2*(0:M/2)/M,db4);grid on;axis([0,1,-60,10]);
xlabel('\omega/\pi');ylabel('-20lg|H(e^{j\omega})|');title('滤波器衰减曲线');
set(gca,'XTickMode','manual','XTick',[0,wlp1/pi,wls1/pi,wus1/pi,wup1/pi,1]);
set(gca,'XTickMode','manual','YTick',[-45,-20,-1,0]);
subplot(2,2,4);
plot(2*(0:M/2)/M,phi4);grid on;axis([0,1,-4,4]);
xlabel('\omega/\pi');ylabel('\phi');title('滤波器相频响应曲线');
set(gca,'XTickMode','manual','XTick',[0,wlp1/pi,wls1/pi,wus1/pi,wup1/pi,1]);
set(gca,'XTickMode','manual','YTick',[-3.1416,0,3.1416,4]);