clear all
clc
figure()
% 读取彩色图像文件
OI= imread('lena_color.bmp');
% 将彩色图像转换成灰度图像
GI = rgb2gray(OI);
% 显示灰度图像
imshow(GI);
title('灰度图像');
% 保存灰度图像为文件
imwrite(GI, 'lena_gray.bmp');