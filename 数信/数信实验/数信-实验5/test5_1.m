%% 问题一
clear all;
clc;
% 原信号参数
A=444.128;
alpha=50*pi*(2)^0.5;
omega=50*pi*(2)^0.5;
% 采样参数
f=10000;
M=1024;%时域采样点数
fs=[1e3,3e2,2e2];
Tp=64e-3;
% 信号可视化
t=0:1/f:Tp;
n=0:M-1;
xt=A*exp(-alpha*t).*sin(omega*t);
Y=fft(xt,M);
ym=abs(Y)/f;
figure;
subplot(2,1,1);
plot(t,xt,'LineWidth',1.5,'Color','#BB9727');grid on;
xlabel("t/s");ylabel("x_a(t)");title("原始模拟信号");
subplot(2,1,2);
plot((0:M/2-1)*f/M,ym(1:M/2),'LineWidth',1.5);grid on;%前5000HZ 及前512个点
xlabel("f/Hz");ylabel("幅度");title("原信号幅度特性");
for i =1:length(fs)
    N=ceil(Tp*fs(i));
    n1=0:N-1;
    xnn= A*exp(-alpha*n1/fs(i)).*sin(omega*n1/fs(i)); 
    Y=fft(xnn,N);
    y=abs(Y./fs(i));
    figure;
    subplot(2,1,1);
    stem(n1,xnn,'filled','Linewidth',0.8,'Color','#BB9727');grid on;
    xlabel('n');ylabel('x(n)');title(['采样序列',num2str(i),'  Fs=',num2str(fs(i)),'Hz']);
    axis([0 N+5 -50 200]);
    subplot(2,1,2);
    plot(n1*fs(i)/N,y,'LineWidth',1.5);grid on;
    xlabel("f/Hz");ylabel("幅度");title(['采样序列',num2str(i),'幅度特性']);
end
    
    