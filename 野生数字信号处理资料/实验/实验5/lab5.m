% desinged by chen zhili
% 2023-11-09
%% 实验1：分析信号在不同采样频率下的频谱。
clc,clear,close all;
fs = [1000, 300, 200];  %采样率分别为1kHz、300Hz、200Hz  
tp = 64e-03;    %持续观察时间为64ms
A = 444.128;    %设置幅度
a = 50*sqrt(2)*pi;
omega = 50*sqrt(2)*pi;

for i = 1:length(fs) %分别对应不同采样频率的情况
    figure();
    subplot(221);
    t = 0:0.001:tp; 
    xt = A*exp(-a*t).*sin(omega*t); %原模拟信号
    plot(t,xt);xlabel("t/s");ylabel("xa(t)");title("模拟信号");
    % 采样信号
    N = ceil(tp*fs(i)); %采样点数N = Tp/T，结果向上取整
    n = 0:N-1;
    subplot(222);
    xn = A*exp(-a*n/fs(i)).*sin(omega*n/fs(i)); %采样信号
    stem(n,xn,'filled');xlabel("nT");ylabel("x(n)");title("采样信号");
    % 连续幅度谱和相位谱
    xk = fft(xn,1024)/fs(i);
    k = 0:length(xk)-1;
    subplot(223);
    plot(k*fs(i)/length(xk),abs(xk));xlabel('f(Hz)');ylabel("|X(j\omega)|");title("采样信号的连续幅度谱");
    subplot(224);
    plot(k*fs(i)/length(xk),angle(xk));xlabel('f(Hz)');ylabel('\theta(\omega)');title("采样信号的连续相位谱");
end

%% 实验2：产生长度为27点长的三角序列xn
clc,clear,close all;
figure();
subplot(321);
x = [1:1:14, 13:-1:1];  % 产生x(n)序列
stem(0:26,x,'.');xlabel('n');ylabel('x(n)');title("x(n)离散序列图");
% 0~2*pi内的连续幅度频谱图
subplot(322);
N = 32;
xk32 = fft(x,N);
plot(2*(0:N-1)/N,abs(xk32));xlabel('\omega/\pi');ylabel('|X(j\omega)|');title("x(n)连续幅度频谱图");
% 32点DFT和IDFT
subplot(323);
stem(0:N-1,abs(xk32),'.');xlabel('k');ylabel('|X32(k)|');title("32点DFT采样离散谱");
subplot(324);
xn32 = ifft(xk32,N);
stem(0:N-1,xn32,'.');xlabel('n');ylabel('x32(n)');title("32点IDFT离散序列图");
% 16点的DFT和IDFT
subplot(325);
k = 1:2:N-1;
xk16 = xk32(k);
stem(0:length(k)-1,abs(xk16),'.');xlabel('k');ylabel('|X16(k)|');title("16点DFT采样离散谱");
subplot(326);
xn16 = ifft(xk16,16);
stem(0:length(k)-1,xn16,'.');xlabel('n');ylabel('x16(n)');title("16点IDFT离散序列图");

%% 实验3：读取音频文件
clc,clear,close all;
figure();
[xn, fs] = audioread('motherland.wav');
N = 4092; % DFT点数为4096
Yn = 1/fs*fft(xn(8000:8199),N);
subplot(421);plot((0:N/2-1)*fs/N,abs(Yn(1:N/2)));title('D=1音频信号的幅度谱');
subplot(422);plot((0:N/2-1)*fs/N,angle(Yn(1:N/2)));title('D=1音频信号的相位谱');
% 抽取信号
D = 2;  % 抽取因子 D=2
xn1 = xn(1:D:length(xn));
Yn1 = D/fs*fft(xn1(4001:4100),N);  % 8000:2:8199中每两个点取一个点就相当于更新后的4001:4100
subplot(423);plot((0:N/2-1)*fs/(N*D),abs(Yn1(1:N/2)));title('D=2音频信号的幅度谱');
subplot(424);plot((0:N/2-1)*fs/(N*D),angle(Yn1(1:N/2)));title('D=2音频信号的相位谱');

% D1 = 4;  % 抽取因子 D=4
% xn2 = xn(1:4:length(xn));
% Yn1 = D1/fs*fft(xn2(2001:2050),N); 
% subplot(325);plot((0:N/4-1)*fs/(N*D),abs(Yn1(1:N/4)));title('D=4音频信号的幅度谱');
% subplot(326);plot((0:N/4-1)*fs/(N*D),angle(Yn1(1:N/4)));title('D=4音频信号的相位谱');

I = 2;
% 考虑不同的零值内插顺序
for i = 1:length(xn)
    % 前项插零
    xn2_1(2*i-1) = xn(i);
    xn2_1(2*i) = 0;
    % 后项插零
    xn2_2(2*i-1) = 0;
    xn2_2(2*i) = xn(i);
end
% 前项插零
Yn2_1 = 1/(I*fs)*fft(xn2_1(15999:2*8199-1),N);
subplot(425);
plot((0:N/2-1)*fs*I/N,abs(Yn2_1(1:N/2)));
xlabel('f(Hz)');title('前项插零方式幅度谱');
subplot(426);
plot((0:N/2-1)*fs*I/N,angle(Yn2_1(1:N/2)));
xlabel('f(Hz)');title('前项插零方式相位谱');
% 后项插零
Yn2_2 = 1/(I*fs)*fft(xn2_2(16000:2*8199),N);
subplot(427);
plot(2*(0:N/2-1)*fs*I/N,abs(Yn2_2(1:N/2)));
xlabel('f(Hz)');title('后项插零方式幅度谱');
subplot(428);
plot(2*(0:N/2-1)*fs*I/N,angle(Yn2_2(1:N/2)));
xlabel('f(Hz)');title('后项插零方式相位谱');


