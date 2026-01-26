%% 问题一
clear all;
clc;
% 矩形序列
width=4;
length=8;
[x,x1]=R(width,length);
% 8点FFT和16点FFT
N1=8;
N2=16;
x1k=fft(x1,N1);
x1kk=fft(x1,N2);
% 作图
figure;
subplot(2,1,1);
stem(0:length-1,x ,'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title(['矩形序列R_',num2str(width),'(n)']);  
xlabel('n');  
subplot(2,1,2);
stem(0:N1-1,abs(x1k),'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{1}(n)的8点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(0:length-1,x ,'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title(['矩形序列R_',num2str(width),'(n)']);  
xlabel('n');  
subplot(2,1,2);
stem(0:N2-1,abs(x1kk),'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{1}(n)的16点FFT');  
xlabel('k');  