%% 问题二
% 序列x2
n=0:7;
x2=[1:4 4:-1:1];
% 8点FFT和16点FFT
N1=8;
N2=16;
x2k=fft(x2,N1);
x2kk=fft(x2,N2);
% 作图
figure;
subplot(2,1,1);
stem(n,x2 ,'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{2}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N1-1,abs(x2k),'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{2}(n)的8点FFT');  
xlabel('k');  
% 作图
figure;
subplot(2,1,1);
stem(n,x2 ,'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');  
grid on;
title('序列x_{2}(n)');  
xlabel('n');  
subplot(2,1,2);
stem(0:N2-1,abs(x2kk),'LineWidth',1.4,'LineStyle','-','MarkerFaceColor','#3b8ba1');
grid on;
title('x_{2}(n)的16点FFT');  
xlabel('k');  