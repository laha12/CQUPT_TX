% 实验内容 3
clc;clear;close all;
% 读取音频信号
[xn, fs] = audioread("motherland.wav");
I=2;    % 内插因子
for i = 1:length(xn)
    yn1(I*i-1) = xn(i);
    yn1(I*i) = 0;
end
wp=pi/I-pi/20;             % 滤波器带通截止频率
ws=pi/I;                        % 滤波器带阻截止频率
As=60;                          % 滤波器通带和阻带衰减指标
h=fir_lowpass_filter(wp,ws,As);

yn2 = conv(yn1, h);
figure();
subplot(311);plot(xn);xlabel('n');ylabel('x(n)');title("原语音信号");
subplot(312);plot(yn1);xlabel('n');ylabel('yn1(n)');title("I=2内插后语音信号");
subplot(313);plot(yn2);xlabel('n');ylabel('yn2(n)');title("I=2内插滤波后语音信号");

%%  分析xn在n=8000~8199段信号的频谱
x1 = xn(8000:8199);
N = 1024;   % DFT变换长度
Xk1 = 1/fs * fft(x1, N);
% 原始信号
figure();
subplot(311);plot(I*fs*(0:N/2-1)/N, abs(Xk1(1:N/2)));
xlabel("f(Hz)");ylabel('X(f)');title("原8000~8199信号模拟域幅度谱");
% 进行内插
for i = 1:length(x1)
    x2(I*i-1) = x1(i);
    x2(I*i) = 0;
end
% 内插
Xk2 = 1/(I*fs) * fft(x2,N); % 采样频率I*fs
subplot(312);plot(I*fs*(0:N/2-1)/N, abs(Xk2(1:N/2)));
xlabel("f(Hz)");ylabel('X2(f)');title("I=2内插后模拟域幅度谱");
% 内插后再进行滤波
x3 = conv(x2,h);
Xk3 = 1/(I*fs)*fft(x3,N);
subplot(313);plot(I*fs*(0:N/2-1)/N, abs(Xk3(1:N/2)));
xlabel("f(Hz)");ylabel('X3(f)');title("I=2内插并滤波后模拟域幅度谱");