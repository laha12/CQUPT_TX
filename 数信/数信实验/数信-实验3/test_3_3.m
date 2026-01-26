%% 问题三
B=[1 0 0];
A=[1 -3/4 1/8];
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
title('离散系统的相频特性曲线');