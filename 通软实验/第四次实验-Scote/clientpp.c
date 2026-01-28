	#include<stdio.h>
	#include<string.h>
	#include <winsock2.h>
	#include <windows.h>
	#pragma comment(lib,"ws2_32.lib")
	#include <STDIO.H>
	
	int main(int argc, char* argv[])
	{
		int i;
	 char a[20] = { 0 };
	 WORD sockVersion = MAKEWORD(2, 2);
	 WSADATA data;
	 if (WSAStartup(sockVersion, &data) != 0)
	 {
	  return 0;
	 }
	
	 SOCKET sclient = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	 if (sclient == INVALID_SOCKET)
	 {
	  printf("invalid socket !");
	  return 0;
	 }
	
	 struct sockaddr_in serAddr;
	 serAddr.sin_family = AF_INET;
	 serAddr.sin_port = htons(6666);
	 serAddr.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
	 if (connect(sclient, (struct sockaddr*)&serAddr, sizeof(serAddr)) == SOCKET_ERROR)
	 {
	  printf("connect error !");
  closesocket(sclient);
	  return 0;
	 }
	 for (i = 0; i < 1000; i++)
	 {
	  printf("客户端向服务器发送：");
	  scanf_s("%s", a, 20);
	  char test[] = { 0 };
	  strcpy(test, a);
	  char* sendData = test;
	  send(sclient, sendData, strlen(sendData), 0);
	  char recData[255];
	  int ret = recv(sclient, recData, 255, 0);
	  if (ret > 0)
	  {
	
	   recData[ret] = 0x00;
	   printf("客户端接收到来自服务器的消息：");
	   printf("%s",recData);
	   printf("\n");
  }

 }
 closesocket(sclient);
 WSACleanup();
return 0;	}

