%% 问题一
%% 2-1
N=64;beta=7.865;n=1:N;
wbo=boxcar(N);
wtr=bartlett(N);
whn=hanning(N);
whm=hamming(N);
wbl=blackman(N);
wka=kaiser(N,beta);
plot(n,wbo,'-' ,n,wtr,'*' ,n,whn,'+' ,n,whm,'.',n,wbl,'o',n,wka,'d'); 
axis([0,N,0,1.1]);
legend('矩形','三角形','汉宁','哈明','布莱克曼','凯塞');
clear all;
%% 2-2
% 滤波器参数
wp=0.3*pi;
ws=0.45*pi;
deltaw=ws-wp;
wc=(ws+wp)/2;
% 窗函数设计
N0=ceil(6.6*pi/deltaw);%因为衰减要达到50dB,则应该尽可能往大的选，选择哈明窗
N=N0+mod(N0+1,2);
windows=(hamming(N))';
% 逼近滤波器单位脉冲相应，用理想低通近似
hd=ideal_lp(wc,N);
b=hd.*windows;%截断
% 频谱求解及分析
M=1000;
[H,w]=freqz(b,1,M,'whole');%零点b,极点1,1000点的频谱；
H=(H(1:M/2+1))';
w=(w(1:M/2+1))';
mag=abs(H);
phi=angle(H);
db=20*log10((mag+eps)/max(mag));%衰减函数
n=0:N-1;
dw=2*pi/1000;
Rp=-(min(db(1:(wp/dw+1))));%求通带最大衰减
As=-round(max(db(ws/dw+1:M/2+1)));%求阻带最小衰减
% 可视化
figure;
subplot(2,2,1);
stem(n,b);grid on;axis([0,N,1.1*min(b),1.1*max(b)]);
xlabel('n');title('滤波器的脉冲响应');
subplot(2,2,2);
stem(n,windows);grid on;axis([0,N,0,1.1]);
xlabel('n');title('窗函数');
subplot(2,2,3);
plot(2*(0:M/2)/M,db);grid on;axis([0,1,-80,10]);
xlabel('\omega/\pi');ylabel('-20lg|H(e^{j\omega})|');title('滤波器衰减曲线');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'XTickMode','manual','YTick',[-50,-20,-3,0]);
subplot(2,2,4);
plot(2*(0:M/2)/M,phi);grid on;axis([0,1,-4,4]);
xlabel('\omega/\pi');ylabel('\phi');title('滤波器相频响应曲线');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'XTickMode','manual','YTick',[-3.1416,0,3.1416,4]);
clear all;
%% 2-3
% 滤波器参数
wp=0.3*pi;
ws=0.45*pi;
deltaw=ws-wp;
wc=(ws+wp)/2/pi;
% 窗函数设计
N0=ceil(6.6*pi/deltaw);%因为衰减要达到50dB,则应该尽可能往大的选，选择哈明窗
N=N0+mod(N0+1,2);
windows=(hamming(N));
% 用fir1求解
b=fir1(N-1,wc,windows);
% 频谱求解及分析
M=1000;
[H,w]=freqz(b,1,M,'whole');%零点b,极点1,1000点的频谱；
H=(H(1:M/2+1))';
w=(w(1:M/2+1))';
mag=abs(H);
phi=angle(H);
db=20*log10((mag+eps)/max(mag));%衰减函数
n=0:N-1;
dw=2*pi/1000;
Rp=-(min(db(1:(wp/dw+1))));%求通带最大衰减
As=-round(max(db(ws/dw+1:M/2+1)));%求阻带最小衰减
% 可视化
figure;
subplot(2,2,1);
stem(n,b);grid on;axis([0,N,1.1*min(b),1.1*max(b)]);
xlabel('n');title('滤波器的脉冲响应');
subplot(2,2,2);
stem(n,windows);grid on;axis([0,N,0,1.1]);
xlabel('n');title('窗函数');
subplot(2,2,3);
plot(2*(0:M/2)/M,db);grid on;axis([0,1,-80,10]);
xlabel('\omega/\pi');ylabel('-20lg|H(e^{j\omega})|');title('滤波器衰减曲线');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'XTickMode','manual','YTick',[-50,-20,-3,0]);
subplot(2,2,4);
plot(2*(0:M/2)/M,phi);grid on;axis([0,1,-4,4]);
xlabel('\omega/\pi');ylabel('\phi');title('滤波器相频响应曲线');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'XTickMode','manual','YTick',[-3.1416,0,3.1416,4]);