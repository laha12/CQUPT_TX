%% 问题二
clear all;
clc;
clf;
% 心电图采样序列
xn=[-4,-2,0,-4,-6,-4,-2,-4,-6,-6,-4,-4,-6,-6,-2,6,12,...
    8,0,-16,-38,-60,-84,-90,-66,-32,-4,-2,-4,8,12,12,10,6,6,6,...
    4,0,0,0,0,0,-2,-4,0,0,0,-2,-2,0,0,-2,-2,-2,-2,0];
B=[0.0092,0.0367,0.0550,0.0367,0.0092];
A=[1.0000,-2.0325,1.8204,-0.7706,0.1294];
yn=filter(B,A,xn);
% FFT
N=1024;
xk=fft(xn,N);
yk=fft(yn,N);
% 可视化
figure;
subplot(2,1,1);
stem(0:length(xn)-1,xn,'filled','LineWidth',1.5);grid on;axis([0,60,-100,40]);
title('原序列');
subplot(2,1,2);
plot(2*(0:N-1)/N,abs(xk),'LineWidth',1.5,'color','#ff8884');grid on;axis([0,2,0,500]);
title('原序列幅度特性');
figure;
subplot(2,1,1);
stem(0:length(yn)-1,yn,'filled','LineWidth',1.5);grid on;axis([0,60,-100,40]);
title('滤波后的序列');
subplot(2,1,2);
plot(2*(0:N-1)/N,abs(yk),'LineWidth',1.5,'color','#ff8884');grid on;axis([0,2,0,500]);
title('滤波序列幅度特性');
