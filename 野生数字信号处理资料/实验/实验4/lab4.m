% desinged by chen zhili
% 2023-11-02
%% 对信号x1(n)~ x5(n)分别做8点、16点和32点的DFT，信号的时域和离散幅度谱放在一个figure中
% x1(n)
figure(1);
x1 = [1 1 1 1];
fft8_16_32(x1);
% x2(n)
figure(2);
x2 = [1:4 4:-1:1];
fft8_16_32(x2);
% x3(n)
figure(3);
x3 = [4:-1:1 1:4];
fft8_16_32(x3);
% x4(n)
figure(4);
n = 0:31;
x4 = cos(pi/4*n);   %x4(n)周期为8，对x4(n)分别做8点、16点和32点的DFT，截取4个周期32点
fft8_16_32(x4);
% x5(n)
figure(5);
x5 = cos(pi/8*n);   %x5(n)周期为16，对x5(n)分别做8点、16点和32点的DFT，截取2个周期32点
fft8_16_32(x5);
%% 对信号x6（n）进行采样分析 
% fs=64Hz
fs=64;
n=0:63;
x6=cos(8*pi*n/fs)+cos(16*pi*n/fs)+cos(20*pi*n/fs);
figure(6)
subplot(411);stem(0:length(x6)-1,x6,'filled');title("信号的时域波形x(n)");
% 16点
xk_16 = fft(x6,16);
subplot(412);stem(0:15,abs(xk_16),'filled');title("信号的16点DFT幅度谱");
% 32点
xk_32 = fft(x6,32);
subplot(413);stem(0:31,abs(xk_32),'filled');title("信号的32点DFT幅度谱");
% 64点
xk_64 = fft(x6,64);
subplot(414);stem(0:63,abs(xk_64),'filled');title("信号的64点DFT幅度谱");

% fs = 30Hz
figure(7);
fs = 30;% 采样后序列周期为N=15，截取两个周期
n = 0:29;
x6 = cos(8*n*pi/fs)+cos(16*n*pi/fs)+cos(20*n*pi/fs);
subplot(211);stem(0:length(x6)-1,x6,'filled');title("信号的时域采样波形x(n)");
% 30点
xk_30 = fft(x6,30);
subplot(212);stem(abs(xk_30),'filled');title("信号的30点DFT幅度谱");

%% 对音频信号进行谱分析
[xn, fs] = audioread('motherland.wav');
N=512;
figure();
subplot(411);stem(8000:8199,xn(8000:8199),'filled');title("离散时域波形图x(n)");
subplot(412);plot(8000:8199,xn(8000:8199));title("连续时域波形图x(n)");
% 对这200个点做512的DFT，用FFT实现
xk = fft(xn(8000:8199),N);
k=(0:N-1)/N;
subplot(413);plot(2*k,abs(xk(1:N)));xlabel('\omega(rad)');
subplot(414);plot(2*k,angle(xk(1:N)));xlabel('\omega(rad)');
%% 画出motherland.wav的8000~8199点的模拟域[0,fs/2)连续幅度谱和相位谱图。

n=0:length(xn)-1;
dn=0.2*cos(pi*2000/fs*n);% 产生一个频率f=2000HZ的余弦信号
yn=xn'+dn; % 单频信号和语音信号委加
figure;
Yn=fft(yn(8080:8199),N);
subplot(321);stem((8000:8199),xn(8000:8199))
subplot(322);plot((8000:8199)/fs,xn(8000:8199));
subplot(323); plot(2*(0:N/2-1)/N,abs(Yn(1:N/2))); xlabel('\omega');ylabel('Y()');title("某语音信号连续幅度谱");
subplot(324); plot(2*(0:N/2-1)/N,angle(Yn(1:N/2)));xlabel('\omega');ylabel('phase');title("某段语音信号连续相位谱");

subplot(325);plot(fs*(0:N/2-1)/N,abs(Yn(1:N/2))); xlabel('f(Hz)');ylabel(' Y(f)');title("某段语音信号连续幅度谱")
subplot(326); plot(fs*(0:N/2-1)/N,angle(Yn(1:N/2)));xlabel('f(Hz)');ylabel('phase');title("某语音信号连续相位谱");

