%% 问题四
B=[1 0 0 0 0 0 0 0 -1];
A=[1 0 0 0 0 0 0 0 -0.9];
%% 零极点分布图
figure;
zplane(B,A);
grid on;
legend('零点','极点');
title('系统零极点分布图');
%% 频响特性
figure;
[H,w]=freqz(B,A,'whole');
Hm=abs(H);
Hp=angle(H);
subplot(2,1,1);
plot(w/pi,Hm,'LineWidth',1.4,'color','#3b8ba1'),grid on;
xlabel('\omega/\pi');
ylabel('Magnitude');
title('离散系统的幅频特性曲线');
subplot(2,1,2);
plot(w/pi,Hp,'LineWidth',1.4,'color','#F0988C'),grid on;
xlabel('\omega/\pi');
ylabel('Phase');