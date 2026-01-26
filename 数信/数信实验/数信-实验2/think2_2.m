%% 思考题二
%% 清空
clear all;
clc;
%% 图像读取
cat=imread('cat.jpg');
GrayCat=rgb2gray(cat);
%% Canny边缘检测
F1=edge(GrayCat,'Canny');
%% Prewitt边缘检测
F2=edge(GrayCat,'Prewitt');
%% log边缘检测
F3=edge(GrayCat,'log');
%% Roberts边缘检测
F4=edge(GrayCat,'Roberts');
%% 图像显示
figure;
subplot(1,2,1);
imshow(cat);
title('原始图像')
subplot(1,2,2);
imshow(GrayCat);
title('原始灰度图像');
figure;
subplot(2,2,1);
imshow(F1);
title('Canny边缘检测图像')
subplot(2,2,2);
imshow(F2);
title('Prewitt边缘检测图像')
subplot(2,2,3);
imshow(F3);
title('log边缘检测图像')
subplot(2,2,4);
imshow(F4);
title('Roberts边缘检测图像')