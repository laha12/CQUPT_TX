% desinged by chen zhili
% 2023-10-12
clc,clear,close all;
%% 1 连续信号
% sa(t)
t1=-10:0.01:10;
sa=sin(t1)./t1;
figure(1)
subplot(3,1,1)
plot(t1,sa)
title('Sa(t)函数');
xlabel('时间');
ylabel('Sa(t)');
grid on
% g2(t)
t2=-3:0.01:3;
A=1;
g2=A*rectpuls(t2,2);         %产生振幅为1，宽度为2的门信号
subplot(3,1,2)
plot(t2,g2)
title('g2(t)函数');
xlabel('时间');
ylabel('g2(t)');
grid on
% f3
t3=0:0.01:10;
f3=5*exp(0.5*t3).*sin(2*pi*t3);
subplot(3,1,3)
plot(t3,f3)
title('5*exp(0.5*t)*sin(2*pi*t)函数');
xlabel('时间');
ylabel('5*exp(0.5*t)*sin(2*pi*t)');
grid on

%% 02离散信号
N=10;%序列的长度
k1=zeros(1,N+1);   %用zeros函数创建零序列
k1(N/2+1)=1;   %规定N/2+1处的值为1
% delta(k)
figure(2)
subplot(3,1,1)
stem(-N/2:N/2,k1);   %用stem绘制序列更清晰
axis([-10 10 -0.1 1.1]);
xlabel('time');
ylabel('amplitude');
title('delta function');
grid on
% g4(k)
k2=-10:10;     
g4=zeros(1,21);
g4(1,9:13)=1;
subplot(3,1,2);  
stem(k2,g4); 
axis([-10 10 -0.1 1.1]);
xlabel('k'); 
ylabel('g4(k)');
title('g4(k)序列');
% f3k
k3=0:60;
f3k=1.1.^k3.*sin(0.05*pi.*k3);
subplot(3,1,3)
stem(k3,f3k);   %用stem绘制序列更清晰
xlabel('k');
ylabel('1.1.^k.*sin(0.05*pi.*k)');
title('1.1.^k.*sin(0.05*pi.*k)');
grid on

%% 03音频的读取
[xn, fs] = audioread('ML\\motherland.wav');
figure
subplot(2,1,1)
stem(400:500,xn(400:500));
xlabel('k');
ylabel('x(k)');
title('离散音频信号')

subplot(2,1,2)
stem(8000:16000,xn(8000:16000));
xlabel('k');
ylabel('x(k)');
title('1~2s音频信号')
% 
% sound(xn, fs);
% pause(length(xn)/fs+1)
% 
% % sound(xn(8000:16000),fs);
% xn1=xn(1:2:length(xn));
% sound(xn图片1,fs/2);

%% 04图片读取
% Q1:
% 在使用Matlab处理连续信号时，将其离散化为离散序列进行处理是因为离散信号在数字计算机中更容易处理和存储。
% 将连续信号离散化成离散序列的优势有以下几点：
%     1、离散信号更容易存储：离散信号由一系列离散的样本点组成，每个样本点可以用有限位数（比如二进制）进行表示，因此在计算机中存储离散信号更加方便和高效。
%     2、离散信号更易于传输：将连续信号离散化后，可以通过数字方式进行传输，如通过网络进行传输或在数字通信中进行编码和解码。
%     3、 离散信号更容易进行数字信号处理：离散信号可以使用数字信号处理（DSP）技术进行处理，包括滤波、频谱分析、傅里叶变换等，这些技术在计算机中实现更加方便和高效。

Img = imread('ML\\lena_colour.bmp') ;
figure(3)
subplot(231)
imshow(Img); % 输出原图
title('原始图像')

Imgh=im2gray(Img);
subplot(232)
imshow(Imgh) % 输出灰度图
title('灰度图')
imwrite(Imgh,'灰度图.bmp')

Img2=Imgh(1:2:end,1:2:end);
subplot(233);    
imshow(Img2)
title('采样图像(128*128)');
 
Img3=Imgh(1:4:end,1:4:end);
subplot(234)
imshow(Img3)
title('采样图像(64*64)');
 
Img4=Imgh(1:8:end,1:8:end); 	  
subplot(235);
imshow(Img4)
title('采样图像(32*32)');
 
Img5=Imgh(1:16:end,1:16:end);
subplot(236);
imshow(Img5)
title('采样图像(16*16)');

saveas(figure(3),'图像处理','bmp')
