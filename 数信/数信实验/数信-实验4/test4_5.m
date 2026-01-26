%% 问题五
% 清空
clear all;
clc;
[x,fs]=audioread('motherland.wav');
n=8000:8199;
xn=x(8000:8199);
% 512点DFT FFT实现
N=512;
xk=fft(xn,N);
% 8000~8199段音频信号
subplot(2,1,1)
stem(n,xn,'filled','LineWidth',0.6,'Color','#C76DA2');
xlabel('n');
ylabel('x_n');
title('8000~8199点信号的时域离散波形图');
subplot(2,1,2);
plot(n/fs,xn,'LineWidth',1.2,'Color','#C76DA2');
xlabel('t');
ylabel('x_t');
title('8000~8199点信号的时域连续波形图');
% FFT后幅度谱和相位谱
figure;
subplot(2,1,1);
plot(2*(0:N-1)/N,abs(xk),'LineWidth',0.8,'Color','#BB9727');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('连续幅度谱');
subplot(2,1,2);
plot(2*(0:N-1)/N,angle(xk),'LineWidth',0.8,'Color','#54B345');
xlabel('\omega/\pi');
ylabel('Phase');
title('相位谱');