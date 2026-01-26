clear all;
clc
% 定义信号的范围 方便图像输出直观
k = -5:10; 
k1=0:60;
% 实现冲击序列1：delta(k)
delta_k = zeros(1, length(k)); 
delta_k(k == 0) = 1; % 当k=0时，delta(k)=1，否则为0

% 实现离散序列2：R4(k)
x2_k = zeros(1, length(k));
x2_k(k <= 3 & k>=0) = 1; % 当n从0到3时，x2(k)=1，否则为0

% 实现离散序列3
x3_k=1.1.^k1.*sin(0.05*pi*k1);

% 创建图形窗口
figure;

% 冲击函数delta(k)子图
subplot(3, 1, 1); 
stem(k, delta_k, 'b', 'filled', 'LineWidth', 2);
title('Delta(k)');
xlabel('k');
ylabel('Delta(k)');
grid on;

% 离散序列2:  R4(k)子图
subplot(3, 1, 2);
stem(k, x2_k, 'r', 'filled', 'LineWidth', 2);
title('R4(k)');
xlabel('k');
ylabel('R4(k)');
grid on;

% 离散序列3子图
subplot(3, 1, 3);
stem(k1, x3_k, 'g', 'filled', 'LineWidth', 1);
title('X3(k)');
xlabel('k');
ylabel('X3(k)');
grid on;