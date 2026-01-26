% lab1:调试例题2-3的代码

wp=0.3*pi;ws=0.45*pi;
deltaw=ws-wp;
N0=ceil(6.6*pi/deltaw);
N = N0+mod(N0+1,2)  %为实现FIR类型1偶对称滤波器，应确保N为奇数
windows=triang(N);
wc=(ws+wp)/2/pi;   %截止频率取归一化通阻带频率的平均值
h=fir1(N-1,wc,windows);   %用firl函数求系统函数系数，windows可省略
[H,w]=freqz(h,1,1000,'whole');
H=(H(1:501))';w=(w(1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);
n=0:N-1;dw=2*pi/1000;
Rp = -(min(db(1:wp/dw+1)))    %检验通带波动
As = -round(max(db(ws/dw+1:501)))    %检验最小阻带衰减其余部分与例2-2完全相同。

subplot(2,2,1);stem(n,h);axis([0,N,1.1*min(h),1.1 *max(h)]);
title('实际脉冲响应');xlabel('n');ylabel('h(n)');

subplot(2,2,2);stem(n,windows);axis([0,N,0,1.1]);
title('窗函数特性');xlabel('n');ylabel('wd(n)');

subplot(2,2,3);plot(w/pi,db);axis([0,1,-80,10]);
title('幅度频率响应');xlabel('频率（单位: lpi) ');ylabel('H(e^{j\omega}');
set(gca,'XTickMode', 'manual','XTick',[0,wp/pi,ws/pi,1 ]);
set(gca,'YTickMode','manual','YTick',[-50,-20,-3,0]);grid

subplot(2,2,4);plot(w/pi,pha);axis([0,1,-4,4]);
title('相位频率响应');xlabel('频率（单位:pi） ');ylabel('phi(omega)');
set(gca,'XTickMode', 'manual','XTick',[0,wp/pi,ws/pi,1 ]);
set(gca,'YTickMode', 'manual','YTick',[-3.1416,0,3.1416,4]);grid
