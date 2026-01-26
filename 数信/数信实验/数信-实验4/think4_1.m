%% 思考1
clear all;
clc;
% 序列x2 x3
n=0:7;
x2=[1:4 4:-1:1];
x3=[4:-1:1 1:4];
% 8点FFT和16点FFT
N1=8;
N2=16;
x2k=fft(x2,N1);
x2kk=fft(x2,N2);
x3k=fft(x3,N1);
x3kk=fft(x3,N2);
% 作图
subplot(2,1,1);
stem(0:N1-1,abs(x2k),'filled','LineWidth',1.4,'LineStyle','-','Color','#3b8ba1');
grid on;
title('x_{2}(n)的8点FFT');  
xlabel('k');  
subplot(2,1,2);
stem(0:N1-1,abs(x3k),'filled','LineWidth',1.4,'LineStyle','-','Color','#ff8884');
grid on;
title('x_{3}(n)的8点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(0:N2-1,abs(x2kk),'filled','LineWidth',1.4,'LineStyle','-','Color','#3b8ba1');
grid on;
title('x_{2}(n)的16点FFT');  
xlabel('k');  
subplot(2,1,2);
stem(0:N2-1,abs(x3kk),'filled','LineWidth',1.4,'LineStyle','-','Color','#ff8884');
grid on;
title('x_{3}(n)的16点FFT');  
xlabel('k');  