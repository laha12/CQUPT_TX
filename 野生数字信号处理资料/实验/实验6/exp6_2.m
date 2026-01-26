% desinged by chen zhili
% 2023-11-15
clc,clear,close all
%% 对心电图信号进行滤波
[bd, ad] = low_pass_filter(0.2*pi, 0.35*pi, 1.0, 15.0, 10);
% 心电图信号
xn=[-4,-2,0,-4,-6,-4,-2,-4,-6,-6,-4,-4,-6,-6,-2,6,12,8,...
     0,-16,-38,-60,-84,-90,-66,-32,-4,-2,-4,8,12,12,10,6,6,6,... 
     4,0,0,0,0,0,-2,-4,0,0,0,-2,-2,0,0,-2,-2,-2,-2,0];

yn = filter(bd, ad, xn);  % 进行滤波

figure();
subplot(221);stem(xn,'.');title('滤波前时域图');
subplot(222);stem(yn,'.');title('滤波后时域图');
% 进行滤波
N = 1024;
subplot(223);xk = fft(xn,N);plot(2*(0:N-1)/N,abs(xk));title('滤波前一个周期的幅度谱');
subplot(224);yk = fft(yn,N);plot(2*(0:N-1)/N,abs(yk));title('滤波后一个周期的幅度谱');