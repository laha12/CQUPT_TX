%% 问题一
%% 清空
clear all;
clc;
%% 系统1 采用filter求单位冲击响应 并做零极图
a1=[3 4 1];
b1=[1 1];
n1=0:29;
x=(n1==0);
h1=filter(b1,a1,x);
figure(1);
subplot(2,1,1);
stem(n1,h1,'fill','r');
grid on;
xlabel('n');
ylabel('h_{1}(n)');
title('单位取样响应h_{1}(n)');
subplot(2,1,2);
zplane(b1,a1);
grid on;
legend('零点','极点');
title('H_{1}(z)零极点分布图');
%% 系统2 采用impz求单位冲击响应 并做零极图
a2=[5/2 6 10];
b2=[1];
n2=30;
figure(2);
subplot(2,1,1);
impz(b2,a2,n2);
grid on;
xlabel('n');
ylabel('h_{2}(n)');
title('单位取样响应h_{2}(n)');
subplot(2,1,2);
zplane(b2,a2);
grid on;
legend('零点','极点');
title('H_{2}(z)零极点分布图');
