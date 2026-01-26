% desinged by chen zhili
% 2023-11-15
clc,clear,close all
%% 实验3：音频信号的下采样
[xn, fs] = audioread('motherland.wav');   % 读取音频信号
D = 2;                  % 抽取因子 D=2
yn = xn(1:D:length(xn)-1);
[bd, ad] = anti_alisasing_filter(D);  % 调用滤波器
% 进行滤波
xn1 = filter(bd, ad, xn);
yn1 = xn1(1:D:length(xn1)-1);
% % 播放原声、抽取、滤波后抽取
% % 原声
% sound(xn,fs);pause(12);
% % 抽取
% sound(yn,fs/2);pause(12);
% % 滤波后
% sound(yn1,fs/2);pause(12);
%% 问题5，单独分开，xn变了
figure();
N = 4092;       % DFT点数为4096
x = xn(8000:8199);
Xn = 1/fs*fft(x,N);
subplot(311);plot((0:N/2-1)*fs/N,abs(Xn(1:N/2)));title('D=1音频信号的幅度谱');
% subplot(422);plot((0:N/2-1)*fs/N,angle(Xn(1:N/2)));title('D=1音频信号的相位谱');
% 抽取信号
x1 = x(1:D:length(x)-1);
xk1 = D/fs*fft(x1,N);  % 8000:2:8199中每两个点取一个点就相当于更新后的4001:4100
subplot(312);plot((0:N/2-1)*fs/(D*N),abs(xk1(1:N/2)));title('D=2音频信号的幅度谱');
% subplot(424);plot((0:N/2-1)*fs/(N*D),angle(Yn1(1:N/2)));title('D=2音频信号的相位谱');
% 先经过滤波器，再抽样
y = filter(bd, ad, x);     % 经过滤波器
x2 = y(1:2:length(y)-1);   % 采样
xk2 = D/fs*fft(x2,N);
subplot(313);plot((0:N/2-1)*fs/(D*N),abs(xk2(1:N/2)));title('音频信号先经过滤波器再抽样后的幅度谱');