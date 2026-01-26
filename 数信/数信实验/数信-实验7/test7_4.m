%% 问题四
clear all;
clc;
clf;
b=load('b.mat');%导入任务2滤波器参数
b=b.b;
[xt,t]=xtg(1000);
yt=fftfilt(b,xt);
Hyk=abs(fft(yt));
subplot(2,1,1);
plot(t,yt);
xlabel('t/s');title('经低通滤波的叠加了高频高斯噪声的时域波形');
subplot(2,1,2);
stem(0:length(Hyk)-1,Hyk);
xlabel('f/Hz');ylabel('幅度');title('经低通滤波的叠加了高频高斯噪声的频谱');
axis([80,120,min(Hyk),max(Hyk)]);
figure;
stem(0:length(Hyk)-1,Hyk);
xlabel('f/Hz');ylabel('幅度');title('经低通滤波的叠加了高频高斯噪声的频谱');
axis([110,170,min(Hyk),max(Hyk)]);