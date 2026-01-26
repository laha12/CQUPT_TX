%% 低通滤波器
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
%% 高通滤波器
ws = 0.4*pi; wp = 0.6*pi;
Rp = 0.2; As = 43;    % 根据阻带最小衰减，应选取汉宁窗
Bt = wp - ws;   % 计算过渡带宽度
N0 = ceil(6.2*pi/Bt);
N = N0 + mod(N0+1, 2);
wc = (wp + ws)/2/pi; % 计算理想高通滤波器通带截止频率（关于π归一化）
h = fir1(N-1, wc, 'high', hanning(N)); % 参数选择'high',设计高通滤波器
[H, w] = freqz(h, 1, 1000, 'whole');
H = H(1:501); w = w(1:501);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
subplot(221);stem(0:N-1,h,'.');xlabel('n');ylabel('h(n)');title('h(n)波形');
subplot(222);plot(w/pi,abs(H));ylabel('|H(e^{j\omega})|');xlabel('\omega/\pi');title('系统幅频特性曲线')
subplot(223);plot(w/pi,angle(H)/pi);ylabel('\theta(\omega)');xlabel('\omega/\pi');title('系统相频特性曲线')
subplot(224);plot(w/pi,db);xlabel('\omega/\pi');ylabel('-A(\Omega)');title('损耗函数曲线');
%% 带通滤波器
wlp = 0.2*pi; wup = 0.6*pi; wls = 0.15*pi; wus=0.65*pi;
Rp = 1; As = 50;    % 根据阻带最小衰减，应选取哈明窗
Bt = wus - wup;   % 计算过渡带宽度
N0 = ceil(6.6*pi/Bt);
N = N0 + mod(N0+1, 2);
wc = [(wlp + wls)/2/pi, (wup + wus)/2/pi]; % 计算理想高通滤波器通带截止频率（关于π归一化）
h = fir1(N-1, wc, hamming(N)); 
[H, w] = freqz(h, 1, 1000, 'whole');
H = H(1:501); w = w(1:501);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
subplot(221);stem(0:N-1,h,'.');xlabel('n');ylabel('h(n)');title('h(n)波形');
subplot(222);plot(w/pi,abs(H));ylabel('|H(e^{j\omega})|');xlabel('\omega/\pi');title('系统幅频特性曲线')
subplot(223);plot(w/pi,angle(H)/pi);ylabel('\theta(\omega)');xlabel('\omega/\pi');title('系统相频特性曲线')
subplot(224);plot(w/pi,db);xlabel('\omega/\pi');ylabel('-A(\Omega)');title('损耗函数曲线');
%% 带阻滤波器
wls = 0.2*pi; wus = 0.6*pi; wlp = 0.15*pi; wup=0.65*pi;
Rp = 1; As = 45;    % 根据阻带最小衰减，应选取哈明窗
Bt = wls - wlp;   % 计算过渡带宽度
N0 = ceil(6.6*pi/Bt);
N = N0 + mod(N0+1, 2);
wc = [(wlp + wls)/2/pi, (wup + wus)/2/pi]; % 计算理想高通滤波器通带截止频率（关于π归一化）
h = fir1(N-1, wc,'stop', hamming(N)); 
[H, w] = freqz(h, 1, 1000, 'whole');
H = H(1:501); w = w(1:501);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
subplot(221);stem(0:N-1,h,'.');xlabel('n');ylabel('h(n)');title('h(n)波形');
subplot(222);plot(w/pi,abs(H));ylabel('|H(e^{j\omega})|');xlabel('\omega/\pi');title('系统幅频特性曲线')
subplot(223);plot(w/pi,angle(H)/pi);ylabel('\theta(\omega)');xlabel('\omega/\pi');title('系统相频特性曲线')
subplot(224);plot(w/pi,db);xlabel('\omega/\pi');ylabel('-A(\Omega)');title('损耗函数曲线');