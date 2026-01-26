%% 问题二
%% 系统1
B1=[0 2 -1.6 -0.9];
A1=[1 -2.5 1.96 -0.48];
subplot(1,2,1);
zplane(B1,A1);
grid on;
legend('零点','极点');
title('系统1零极点分布图');
subplot(1,2,2);
impz(B1,A1,30);
grid on;
figure;
%% 系统2
B2=[0 0 0 1 -1];
A2=[1 -0.9 -0.65 0.873 0];
subplot(1,2,1);
zplane(B2,A2);
grid on;
legend('零点','极点');
title('系统2零极点分布图');
subplot(1,2,2);
impz(B2,A2,30);
grid on;