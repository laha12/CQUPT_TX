% lab1:调试例题2-1的代码

N=64;beta=7.865;n=1:N;
wbo=boxcar(N);
wtr=triang(N);
whn=hanning(N);
whm=hamming(N);
wbl=blackman(N);
wka=kaiser(N,beta);
plot(n,wbo,'-',n,wtr,'*',n,whn,'+',n,whm,'.',n,wbl,'o',n,wka,'d');
axis([0,N,0,1.1]);
legend('矩形', '三角形','汉宁','哈明','布莱克曼','凯塞')
