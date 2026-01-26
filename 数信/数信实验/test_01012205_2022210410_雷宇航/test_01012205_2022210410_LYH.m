%考试人姓名：雷宇航；学号：2022210410；题号：26
clear all;
clc;
clf;
% 音频序列读取
[xn,fs]=audioread('motherland.wav');
D=2;
xn1=xn(1:D:length(xn));
% N1点FFT
N1=256;
Xn=1/fs*fft(xn(8200:8399),N1);
Xn1=D/fs*fft(xn1(4100:4199),N1);%D=2整数倍抽取后，采样频率为原来的一半，出现混叠
% 可视化
subplot(2,1,1);
plot((0:N1/2-1)/N1*fs,abs(Xn(1:N1/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz');ylabel('幅度');title(['原始模拟域幅度谱',num2str(N1),'点DFT']); grid on;
subplot(2,1,2);
plot((0:N1/2-1)/N1*fs/D,abs(Xn1(1:N1/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz');ylabel('幅度');title(['D=2整数倍抽取序列模拟域幅度谱',num2str(N1),'点DFT']);grid on;
clear Xn;
clear Xn1;
clear N1;
% 4096点FFT
N2=4096;
Xn=1/fs*fft(xn(8200:8399),N2);
Xn1=D/fs*fft(xn1(4100:4199),N2);%D=2整数倍抽取后，采样频率为原来的一半，出现混叠
% 可视化
figure;
subplot(2,1,1);
plot((0:N2/2-1)/N2*fs,abs(Xn(1:N2/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz');ylabel('幅度');title(['原始模拟域幅度谱',num2str(N2),'点DFT']); grid on;
subplot(2,1,2);
plot((0:N2/2-1)/N2*fs/D,abs(Xn1(1:N2/2)),'LineWidth',1.5,'color','#BB9727');xlabel('f/Hz');ylabel('幅度');title(['D=2整数倍抽取序列模拟域幅度谱',num2str(N2),'点DFT']);grid on;