#include <stdio.h>
#include <stdlib.h>
#include <winsock2.h>
#include <windows.h>
#include <string.h>

//#pragma comment(lib,"ws2_32.lib")

#define IPV4 AF_INET
#define TYPE SOCK_STREAM
#define TCP IPPROTO_TCP
#define IPADDR "192.168.1.100"
#define PORT 9999

void InitWSA();

int main()

{
    char senddata[255]; //用来存放发送的字符信息
    char revdata[255]; //用来存放接收的字符信息
    printf("客户\n\n");

    InitWSA();
    SOCKET s = socket(IPV4, TYPE, TCP);//创建socket
    if (s == INVALID_SOCKET)

    {
        printf("socket creat error !");
        exit(1);
    }

    struct sockaddr_in addr;//创建socket信息结构体
    addr.sin_family = IPV4;//设置IP和端口
    addr.sin_port = htons(PORT);
    addr.sin_addr.S_un.S_addr = inet_addr(IPADDR);

    //连接socket
    if (connect(s, (SOCKADDR*)&addr, sizeof(addr)) == SOCKET_ERROR)

    {
        printf("connect error !");
        closesocket(s);
        exit(1);
    }

    printf("连接成功！\n");

    while(1)
    {
        //发送
        printf("客户: ");
        scanf("%s",senddata);
        //输入exit退出，并发送消息给对方
        if(strcmp(senddata,"exit")==0)
        {
            send(s, "对方关闭连接。", strlen("对方关闭连接。"), 0);
            closesocket(s);
            WSACleanup();
            exit(0);
        }
        //正常发送
        send(s, senddata, strlen(senddata), 0);
        printf("\n");
    }
    return 0;
}
