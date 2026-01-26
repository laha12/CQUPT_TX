%% 思考一
%% 读取音频
[y,Fs]=audioread('motherland.wav');
% 提取1~2秒内容
startIndex=round(Fs);
endIndex=round(2*Fs);
ySegment=y(startIndex:endIndex,:);
%% 定义滤波器绘制幅频特性
b1=[1 0];
a1=[1 0.8];
b2=[1 0];
a2=[1 -1];
b3=[1 0];
a3=[1 1.2];
%% 绘制幅频特性
figure('Name', '特性曲线');
[H1,w1]=freqz(b1,a1,'whole');
Hm1=abs(H1);
subplot(3,1,1);
plot(w1/pi,Hm1,'LineWidth',1.4,'color','#3b8ba1'),grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('滤波器1的幅频特性曲线');
[H2,w2]=freqz(b2,a2,'whole');
Hm2=abs(H2);
subplot(3,1,2);
plot(w2/pi,Hm2,'LineWidth',1.4,'color','#F0988C'),grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('滤波器2的幅频特性曲线');
[H3,w3]=freqz(b3,a3,'whole');
Hm3=abs(H3);
subplot(3,1,3);
plot(w3/pi,Hm3,'LineWidth',1.4,'color','#7d9847'),grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('滤波器3的幅频特性曲线');
%% 滤波
y1=filter(b1,a1,ySegment);
y2=filter(b2,a2,ySegment);
y3=filter(b3,a3,ySegment);
%% 绘图
% 播放滤波后的信号
%sound(y1, Fs);
% 绘制滤波信号
time = (startIndex:endIndex) / Fs; % 时间向量  
figure('Name', '滤波信号');
subplot(4, 1, 1);
plot(time, ySegment,'LineWidth',1,'color','#c97937');
xlabel('时间/s'),ylabel('幅度'),title('原信号(1s~2s)');
subplot(4, 1, 2);
plot(time, y1,'LineWidth',1,'color','#3b8ba1');
xlabel('时间/s'),ylabel('幅度'),title('H_{1}(z) 滤波后的音频');
subplot(4, 1, 3);
plot(time, y2,'LineWidth',1,'color','#7d9847');
xlabel('时间/s'),ylabel('幅度'),title('H_{2}(z) 滤波后的音频');
subplot(4, 1, 4);
plot(time, y3,'LineWidth',1,'color','#9c403d');
xlabel('时间/s'),ylabel('幅度'),title('H_{3}(z) 滤波后的音频');
% 说明滤波后信号幅度变化的原因  
disp('滤波后信号幅度变化的原因：');  
disp('1. H1(z) = z / (z + 0.8)：这是一个低通滤波器，会减弱高频成分，可能导致信号整体幅度减小。');  
disp('2. H2(z) = z / (z - 1)：这是一个高通滤波器，但由于分母中的-1，它是一个不稳定的滤波器，可能导致信号失真和幅度剧烈变化。');  
disp('3. H3(z) = z / (z + 1.2)：这也是一个低通滤波器，会进一步减弱高频成分，同样可能导致信号整体幅度减小。');