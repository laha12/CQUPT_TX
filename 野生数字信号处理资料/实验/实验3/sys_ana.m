% desinged by chen zhili
% 2023-10-26

function [H] = sys_ana(B,A)
%   本函数实现在一个figure子图上绘制出系统的零极图、单位脉冲相应时域波形图、系统幅频特性曲线和系统相频特性曲线
%   B:系统函数分子多项式系数向量
%   A:系统函数分母多项式系数向量
%% 零极图
wp = 0.2*pi; ws = 0.3*pi;
Rp = 1; As = 24;    % 根据阻带最小衰减，应选取三角窗
Bt = ws - wp;   % 计算过渡带宽度
N0 = ceil(6.1*pi/Bt);
N = N0 + mod(N0+1, 2);
wc = (wp + ws)/2/pi; % 计算理想低通滤波器通带截止频率（关于π归一化）
h = fir1(N-1, wc, bartlett(N));
[H, w] = freqz(h, 1, 1000, 'whole');
H = H(1:501); w = w(1:501);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
subplot(221);stem(0:N-1,h,'.');xlabel('n');ylabel('h(n)');title('h(n)波形');
subplot(222);plot(w/pi,abs(H));ylabel('|H(e^{j\omega})|');xlabel('\omega/\pi');title('系统幅频特性曲线')
subplot(223);plot(w/pi,angle(H)/pi);ylabel('\theta(\omega)');xlabel('\omega/\pi');title('系统相频特性曲线')
subplot(224);plot(w/pi,db);xlabel('\omega/\pi');ylabel('-A(\Omega)');title('损耗函数曲线');
%% h(n)
subplot(222)
impz(B,A,30);grid on
title('单位脉冲相应h(n)')
%% 幅频特性
[H,w]=freqz(B,A,'whole');
Hm = abs(H);
Hp = angle(H);
subplot(223);plot(w/pi,Hm);grid on
xlabel('\omega(rad/s)'),ylabel('Magnitude'),title('离散系统幅频曲线')
subplot(224);plot(w/pi,Hp);grid on
xlabel('\omega(rad/s)'),ylabel('Pharse'),title('离散系统相频曲线')
end
