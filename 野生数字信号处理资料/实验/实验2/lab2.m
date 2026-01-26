% desinged by chen zhili
% 2023-10-18
clc,clear,close all;
%% 01 离散时间系统的响应
% 3y(n)-4y(n-1)+2y(n-2)=x(n)+2x(n-1)
a=[3 -4 2];
b=[1 2];
n=0:30;
x=(1/2).^n;
h=filter(b,a,x);
stem(n,h,'fill');
grid on;
xlabel('n'),title('系统响应y(n)')

%% 02-1 离散时间系统的单位取样响应
a=[3 -4 2];
b=[1 2];
n=0:30;
x=(n==0);
h=filter(b,a,x);
stem(n,h,'fill');
grid on;
xlabel('n'),title('系统单位取样响应h(n)')

%% 02-2 另一种方法impz
a=[3 -4 2];
b=[1 2];
N=30;
impz(b,a,N);
grid on;
title('系统单位取样响应h(n)');

%% 03-1 离散时间信号的卷积和运算
x1=[1 1 1 1];
x2=[1 1 1 1];
g=conv(x1,x2);
n=0:6;
stem(n,g,'fill');
grid on
xlabel('n');

%% 03-2 离散信号的卷积和运算
nx=-1:5;          %x(n)向量显示范围(添加了附加的零值)
nh=-2:10;            %h(n)向量显示范围(添加了附加的零值)
x=uDT(nx)-uDT(nx-4);   %uDT(nx)产生单位阶跃序列的函数第7页附录中有介绍
h=0.8.^nh.*(uDT(nh)-uDT(nh-8));
y=conv(x,h);
ny1=nx(1)+nh(1);    %卷积结果起始点
ny2=nx(end)+nh(end);   %卷积结果终点
ny=ny1:ny2;
subplot(3,1,1);
stem(nx,x,'fill'),grid on
xlabel('n'),title('x(n)')
axis([-4 16 0 3])

subplot(3,1,2)
stem(nh,h','fill'),grid on
xlabel('n'),title( 'h(n)');
axis([-4 16 0 3])

subplot(3,1,3)
stem(ny,y,'fill'),grid on
xlabel('n'),title('y(n)=x(n)*h(n)')
axis([-4 16 0 3])











