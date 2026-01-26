clear all
clc
% 定义信号范围
t1 = -10:0.01:10;
t2=0:0.01:10;

% 信号表达式
y1=sin(t1)./t1;  %sa函数
y2=heaviside(t1+1)-heaviside(t1-1);  %大于0 为1 小于0为0
y3=5*exp(0.5*t2).*sin(2*pi*t2);

%创建画图窗口
figure()

% 信号1子图
subplot(3,1,1);
plot(t1,y1,'LineWidth',1.5,'Color','b');
title('Sa(t)')
xlabel('时间')
ylabel('sin(t)/t')

% 信号2子图
subplot(3,1,2);
plot(t1,y2,'LineWidth',1.5,'Color','r');
title('g2(t)')
xlabel('时间')
ylabel('g2(t)')

% 信号3子图
subplot(3,1,3);
plot(t2,y3,'LineWidth',1.5,'Color','g');
title('5exp(0.5t)sin(2pit)')
xlabel('时间')
ylabel('5exp(0.5t)sin(2pit)')
