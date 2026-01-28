	#include<stdio.h>  
	#include<stdlib.h>  
	#include <winsock2.h>  
	#include <windows.h>  
	#include <string.h>  
	  
	#define IPV4 AF_INET  
	#define TYPE SOCK_STREAM  
	#define TCP IPPROTO_TCP  
	#define IPADDR "192.168.80.1"  
	#define PORT 9999  
	  
	void InitWSA();  
	int main()  
	{  
	    char senddata[255];//保存发送的信息  
    	char revdata[255];//保存接收的信息  
	    InitWSA();  
	    //创建套接字  
	    SOCKET s = socket(IPV4, TYPE, TCP);//TCP连接  
	    if (s == INVALID_SOCKET)  
	    {  
	        printf("socket creat error !");  
	        exit(1);  
	    }  
	    //创建socket信息结构体、设置IP和端口  
	    struct sockaddr_in addr;  
	    addr.sin_family = IPV4;//地址类型  
	    addr.sin_port = htons(PORT);//端口号  
	    addr.sin_addr.S_un.S_addr = inet_addr(IPADDR);//ip地址  
	    //绑定socket  
	    if (bind(s, (SOCKADDR*)&addr, sizeof(addr)) == SOCKET_ERROR)  
	    {  
	        printf("bind error !");  
	        exit(1);  	  
	    }  
	    //进入监听状态  
	    if (listen(s, 1) == SOCKET_ERROR)  
	    {  
	        printf("listen error !");  
	        exit(1);  
	    }  
	    SOCKET sClient;  
	    struct sockaddr_in clientaddr;  
	    int nAddrlen = sizeof(clientaddr);  
	    printf("服务器\n\n");  
	    printf("等待连接...\n");  
	    //接收客户端请求  
	    if((sClient = accept(s, (SOCKADDR *)&clientaddr, &nAddrlen))==INVALID_SOCKET)  
	    {  
	        printf("accept error !");  
	        exit(1);  
	    }  
	    printf("客户端：' %s '连接\n", inet_ntoa(clientaddr.sin_addr));  
	    while (1)  
	    {  
	        int ret = recv(sClient, revdata, 255, 0);  
	        if (ret > 0)  
	        {  
	            revdata[ret] = 0x00;  
	            if(strcmp(revdata,"对方关闭连接。")==0)  
	            {  
	                printf("  %s",revdata);  
	                closesocket(s);  
	                WSACleanup();  
	                exit(0);  
	            }  
	            printf("客户: %s\n\n",revdata);  
	        }  
	        //发送数据  
	        printf("服务器: ");  
	        scanf("%s",senddata);  
	        //输入exit退出  
	        if(strcmp(senddata,"exit")==0)  
	        {  
	            send(sClient, "对方关闭连接。", strlen("对方关闭连接。"), 0);  
	            closesocket(sClient);  
	            closesocket(s);  
	            WSACleanup();  
	            exit(0);  
	        }  
	        //从服务端正常发送数据  
	        send(sClient, senddata, strlen(senddata), 0);  
	        printf("\n");  
	    }  
	    return 0;  
	}  
	void InitWSA() //初始化WSA  
	{  
	    WORD sockVersion = MAKEWORD(2, 2);  
	    WSADATA wsaData;  
	    if (WSAStartup(sockVersion, &wsaData) != 0)  
	    {  
	        printf("Init error!\n");  
	        exit(1);  
	    }  
	}  

