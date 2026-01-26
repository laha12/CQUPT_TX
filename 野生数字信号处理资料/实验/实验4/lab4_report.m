% desinged by chen zhili
% 2023-11-02
%% 01
fs = 24;
n = 0:3*fs-1;
x6 = cos(8*n*pi/fs)+cos(16*n*pi/fs)+cos(20*n*pi/fs);
figure();
subplot(411);
stem(0:length(x6)-1,x6,'filled');title("信号的时域采样波形x(n)");
% 采取1个周期的离散幅度谱
xk6_1=fft(x6,12);
subplot(412);
stem(0:length(xk6_1)-1,abs(xk6_1),'filled');title("信号的1个周期采样的DFT幅度谱");
% 采取2个周期的离散幅度谱
xk6_2 = fft(x6,24);
subplot(413);
stem(0:length(xk6_2)-1,abs(xk6_2),'filled');title("信号的2个周期采样的DFT幅度谱");
% 采取3个周期的离散幅度谱
xk6_3 = fft(x6,36);
subplot(414);
stem(0:length(xk6_3)-1,abs(xk6_3),'filled');title("信号的3个周期采样的DFT幅度谱");

%% 02
clc; clear all;
[xn,fs]=audioread('motherland.wav'); 

n=0:length(xn)-1;
dn=0.2*cos(pi*2000/fs*n); % 产生一个频率f=2000HZ的余弦信号
yn=xn'+dn; % 单频信号和语音信号叠加

subplot(221); stem((8000:8199),xn(8000:8199),'filled');
title('加噪前8000~8199点信号的时域离散波形图');
subplot(222); plot((8000:8199)/fs,xn(8000:8199));
title('加噪前8000~8199点信号的时域连续波形图');
subplot(223); stem((8000:8199),yn(8000:8199),'filled');
title('加噪后8000~8199点信号的时域离散波形图');
subplot(224); plot((8000:8199)/fs,yn(8000:8199));
title('加噪后8000~8199点信号的时域连续波形图');

figure();
N=512;
Xn=fft(xn(8000:8199),N);
Yn=fft(yn(8000:8199),N);
subplot(231); plot(2*(0:N/2-1)/N,abs(Xn(1:N/2))); 
xlabel('\omega/\pi');ylabel('|X(j\omega)|');
title('某段原始语音信号连续幅度谱（数字域）');
subplot(232); plot(fs*(0:N/2-1)/N,abs(Xn(1:N/2)));
xlabel('f(Hz)');ylabel('|X(jf)|');
title('某段原始语音信号连续幅度谱（模拟域）');
subplot(233); plot(fs*(0:N/2-1)/N,angle(Xn(1:N/2)));
xlabel('f(Hz)');ylabel('|X(jf)|');
title('某段原始语音信号连续相位谱（模拟域）');


subplot(234); plot(2*(0:N/2-1)/N,abs(Yn(1:N/2)));
xlabel('\omega/\pi');ylabel('|Y(j\omega)|');
title('加噪后某段语音信号连续幅度谱（数字域）');
subplot(235); plot(fs*(0:N/2-1)/N,abs(Yn(1:N/2)));
xlabel('f(Hz)');ylabel('|Y(jf)|');
title('加噪某段语音信号连续幅度谱（模拟域）');
subplot(236); plot(fs*(0:N/2-1)/N,angle(Yn(1:N/2)));
xlabel('f(Hz)');ylabel('|Y(jf)|');
title('加噪某段语音信号连续相位谱（模拟域）');
  
%% 思考题1
x2 = [1:4 4:-1:1];
x3 = [4:-1:1 1:4];
% 8点
xk2_8 = fft(x2,8);
subplot(411);stem(0:7,abs(xk2_8),'filled');title("信号x2(n)的8点DFT幅度谱");
xk3_8 = fft(x3,8);
subplot(412);stem(0:7,abs(xk3_8),'filled');title("信号x3(n)的8点DFT幅度谱");

xk2_16 = fft(x2,16);
subplot(413);stem(0:15,abs(xk2_16),'filled');title("信号x2(n)的16点DFT幅度谱");
xk3_16 = fft(x3,16);
subplot(414);stem(0:15,abs(xk3_16),'filled');title("信号x3(n)的16点DFT幅度谱");


%% sikaoit 2
x = [1 1 2 2 3 3 2 2 1 1];
x1 = [1 2 3 2 1];
x2 = [1 0 1 0 2 0 2 0 3 0 3 0 2 0 2 0 1 0 1];

N = 128; %统一区间长度为128，相对比较光滑
X = fft(x,N);
X1 = fft(x1,N);
X2 = fft(x2,N);

subplot(311); plot(2*(0:N-1)/N,abs(X(1:N)));
xlabel('\omega/\pi');ylabel('|X(j\omega)|');title('序列x连续幅度谱');
subplot(312); plot(2*(0:N-1)/N,abs(X1(1:N))); 
xlabel('\omega/\pi');ylabel('|X(j\omega)|');title('序列x1连续幅度谱');
subplot(313); plot(2*(0:N-1)/N,abs(X2(1:N))); 
xlabel('\omega/\pi');ylabel('|X(j\omega)|');title('序列x2连续幅度谱');








