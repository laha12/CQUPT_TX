%% 思考二
clear all;
clc;
% 序列
x=[1 1 2 2 3 3 2 2 1 1];
x1=x(1:2:length(x));
x2=[1 0 1 0 2 0 2 0 3 0 3 0 2 0 2 0 1 0 1];
% 32 64 128 点DFT
N1=32;
N2=64;
N3=128;
% 32点
xk_32=fft(x,N1);
x1k_32=fft(x1,N1);
x2k_32=fft(x2,N1);
% 64点
xk_64=fft(x,N2);
x1k_64=fft(x1,N2);
x2k_64=fft(x2,N2);
% 128点
xk_128=fft(x,N3);
x1k_128=fft(x1,N3);
x2k_128=fft(x2,N3);
% 32点DFT后连续幅度谱
figure;
subplot(3,1,1);
plot(2*(0:N1-1)/N1,abs(xk_32),'LineWidth',1.5,'Color','#BB9727');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x32点DFT连续幅度谱');
subplot(3,1,2);
plot(2*(0:N1-1)/N1,abs(x1k_32),'LineWidth',1.5,'Color','#ff8884');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x_{1}32点DFT连续幅度谱');
subplot(3,1,3);
plot(2*(0:N1-1)/N1,abs(x2k_32),'LineWidth',1.5,'Color','#9ac9db');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x_{2}32点DFT连续幅度谱');
% 64点DFT后连续幅度谱
figure;
subplot(3,1,1);
plot(2*(0:N2-1)/N2,abs(xk_64),'LineWidth',1.5,'Color','#BB9727');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x64点DFT连续幅度谱');
subplot(3,1,2);
plot(2*(0:N2-1)/N2,abs(x1k_64),'LineWidth',1.5,'Color','#ff8884');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x_{1}64点DFT连续幅度谱');
subplot(3,1,3);
plot(2*(0:N2-1)/N2,abs(x2k_64),'LineWidth',1.5,'Color','#9ac9db');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x_{2}64点DFT连续幅度谱');
% 128点DFT后连续幅度谱
figure;
subplot(3,1,1);
plot(2*(0:N3-1)/N3,abs(xk_128),'LineWidth',1.5,'Color','#BB9727');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x128点DFT连续幅度谱');
subplot(3,1,2);
plot(2*(0:N3-1)/N3,abs(x1k_128),'LineWidth',1.5,'Color','#ff8884');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x_{1}128点DFT连续幅度谱');
subplot(3,1,3);
plot(2*(0:N3-1)/N3,abs(x2k_128),'LineWidth',1.5,'Color','#9ac9db');
xlabel('\omega/\pi');
ylabel('Magnitude');
title('序列x_{2}128点DFT连续幅度谱');

figure;
subplot(2,1,1);
plot(2*(0:N3-1)/N3,angle(xk_128),'LineWidth',1.5,'Color','#54B345');
subplot(2,1,2);
plot(2*(0:N3-1)/N3,angle(x2k_128),'LineWidth',1.5,'Color','#9ac9db');