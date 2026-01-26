%% 问题五
clear all;
clc;
clf;
% 滤波器参数
wc=pi/2;
wp=wc-0.004*pi;
ws=wc+0.015*pi;
deltaw=ws-wp;
% 窗函数设计
N0=ceil(11*pi/deltaw);%因为衰减要达到60dB,则应该尽可能往大的选，选择布莱克曼窗
N=N0+mod(N0+1,2);
windows=(blackman(N))';
% 逼近滤波器单位脉冲相应，用理想低通近似
hd=ideal_lp(wc,N);
b=hd.*windows;%截断
% 音频序列和处理后的序列
[xn,fs]=audioread('motherland.wav');
I=2;
for i=1:length(xn) % 在每个点后面插值（I-1）个零点     采样频率为原来的两倍
    yn1(I*i-1)=xn(i);
    yn1(I*i)=0;
end
yn2=filter(b,1,yn1);
% % 音频播放
% sound(xn,fs);
% pause(length(xn)/fs);
% sound(yn1,fs*I);
% pause(length(yn1)/(I*fs));
% sound(yn2,fs*I);
% pause(length(yn2)/(I*fs));
% 2048点FFT
N=2048;
Xk=1/fs*fft(xn(8000:8199),N);
Yn1k=1/(I*fs)*fft(yn1(16000:16399),N);
Yn2k=1/(I*fs)*fft(yn2(16000:16399),N);
% 可视化
subplot(3,1,1);
plot((0:N/2-1)/N*fs,abs(Xk(1:N/2)));grid on;
xlabel('f/(Hz)');ylabel('Magnitude');title('原音频信号频谱');
subplot(3,1,2);
plot((0:N-1)/N*fs,abs(Yn1k(1:N)));grid on;
xlabel('f/(Hz)');ylabel('Magnitude');title('I=2内插零后音频信号频谱');
subplot(3,1,3);
plot((0:N-1)/N*fs,abs(Yn2k(1:N)));grid on;
xlabel('f/(Hz)');ylabel('Magnitude');title('采用抗镜像滤波器对内插信号处理后的信号频谱');