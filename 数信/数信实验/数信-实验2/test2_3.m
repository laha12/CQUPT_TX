%% 问题三
%% 清空
clear all;
clc
%% 定义Sobel 算子
Gx=[-1 0 1;-2 0 2; -1 0 1];
Gy=[1 2 1;0 0 0;-1 -2 -1];
%% 读取lena图像
B=imread('lena.bmp');
F1=conv2(Gx,B);
F2=conv2(Gy,B);
F3=conv2(F1,Gy);
F1=uint8(F1);
F2=uint8(F2);
F3=uint8(F3);
%% 图像显示
figure;
subplot(2,2,1);
imshow(B);
title('原始图像');
subplot(2,2,2);
imshow(F1);
title('Gx卷积滤波图像')
subplot(2,2,3);
imshow(F2);
title('Gy卷积滤波图像')
subplot(2,2,4);
imshow(F3);
title('先后采用Gx,Gy卷积滤波图像')