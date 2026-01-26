function [bd, ad] = low_pass_filter(wp, ws, Rp, As, Fs)
%LPF:利用巴沃斯滤波器间接实现一个低通滤波器的设计
%   在一个figure中画出滤波器：幅频响应、相频响应、衰减特性、零极图
%   wp：滤波器的通带截止频率
%   ws：滤波器的阻带截止频率
%   Rp：滤波器的通带最大衰减
%   As：滤波器的阻带最小衰减
%   Fs：采样频率

%模拟滤波器指标
    T = 1/Fs;
    Omagp = (2/T)*tan(wp/2);
    Omags = (2/T)*tan(ws/2);
%     Omagp = wp*Fs;
%     Omags = ws*Fs;
    ripple = 10^(-Rp/20);   % 滤波器的通带衰减对应的幅度值|H(jomaga_p)|
    Attn   = 10^(-As/20);     % 滤波器的阻带衰减对应的幅度值|H(jomaga_s)|
    [N,Omagc]=buttord(Omagp, Omags, Rp, As, 's');   %滤波器的阶数N和3dB截止频率
    [ba, aa] = butter(N, Omagc, 's');   %系统函数分子分母多项式系数

    [bd, ad] = bilinear(ba, aa, Fs);    % 用双线性变换法
%     [bd, ad] = impinvar(ba, aa, Fs);      % 脉冲响应不变法
    
    [H, w] = freqz(bd, ad);     %求数字系统的频率特性
    dbH = 20*log10((abs(H)+eps)/max(abs(H)));
    
    % 幅频响应
    subplot(311);plot(w/pi, abs(H));    
    ylabel('|H(e^{j\omega})|');xlabel('\omega/\pi');
    title('幅频响应');axis([0,1,0,1.1]);
    set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
    set(gca,'YTickMode','manual','YTick',[0,Attn,ripple,1]);grid
    % 相频响应
    subplot(312);plot(w/pi, angle(H)/pi);  
    ylabel('\theta(\omega)');xlabel('\omega/\pi');
    title('相频响应');axis([0,1,-1,1]);
    set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
    set(gca,'YTickMode','manual','YTick',[-1,0,1]);grid
    % 幅度响应
    subplot(313);plot(w/pi, dbH);title('幅度响应(dB)');axis([0,1,-40,5]);
    ylabel('dB');xlabel('\omega/\pi');
    set(gca,'XTickMode','manual','XTick',[0,wp/pi,ws/pi,1]);
    set(gca,'YTickMode','manual','YTick',[-As,-Rp,1]);grid
%     % 零极图
%     subplot(224);zplane(bd, ad);axis([-1.1,1.1,-1.1,1.1]);title('零极点图');
end