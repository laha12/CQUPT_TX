%% 问题三
% 清空
clear all;
clc;
clf;
[x,fs]=audioread('motherland.wav');
fs
n=1000:2999;
xn=x(1000:2999);
xn1 = xn(1:2:length(n)-1);
xn2 = xn(2:2:length(n)-1);
xn=x(1000:2999);
N=2048;%原序列采样点数
N1=1024;%1/2序列的采样点数
% DFT变换
xk=fft(xn,N);
xk1=fft(xn1,N1);
xk2=fft(xn2,N1);
% 可视化
subplot(3,1,1);
plot(2*(0:N-1)/N,abs(xk),'LineWidth',0.8,'Color','#BB9727');
grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('连续幅度谱');
subplot(3,1,2);
plot(2*(0:N1-1)/N1,abs(xk1),'LineWidth',0.8,'Color','#BB9727');
grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('奇数项连续幅度谱');
subplot(3,1,3);
plot(2*(0:N1-1)/N1,abs(xk2),'LineWidth',0.8,'Color','#BB9727');
grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('偶数项连续幅度谱');