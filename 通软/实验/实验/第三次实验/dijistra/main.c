#include <stdio.h>
#include <stdlib.h>
#include <string.h>
struct node
{
    char area[10];
    int number;
}node[8];
struct route
{
    int orign;
    int end;
    int length;
}route[8];
int d[8]={10000};
int s[8]={0};
int Visited[8];
int pre[8];
int m;
void Dijkstra(int begin,int G_edge[8][8])//迪杰斯特拉
{
    int i=0;
    Visited[0]=1;
    s[0]=begin;
    printf("更新距离\n");
    Update(begin,G_edge);
    for(i=1;i<8;i++)
    {
        printf("\n");
        printf("第%d次找最小:\n",i);
        begin=Find_Min(begin,G_edge);//找最小
        s[i]=begin;
        Visited[begin]=1;
        printf("更新距离\n");
        Update(begin,G_edge);
    }
    printf("\n");
}
void Update(int begin,int G_edge[8][8])//更新距离
{
    int i;
    int temp;
    for(i=0;i<8;i++)
    {
       if(begin==0)
        {
            d[i]=G_edge[begin][i];
            if(G_edge[begin][i]==0)
            {
                d[i]=1000;
            }
            if(G_edge[begin][i]!=0)
            {
                pre[i]=begin;
            }
        }
        else
        {
            temp=d[begin]+G_edge[begin][i];
            if(G_edge[begin][i]!=0&&d[i]>temp&&Visited[i]!=1)
            {
                d[i]=temp;
                pre[i]=begin;
            }
        }
        d[0]=0;
        printf("d[%i]=%d   ",i+1,d[i]);
    }
    printf("\n");
}
int Find_Min(int n,int G_edge[8][8])//找最小
{
    int i;
    int j;
    int min=500;
    int Min_node;
    for(i=0,j=0;i<8;i++,j++)
    {
        if(d[i]<min&&Visited[i]!=1)
        {
            min=d[i];
            Min_node=i;
        }
    }
    printf("节点%d距离最短\n",Min_node+1);
    return Min_node;
}
int main()
{
    struct node node[8];
    struct route route[8];
    int want;
    int j;
    int i;
    int k=0;
    int b=0;
    int a=0;
    int G_edge[8][8];
    int save[8];
    int n;
    FILE *fp=fopen("D:\\A网课\\通软\\实验\\第三次实验\\实验3数据.txt","r");//打开文件
    printf("——显示节点——\n");
    for(i=0;i<8;i++)//显示节点
    {
        fscanf(fp,"%s",node[i].area);
        node[i].number=i;
        printf("节点%d：%s\n",node[i].number++,node[i].area);
    }
    printf("\n———显示路径———\n");
    for(j=0;j<15;j++)//显示路径
    {
        fscanf(fp,"%d%d%d",&route[j].orign,&route[j].end,&route[j].length);
        printf("节点%d 节点%d 路径长度%d\n",route[j].orign,route[j].end,route[j].length);
    }
    //建立邻接矩阵
    for(i=0;i<8;i++)
    {
        for(j=0;j<8;j++)
        {
            if(i==route[a].orign-1&&j==route[b].end-1&&j>=i)
            {
                G_edge[i][j]=route[k].length;
                k++;
                b++;
                a++;
            }
            else if(j<i)
            {
                G_edge[i][j]=G_edge[j][i];
            }
            else
                G_edge[i][j]=0;
        }

    }
    printf("\n");
    printf("\n");
    //输出邻接矩阵
    printf("———————邻接矩阵输出———————\n");
    printf("\n");
    for(i=1;i<=8;i++)
    {
        printf(" %3d ",i);
    }
    printf("\n_________________________________________\n");
    for(i=0;i<8;i++)//显示邻接矩阵
    {
        node[i].number=i;
        printf("%d|",node[i].number+1);
        for(j=0;j<8;j++)
        {
            printf("%3d  ", G_edge[i][j]);//左对齐输出
        }
        printf("\n");
    }
    printf("\n");
    printf("\n");
    fclose(fp);
    printf("——————————————利用Dijkstra算法得最短路径——————————————\n");
    Dijkstra(0,G_edge);
    for(i=0;i<8;i++)
        printf("节点%d的前继节点为:%d\n",i+1,pre[i]+1);
    printf("请输入您想知道最短路径的节点：");
    scanf("%d",&want);
    if(want>8)
    {
        printf("不符合要求，请重新输入：");
        scanf("%d",&want);
    }
    printf("源节点1到节点%d的最短路径长度为：%d\n",want,d[want-1]);
    printf("显示必经节点：");
    m=want-1;
    for(i=0,n=0;i<=8;i++)
    {
        save[n]=pre[m];
        n++;
        if(pre[m]==0)
            break;
        m=pre[m];
    }
    printf("\n");
    for(i=n-1;i>=0;i--)
    {
        printf("%d——>",save[i]+1);
    }
    printf("%d\n",want);
    return 0;
}
