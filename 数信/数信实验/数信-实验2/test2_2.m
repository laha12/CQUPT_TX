%% 问题二
%% 清空
clear all;
clc;
%% 卷积和
nh=-4:20;
nx=-4:16;
hn=(7/8).^nh.*(heaviside(nh)-heaviside(nh-10));
xn=heaviside(nx)-heaviside(nx-5);
yn=conv(xn,hn);
ny1=nx(1)+nh(1);
ny2=nx(end)+nh(end);
ny=ny1:ny2;
%% 显示
figure;
subplot(3,1,1);
stem(nx,xn,'fill','r','LineWidth',0.6);
grid on;
axis([-4,16,0,2]);
xlabel('n');
title('x_{n}');
subplot(3,1,2);
stem(nh,hn,'fill','g','LineWidth',0.6);
grid on;
axis([-4,16,0,2]);
xlabel('n');
title('h_{n}');
subplot(3,1,3);
stem(ny,yn,'fill','LineWidth',0.6);
grid on;
axis([-4,16,0,5.5]);
xlabel('n');
title('y_{n}=x_{n}*h_{n}');