function [] = fft8_16_32(x)
%	绘制信号的时域波形和8点、16点、32点DFT离散幅度谱
%   x:输入信号
subplot(411);stem(0:length(x)-1,x,'filled');title("信号的时域波形x(n)");
% 8点
xk_8 = fft(x,8);
subplot(412);stem(0:7,abs(xk_8),'filled');title("信号的8点DFT幅度谱");
% 16点
xk_16 = fft(x,16);
subplot(413);stem(0:15,abs(xk_16),'filled');title("信号的16点DFT幅度谱");
% 32点
xk_32 = fft(x,32);
subplot(414);stem(0:31,abs(xk_32),'filled');title("信号的32点DFT幅度谱");
end

