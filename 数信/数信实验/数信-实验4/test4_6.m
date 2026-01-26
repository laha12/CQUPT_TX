%% 问题六
% 读图
A=imread('lena.bmp');
figure;
imshow(A);
title('原图');
% 傅里叶变换
fftI=fft2(A);
A1=abs(fftI);
B1=(A1-min(min(A1)))/(max(max(A1))-min(min(A1)))*255;
figure;
imshow(B1);
title('二维幅度谱图');
B=fftshift(B1);
figure;
imshow(B);
title('移到中心位置的二维频谱图');