% desinged by chen zhili
% 2023-10-18
clc,clear,close all;
%% 01 离散时间系统的相应
% 01-1 3y(n)+4y(n-1)+y(n-2)=x(n)+x(n-1)
a=[3 4 1];
b=[1 1];
n=0:160;
x=(n==0);
h=filter(b,a,x);
figure(1)
subplot(411)
stem(n,h,'fill');
grid on;
xlabel('n')
title('2-1-1 系统单位响应h(n)')

% 01-2 2.5y(n)+6y(n-1)+10y(n-2)=x(n)
a=[2.5,6,10];
b=[1];
n=0:160;
x=(n==0);
h=filter(b,a,x);
subplot(412)
stem(n,h,'fill');
grid on;
xlabel('n'),
title('2-1-2 系统单位响应h(n)')

% 01-3 y(n)-0.9y(n-8)=x(n)-x(n-8)
a=[1 0 0 0 0 0 0 -0.9];
b=[1 0 0 0 0 0 0  -1];
n=0:160;
x=(n==0);
h=filter(b,a,x);
subplot(413)
stem(n,h,'fill');
grid on;
xlabel('n'),
title('2-1-3 系统单位响应h(n)')

% 01-4 y(n)-0.5y(n-1)=x(n)-2x(n-1)
a=[1 -0.5];
b=[1 -2];
n=0:160;
x=(n==0);
h=filter(b,a,x);
subplot(414)
stem(n,h,'fill');
grid on;
xlabel('n'),
title('2-1-4 系统单位响应h(n)')
saveas(1,'实验2//2-1.png')

% 01-5 用系统1和系统2分别对音频进行滤波
[xn, fs] = audioread('ML//motherland.wav');
t=(0:length(xn)-1)/fs;
figure(2)
subplot(311),plot(t,xn),xlabel('s'),title('原音频信号')

% 用系统1对音频进行滤波
subplot(312)
Gx1=[3 4 1];
Gy1=[1 1];
z1=filter(Gy1,Gx1,xn);
subplot(312),plot(t,z1),xlabel('s'),title('用h1(n)进行滤波后的音频信号')
% 用系统2对音频进行滤波
Gx2=[2.5,6,10];
Gy2=[1];
z2=filter(Gy2,Gx2,xn);
subplot(313),plot(t,z2),xlabel('s'),title('用h2(n)进行滤波后的音频信号')
saveas(2,'实验2//2-1-5.png')

%% 02 lena图像处理
Gx=[-1 0 1;
    -2 0 2;
    -1 0 1];
Gy=[ 1  2  1;
     0  0  0; 
    -1 -2 -1];
% B = imread('ML\\lena.bmp');
B = imread('lena.bmp');
G1 = conv2(Gx,B);
G2 = conv2(Gy,B);
G3 = conv2(G1,Gy);
figure(3);
subplot(2,2,1),subimage(B),title('原图');
subplot(2,2,2),subimage(G1),title('Gx 与的 B 进行卷积')
subplot(2,2,3),subimage(G2),title('Gy 与的 B 进行卷积')
subplot(2,2,4),subimage(G3),title('先后采用 Gx 和 Gy 与的 B 进行卷积')
saveas(3,'实验2//2-2.png')

%% 03 滤波
[xn, fs] = audioread('ML//motherland.wav');
nh1=[1 -1];
nh2=[-1 1];
nh3=[1 1 1 1 1 1 1 1 1];
fs
% 用h1(n)进行对音频的滤波
y1=conv(nh1,xn);
t1=(0:length(y1)-1)/fs;
figure(4)
subplot(311),plot(t1,y1),xlabel('s'),title('用h1(n)进行滤波后的音频信号')

% 用h2(n)进行对音频的滤波
y2=conv(nh2,xn);
t2=(0:length(y2)-1)/fs;
subplot(312),plot(t2,y2),xlabel('s'),title('用h2(n)进行滤波后的音频信号')

% 用h3(n)进行对音频的滤波
y3=conv(nh3,xn);
t3=(0:length(y3)-1)/fs;
subplot(313),plot(t3,y3),xlabel('s'),title('用h3(n)进行滤波后的音频信号')
saveas(4,'实验2//2-3.png')


% sound(y1,t1);
% sound(y2,t2);
% sound(y3,t3);

