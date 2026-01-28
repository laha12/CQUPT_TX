#include <stdio.h>
#include <stdlib.h>
#define MAX_Edge 30
struct node
{
    char city[10];
    int number;
}node[10];
struct route
{
    int begin;
    int end;
}route[MAX_Edge];
struct node node[10];
int Number_All=10;//节点总数
int Edge_All=0;//边数
int G_edge[10][10];//存储邻接表内容
int Depth_finish=1;
int Width_finish=1;
int Depth_Visited[10];
int Width_Visited[10];
int next;
int save[10];
struct route route[MAX_Edge];
void Openfp()//打开文件存储节点
{
    int i;
    int j;
    FILE *fp=fopen("D:\\A网课\\通软\\实验\\第四次实验\\实验4数据.txt","r");//打开文件
    if(fp==NULL)
    {
        printf("文件打开失败\n");
        return ;
    }
    printf("节点数：%d\n",Number_All);
    for(i=0;i<10;i++)//存储节点信息
    {
        fscanf(fp,"%s",node[i].city);
        node[i].number=i+1;
        printf("节点%2d:%s\n",node[i].number,node[i].city);
    }
    printf("\n");
    for(j=0;j<MAX_Edge;j++)//存储边的信息
    {
        if (fscanf(fp,"%d%d",&route[j].begin,&route[j].end) == EOF)
        {
            printf("读取结束\n");
             break;
        }
        Edge_All++;//记录边的个数
        printf("第%d条边：节点%d  节点%d\n",j+1,route[j].begin,route[j].end);
    }
    fclose(fp);
    printf("边数：%d\n",Edge_All);//输出总的边数
}
void Creat_Graph()//制造邻接表
{
    int i;
    int j;
    int a=0;
    int b=0;
    for(i=0;i<10;i++)//存储邻接表
    {
        for(j=0;j<10;j++)
        {
            if(i==route[a].begin-1&&j==route[b].end&&j>=i)
            {
                G_edge[i][j]=1;
                a++;
                b++;
            }
            else if(j<i)
            {
                G_edge[i][j]=G_edge[j][i];
            }
            else
            {
                G_edge[i][j]=0;
            }
             printf("%3d",G_edge[i][j]);
        }
         printf("\n");
    }
}
 void Depth_First(int orign)//深度优先遍历
 {
     int i;
     if(Depth_finish<10)
     {
         for(i=0;i<10;i++)
         {
             if(G_edge[orign-1][i]!=0&&i!=orign-1&& Depth_Visited[i]!=1)
             {
                 printf("%d、%s—>",i+1,node[i].city);
                 Depth_finish++;
                 Depth_Visited[i]=1;
                 break;
             }
         }
     }
     else
        return;
      Depth_First(i+1);
 }
 void Width_First(int orign)//广度优先遍历
 {
     int j=0;
     int i;
     if(Width_finish<10)
     {
         for(i=0;i<10;i++)
       {
            if(G_edge[orign-1][i]!=0&&i!=orign-1&& Width_Visited[i]!=1)
          {
              printf("%d、%s—>",i+1,node[i].city);
              Width_finish++;
              save[j]=i+1;
              j++;
              Width_Visited[i]=1;
              next=i+1;
           }
         }
     }
     else
     {
         return;
     }
     for(i=0;i<j;i++)
     {
         Width_First(save[i]);
     }
 }
int main()
{
    int want;
    Openfp();
    printf("\n");
    printf("邻接表如下：\n");
    Creat_Graph();
    printf("\n");
    printf("请输入您想要开始遍历的节点：");
    scanf("%d",&want);
    Depth_Visited[want-1]=1;
    Width_Visited[want-1]=1;
    printf("深度优先搜索结果：\n");
    printf("%d、%s—>",want,node[want-1].city);
    Depth_First(want);//深度优先遍历
    printf("\n");
    printf("广度优先搜索结果：\n");
    printf("%d、%s—>",want,node[want-1].city);
    Width_First(want);//广度优先遍历
    printf("\n");
    printf("遍历结束\n");
    if(Depth_finish==10)
    {
        printf("是连通图，所有节点都遍历\n");
    }
    else
    {
        printf("不是连通图\n");
    }
    return 0;
}
