%% 问题2
clear all;
clc;
clf;
% 序列
n1=0:1:13;
n2=14:1:26;
x=[n1+1,-n2+27];
M=1024;
%DFT
xk = fft(x,M); 
xk16 = xk(1:M/16:M); %等间隔取16点
xk32 = xk(1:M/32:M);%等间隔取32点
%IDFT
x16 = ifft(xk16);  
x32 = ifft(xk32);
% 可视化
figure;
subplot(3,1,1);
plot(2*(0:M-1)/M,abs(xk),'LineWidth',1.5,'color','#ff8884');grid on;
xlabel('\omega/\pi');ylabel('|X(e^{j\omega})|');title('FT[x(n)]');
subplot(3,1,2);
stem(0:length(xk16)-1,abs(xk16),'fill','color','#ff8884');grid on;
xlabel('k');ylabel('|X_{16}(k)|');title('16点频域采样');
subplot(3,1,3);
stem(0:length(xk32)-1,abs(xk32),'fill','color','#ff8884');grid on;
xlabel('k');ylabel('|X_{32}(k)|');title('32点频域采样');
figure;
subplot(3,1,1);
stem(0:length(x)-1,x,'fill');grid on;
xlabel('n'),title('x(n)');
subplot(3,1,2);
stem(0:length(x16)-1,x16,'fill');grid on;
xlabel('n');title('X_{16}(n)');
subplot(3,1,3);
stem(0:length(x32)-1,x32,'fill');grid on;
xlabel('n');title('x_{32}(n)');

