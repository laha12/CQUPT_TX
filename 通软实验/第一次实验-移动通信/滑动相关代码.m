close all;
clear all;
for i=20:31
    data=load(['C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\data',num2str(i),'.txt']);
    for j=0:2
        PSS= load(['C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\PSS',num2str(j),'.txt']);
        [m,n]=size(data);
        [m1,n1]=size(PSS);
        PSS = padarray(PSS, [m-m1 0], 0, 'post');
        [correlation1, lags1] = xcorr(data((1: 2: end),1), PSS((1: 2: end),1),m1/2);%对自同步信号I路填充
        [correlation2, lags2] = xcorr(data((2: 2: end),1), PSS((2: 2: end),1),m1/2);%对自同步信号Q路填充
        figure;
        subplot(3,2,1);
        plot(data((1: 2: end),1));
        xlabel(['data',num2str(i),'I路信号量']);
        ylabel(['data',num2str(i),'I路信号强度']);
        subplot(3,2,2);
        plot(data((2: 2:end),1));
        xlabel(['data',num2str(i),'Q路信号量']);
        ylabel(['data',num2str(i),'Q路信号强度']);
        subplot(3,2,3);
        plot(PSS((1: 2: m1),1));
        xlabel(['PSS',num2str(j),'I路信号量']);
        ylabel(['PSS',num2str(j),'I路信号强度']);
        subplot(3,2,4);
        plot(PSS((2: 2: m1),1));
        xlabel(['PSS',num2str(j),'Q路信号量']);
        ylabel(['PSS',num2str(j),'Q路信号强度']);
        subplot(3,2,5);
        plot(lags1, correlation1);
        xlabel('滞后');
        ylabel('I路相关性');
        title(['I路相关性分析']);
        subplot(3,2,6);
        plot(lags2, correlation2);
        xlabel('滞后');
        ylabel('Q路相关性');
        title(['Q路相关性分析']);
        clear PSS;
    end
    clear data;
end