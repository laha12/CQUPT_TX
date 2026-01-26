function h = fir_lowpass_filter(wp,ws,As)
%   函数设计一个低通滤波器，在一个figure中画出窗函数时域波形、滤波器h(n)、滤波器的幅频特性、相频特性
%   根据参数As选择对应的窗函数
%   输入：
%   wp:通带边界频率
%   ws:阻带边界频率
%   As:阻带最小衰减
%   Rp:通带最大衰减
%   输出;
%   h;滤波器时域函数

deltaw = ws - wp;   % 过渡带宽度
N0 = ceil(6.6*pi/deltaw);
N = N0 + mod(N0+1, 2);  % 为实现FIR类型1偶对称滤波器，应确保N为奇数
% 根据阻带最小衰减选用对应的窗函数，具体见表2-1
if As <= 21
    windows = boxcar(N);    %如果阻带最小衰减小于21dB，选择矩形窗
    disp('boxcar');
elseif (As > 21) && (As <= 25)
    windows = triang(N);  %如果阻带最小衰减小于25dB，选择三角形窗
    disp('triang');
elseif (As > 25) && (As <= 44)
    windows = hanning(N);   %如果阻带最小衰减小于44dB，选择汉宁窗
    disp('hanning');
elseif (As > 44) && (As <= 53)
    windows = hamming(N);   %如果阻带最小衰减小于53dB，选择哈明窗
    disp('hamming');
elseif (As > 53) && (As <= 74)
    windows = blackman(N);   %如果阻带最小衰减小于74dB，选择布莱克曼窗
    disp('blackman');
elseif (As > 74) && (As <= 80)
    windows = kaiser(N, 7.865);  %如果阻带最小衰减小于80dB，选择凯赛窗
    disp('kaiser');
end

wc = (wp + ws)/2/pi;    % 计算理想低通滤波器通带截止频率（关于Π归一化）
h = fir1(N-1, wc, windows); % 用fir1函数求系统函数
[H, w] = freqz(h,1, 1000,'whole');  % 求离散时间系统频响特性，返回[0,2pi）上1000个频率点的值
H = (H(1:501))'; w = (w(1:501))'; 
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
pha = angle(H);
n = 0:N-1; dw = 2*pi/1000;
% Rp = -(min(db(1:wp/dw+1))); %检验通带波动
% As = -round(max(db(ws/dw+1:501)));  %检验最小阻带衰减

figure();
subplot(221);stem(n,h,'.');axis([0,N,1.1*min(h),1.1*max(h)]);
title('实际脉冲响应');xlabel('n');ylabel('h(n)');

subplot(222);stem(n,windows,'.');axis([0,N,0,1.1]);
title('窗函数特性');xlabel('n');ylabel('wd(n)');

subplot(223);plot(w/pi,db);axis([0,1,1.1*min(db),1.1*max(db)]);
title('幅度相应特性');xlabel('频率（单位：\pi）');ylabel('幅度/dB');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'YTickMode','manual','YTick',[-50,-20,-3,0]);grid

subplot(224);plot(w/pi,pha);axis([0,1,-4,4]);
title('相位相应特性');xlabel('频率（单位：\pi）');ylabel('\phi(\omega)');
set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
set(gca,'YTickMode','manual','YTick',[-pi,0,pi,4]);grid
end

