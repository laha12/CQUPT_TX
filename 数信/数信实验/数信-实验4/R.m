function [x,x1]=R(width,length)
Width = width;  % 矩形脉冲的宽度  
Length = length; % 序列的总长度  
amplitude = 1;   % 矩形脉冲的幅度（高电平）  
  
% 初始化序列为零  
x = zeros(1, Length);  
  
% 设置矩形脉冲部分的值  
x(1:Width) = amplitude;  
x1=x(1:Width);