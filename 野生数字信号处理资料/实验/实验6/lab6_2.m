% desinged by chen zhili
% 2023-11-16
clc,clear,close all
%% 任务2
[xn, fs] = audioread('motherland.wav');
D = 3;    % 抽样因子为3
wp=pi/D-0.05*pi;    % 通带截止频率
ws=pi/D+0.05*pi;    % 阻带截止频率
Rp=1;               % 通带最大衰减
As=30;              % 阻带最小衰减
Fs=100;             % 采样频率
% 2）
yn1 = xn(1:D:length(xn));   %对xn进行D=3的整数倍抽取
% 3）
[bd, ad] = low_pass_filter(wp,ws,Rp,As,Fs);%抗混叠滤波器
yn = filter(bd, ad, xn);    %对xn进行抗混叠滤波
yn2 = yn(1:D:length(yn));   %再对滤波后的序列进行D=3整数倍抽取
% 原信号的幅度谱
N = 4096;           % DFT点数为4096
xn1 = xn(8000:8199);
Yn = 1/fs*fft(xn1,N);
subplot(311);plot((0:N/2-1)*fs/N,abs(Yn(1:N/2)));
xlabel('f(Hz)');ylabel('Y(k)');title('抽取前音频信号的幅度谱');
% D=3抽取后
Yn1 = D/fs*fft(xn1(1:D:length(xn1)),N);
subplot(312);plot((0:N/2-1)*fs/(N*D),abs(Yn1(1:N/2)));
xlabel('f(Hz)');ylabel('Y1(k)');title('D=3抽取后音频信号的幅度谱');
% 先经过滤波，在抽取
xn2 = filter(bd, ad, xn1);
Yn2 = D/fs*fft(xn2(1:D:length(xn2)),N);
subplot(313);plot((0:N/2-1)*fs/(N*D),abs(Yn2(1:N/2)));
xlabel('f(Hz)');ylabel('Y2(k)');title('经抗混叠滤波后再抽取的音频信号的幅度谱');