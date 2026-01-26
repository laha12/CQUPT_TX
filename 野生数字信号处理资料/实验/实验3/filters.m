% desinged by chen zhili
% 2023-10-26

function [] = filters(B,A)
%   此函数实现对音频信号'motherland.wav'进行滤波
%   B：系统函数的分子多项式系数（差分方程输入序列的系数向量）
%   A：系统函数的分母多项式系数（差分方程输出序列的系数向量）
[xn, fs] = audioread('motherland.wav'); %读取音频信号
t = 1:1/fs:2;  % 定义时间为1~2s时间段之内，且横坐标为秒(s)
subplot(2,1,1);
plot(t,xn(fs:2*fs));
grid on;
xlabel('t/s');title('1～2s原音频信号时域波形图');

y1 = filter(B,A,xn);
subplot(2,1,2)
plot(t,y1(fs:2*fs));
grid on;
xlabel('t/s');title('filter滤波后1~2S信号时域波形图');

% h3=impz(B,A)
% y2 = conv(B,A);
% t2=(0:length(y2)-1)/fs;
% subplot(3,1,3)
% plot(t2(fs:2*fs),y2(fs:2*fs));
% grid on;
% xlabel('t/s');title('conv滤波后1~2S信号时域波形图');
end

