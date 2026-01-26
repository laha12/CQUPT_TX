% desinged by chen zhili
% 2023-10-12
clc,clear,close all;
%% MATLAB数据及运算
% a=[1 2 3;4 5 6;7 5 4];
% b=[3 5 3;6 8 7;9 5 7];
% c1=a+b;
% c2=a-b;
% c3=a*b;
% c4=a.*b;
% c5=a/b;
% c6=a*inv(b);
% c8=a\b;
% c9=inv(a)*b;
% c10=a.\b;
% c11=a./b;
% c12=a^2;
% c13=a.^2;

%% 02连续信号的表示
% f=@(t)sin(t);
% fplot(f)
% grid on

%% 03离散信号的表示
% k=0:4;
% x=ones(1,5);
% stem(k,x)

%% 04 matlab绘图
% t=0:pi/100:2*pi;
% y1=exp(-0.5*t);
% y2=sin(2*pi*t);
% y3=y1.*y2;
% %绘制y1
% % figure(1)
% subplot(3,1,1)
% plot(t/pi,y1);
% title('指数函数');
% xlabel('时间');
% ylabel('exp(-0.5t)');
% grid on
% %绘制y2
% % figure(2)
% subplot(3,1,2)
% plot(t/pi,y2)
% title('正弦函数');
% xlabel('时间');
% ylabel('sin(2*pi*t)');
% grid on
% %绘制y1
% % figure(3)
% subplot(3,1,3)
% plot(t/pi,y3)
% title('衰减震荡');
% xlabel('时间');
% ylabel('exp(-0.5t)*sin(2*pi*t)');
% grid on

%% 05音频文件的读取、播放和保存
[xn, fs] = audioread('ML\\motherland.wav');
sound(xn, fs)
audiowrite('filename',xn,fs);
pause(n)

