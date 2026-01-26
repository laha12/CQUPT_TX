% desinged by chen zhili
% 2023-10-21
%% 01
figure(1);   %两个波形图在一个figure上实现
n = 0:30;    %截取前30点的波形图
x = (n==0);  %单位冲激序列
a1 = [1 -0.8];
b1 = 1;
subplot(2,1,1);
h1=filter(b1, a1, x);   %系统单位取样相应h1(n)
stem(n,h1,'filled'); grid on; xlabel('n');
title("系统单位取样相应h1(n)");

a2 = 1;
b2 = [1 -1];
subplot(2,1,2);
h2=filter(b2, a2, x);   %系统单位取样相应h2(n)
stem(n,h2,'filled'); grid on; xlabel('n');
title("系统单位取样相应h2(n)");

%% 02
[xn, fs] = audioread('ML\\motherland.wav'); %读取音频信号
figure(2);
subplot(3,1,1);
t=0:1/fs:(length(xn)-1)/fs;  %总时间为(length(xn)-1)/fs
plot(t,xn); grid on; xlabel('t/s');
title('原音频信号');
subplot(3,1,2);
% y1 = conv(h1, xn);  %经过卷积后，序列长度发生变化
% t1 = 0:1/fs:(length(y1)-1)/fs;
% plot(t1,y1); grid on; xlabel('t/s');
% title('经过系统1滤波后的波形');
% subplot(3,1,3);
y2 = conv(h2, xn);  %经过卷积后，序列长度发生变化
t2 = 0:1/fs:(length(y2)-1)/fs;
plot(t2,y2); grid on; xlabel('t/s');
title('经过系统2滤波后的波形');

%% 03
figure(3)
subplot(2,1,1);
t=0:1/fs:(length(xn)-1)/fs;
plot(t,xn); grid on; xlabel('t/s');
title('原音频信号');
subplot(2,1,2);
xn_new = xn.' + 0.2*cos(2000*pi*t);	 %添加噪声
plot(t,xn_new); grid on; xlabel('t/s');
title('添加噪声后的信号');

%% 04
nx = -3:3;  %nx是x的位置向量
x = [3,11,7,0,-1,4,2];
nh = -1:4;  %nh是h的位置向量
h = [2,3,0,-5,2,1];
nys = nx(1)+nh(1);  %卷积后的长度N+M-1
nyf = nx(end)+nh(end);
ny = nys:nyf;
y = conv(x,h);
figure(4)
stem(ny,y,'filled'); xlabel('n');
title("y(n)");

Gx = [-1 0 1;-1 0 1;-1 0 1];
Gy = [-1 -1 -1;0 0 0;1 1 1];
B = imread('ML\\lena.bmp');
C1 = conv2(Gx,B);
C2 = conv2(Gy,B);
C3 = conv2(Gy,C1);
figure(5);
subplot(2,2,1);
imshow(B);title('原始图像');
subplot(2,2,2);
imshow(C1);title('经过 Gx 卷积滤波后图像');
subplot(2,2,3);
imshow(C2);title('经过 Gy 卷积滤波后图像');
subplot(2,2,4);
imshow(C3);title('先后采用 Gx 和 Gy 与的 B 进行卷积滤波后的图像');