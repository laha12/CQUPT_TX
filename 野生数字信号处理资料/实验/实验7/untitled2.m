%考试人：陈丽雯；题号：6_2
wp = 0.3*pi; ws = 0.5*pi;
deltaw = ws-wp;
N0 = ceil(40*pi/deltaw);
N = N0+mod(N0+1,2);
windows = bartlett(N);
wc =(ws+wp)/2/pi;
b = fir1(N-1,wc,windows);
[H,w] = freqz(b,1,1000,'whole');
H = (H(1:501))';w = (w(1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
pha = angle(H);
n = 0:N-1;dw = 2*pi/1000;
Rp = -(min(db(1:wp/dw+1)))
As = -round(max(db(ws/dw+1:501)))
figure('name','低通')
subplot(211);stem(n,b);axis([0,N,1.1*min(b),1.1*max(b)]);title('单位脉冲响应h(n)');xlabel('n');ylabel('h(n)');
subplot(212);plot(w/pi,db);axis([0,1,-80,10]);title('损耗函数曲线');xlabel(' 频率(\pi)');ylabel('H(e^{j\omega})');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'YTickMode','manual','YTick',[-50,-24,-1,0]);grid on;
