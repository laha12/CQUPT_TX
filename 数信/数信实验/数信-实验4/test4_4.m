%% 问题四
clear all;
clc;
% 序列
n1=0:15;
n2=0:31;
n3=0:63;
fs=64;
x6=cos(8*pi/fs*n1)+cos(16*pi/fs*n1)+cos(20*pi/fs*n1);
x66=cos(8*pi/fs*n2)+cos(16*pi/fs*n2)+cos(20*pi/fs*n2);
x666=cos(8*pi/fs*n3)+cos(16*pi/fs*n3)+cos(20*pi/fs*n3);
% 16点FFT、32点FFT、64点FFT
N1=16;
N2=32;
N3=64;
x6k=fft(x6,N1);
x66k=fft(x66,N2);
x666k=fft(x666,N3);
% 作图
figure;
subplot(2,1,1);
stem(n1,x6 ,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{6}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N1-1,abs(x6k),'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{6}(n)的16点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(n2,x66,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{6}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N2-1,abs(x66k),'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{6}(n)的32点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(n3,x666,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{6}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N3-1,abs(x666k),'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{6}(n)的64点FFT');  
xlabel('k');  
