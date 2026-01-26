% desinged by chen zhili
% 2023-11-15
clc,clear,close all
%% 对例题1进行改编
wp=0.25*pi;                     %滤波器的通带截止频率
ws=0.4*pi;                      %滤波器的阻带截止频率
Rp=1;As=15;                     %滤波器的通阻带衰减指标
Fs=2000;T=1/Fs;
[bd,ad] = low_pass_filter(wp,ws,Rp,As,Fs)     % 利用编写的滤波器函数

% ripple=10^(-Rp/20);             %滤波器的通带衰减对应的幅度值
% Attn=10^(-As/20);               %滤波器的阻带衰减对应的幅度值
%                                 %转换为模拟滤波器的技术指标
% Omgp=wp*Fs;Omgs=ws*Fs;
%                                 %模拟原型滤波器计算
% [n,Omgc]=buttord(Omgp,Omgs,Rp,As,'s')       %计算阶数n和截止频率
% [z0,p0,k0]=buttap(n);                       %设计归一化的巴特沃思模逆滤波器原型
% bal=k0*real(poly(z0));                      %求原型滤波器的系数b
% aal=real(poly(p0));                         %求原型滤波器的系数a
% [ba,aa]=lp2lp(bal,aal,Omgc);                %变换为模拟低通滤波器
% %用脉冲响应不变法计算数字滤波器系数
% [bd,ad]=impinvar(ba,aa,Fs)
% [H,w]=freqz(bd,ad);                         %求数字系统的频率特性
% dbH=20*log10((abs(H)+eps)/max(abs(H)));
% subplot(2,2,1);plot(w/pi,abs(H));
% ylabel('|H|');title('幅度响应');axis([0,1,0,1.1]);
% set(gca,'XTickMode','manual','XTick',[0,0.25,0.4,1]);
% set(gca,'YTickMode','manual','YTick',[0,Attn,ripple,1]);grid
% 
% subplot(2,2,2);plot(w/pi,angle(H)/pi);
% ylabel('phi');title('相位响应');axis([0,1,-1,1]);
% set(gca,'XTickMode','manual','XTick',[0,0.25,0.4,1]);
% set(gca,'YTickMode','manual','YTick',[-1,0,1]);grid
% subplot(2,2,3);plot(w/pi,dbH);title('幅度响应(dB)');
% ylabel('dB');xlabel('频率(pi)');axis([0,1,-40,5]);
% set(gca,'XTickMode','manual','XTick',[0,0.25,0.4,1]);
% set(gca,'YTickMode','manual','YTick',[-50,-15,-1,0]);grid
% subplot(2,2,4);zplane(bd,ad);axis([-1.1,1.1,-1.1,1.1 ]);title('零极点图');
