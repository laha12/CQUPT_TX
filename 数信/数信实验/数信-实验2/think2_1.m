%% 思考题一
%% 清空
clear all;
clc;
%% 卷积
nx=-3:3;
nh=-1:4;
xn=[3,11,7,0,-1,4,2];
hn=[2,3,0,-5,2,1];
yn=conv(xn,hn);
ny1=nx(1)+nh(1);
ny2=nx(end)+nh(end);
ny=ny1:ny2;
%% 作图
figure;
stem(ny,yn,'fill','k','Linewidth',0.6);
xlabel('n');
ylabel('y_{n}');
title('y_{n}=x_{n}*h_{n}')
grid on;