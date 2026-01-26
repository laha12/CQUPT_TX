%% 问题三
clear all;
clc;
% 序列
n1=0:7;
n2=0:15;
x4=cos(pi/4*n1);
x44=cos(pi/4*n2);
x5=sin(pi/8*n1);
x55=sin(pi/8*n2);
% 8点FFT和16点FFT
N1=8;
N2=16;
x4k=fft(x4,N1);
x4kk=fft(x44,N2);
x5k=fft(x5,N1);
x5kk=fft(x55,N2);
%% cos(pi/4*n)
% 作图
figure;
subplot(2,1,1);
stem(n1,x4 ,'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{4}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N1-1,abs(x4k),'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{4}(n)的8点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(n2,x44 ,'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{4}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N2-1,abs(x4kk),'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{4}(n)的16点FFT');  
xlabel('k');  

%% sin(pi/8*n)
% 作图
figure;
subplot(2,1,1);
stem(n1,x5 ,'filled','LineWidth',1.4,'LineStyle','-','Color','#8ECFC9');  
grid on;
title('序列x_{5}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N1-1,abs(x5k),'filled','LineWidth',1.4,'LineStyle','-','Color','#8ECFC9');
grid on;
title('x_{5}(n)的8点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(n2,x55 ,'filled','LineWidth',1.4,'LineStyle','-','Color','#8ECFC9');  
grid on;
title('序列x_{5}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N2-1,abs(x5kk),'filled','LineWidth',1.4,'LineStyle','-','Color','#8ECFC9');
grid on;
title('x_{5}(n)的16点FFT');  
xlabel('k');  
