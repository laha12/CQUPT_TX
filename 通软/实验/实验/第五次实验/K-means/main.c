#include <stdio.h>
#include <stdlib.h>
#include<math.h>
#define MAX_Node 20
#define MAX_Text 20
struct node
{
    int number;//节点序号
    char city[20];//节点名称
    int score[3];//节点的三年成绩
}node[MAX_Node];
struct node node[MAX_Node];
int City_All=0;//记录城市总数
double Normal_data[MAX_Node][3]={0};//存储规格化后的数据
double A[MAX_Text][3];//每一次分类时簇心三年的数据
double B[MAX_Text][3];//每一次分类时簇心三年的数据
double C[MAX_Text][3];//每一次分类时簇心三年的数据
int top1[MAX_Text][MAX_Node];//每一次分类结果
int top2[MAX_Text][MAX_Node];//每一次分类结果
int top3[MAX_Text][MAX_Node];//每一次分类结果
int A_save[MAX_Text]={0};//记录A类节点存储的数目-1
int B_save[MAX_Text]={0};//记录B类节点存储的数目-1
int C_save[MAX_Text]={0};//记录C类节点存储的数目-1
int count=0;//记录分类次数-1；
int judge=1;//判断分类是否成功
double d[3][MAX_Node];//记录各点到簇心的距离
void Openfp()//打开文件存储节点
{
    printf("进入文件...\n");
    int i;
    int j;
    FILE *fp=fopen("D:\\A网课\\通软\\实验\\第五次实验\\实验5数据.txt","r");//打开文件
    if(fp==NULL)
    {
        printf("文件打开失败\n");
        return ;
    }
    for(i=0;i<MAX_Node;i++)//存储节点信息
    {
        if(fscanf(fp,"%d%s",&node[i].number,node[i].city)!=EOF)//存储国家编号以及名称
        {
            City_All++;//读取到一个国家进行加一操作
            printf("%2d %12s:",node[i].number,node[i].city);
            for(j=0;j<3;j++)
            {
                fscanf(fp,"%d",&node[i].score[j]);//存储每个国家三年的成绩
                printf("%2d  ",node[i].score[j]);
            }
        }
        else
        {
            printf("读取结束!\n");
            fclose(fp);
            break;
        }
        printf("\n");
    }
    return;
}
void Normalize()//规格化数据
{
    printf("进行规格化数据:\n");
    int i,j;
    int min[3]={80};
    int max[3]={50};
    for(j=0;j<3;j++)//寻找每一年得分最多和最少是多少
    {
        min[j]=80;
        for(i=0;i<City_All;i++)
        {
            if(min[j]>node[i].score[j])//得分最少
            {
                min[j]=node[i].score[j];
            }
            if(max[j]<node[i].score[j])//得分最多
            {
                max[j]=node[i].score[j];
            }
        }
        printf("第%d年：min=%d  max=%d\n",j+1,min[j],max[j]);
    }
    printf("规格化数据为：\n");
    for(j=0;j<3;j++)
    {
        for(i=0;i<City_All;i++)
        {
            Normal_data[i][j]=(double)(node[i].score[j]-min[j])/(max[j]-min[j]);
        }
    }
    return;

}
void Display_Normal()
{
    int i,j;
    for(i=0;i<City_All;i++)
    {
        printf("%2d %12s:",node[i].number,node[i].city);
        for(j=0;j<3;j++)
        {
            printf("%.2f  ",Normal_data[i][j]);
        }
        printf("\n");
    }
    return;
}
void K_means()
{
    int i;
    int select[3]={0};
    printf("请按照顺序填入您选择的质心的序号(1-%d),中间以“，”隔开：",City_All);
    scanf("%d,%d,%d",&select[0],&select[1],&select[2]);//输入选择的质心
    for(i=0;i<3;i++)
    {
        A[count][i]=Normal_data[select[0]-1][i];
        B[count][i]=Normal_data[select[1]-1][i];
        C[count][i]=Normal_data[select[2]-1][i];
    }
    printf("选择的国家为：%s  %s  %s\n",node[select[0]-1].city,node[select[1]-1].city,node[select[2]-1].city);
    Calclute_Dist();//计算距离
    Classify();//分类
    while(judge!=0)
    {
         Update();
         Calclute_Dist();
         Classify();
         judge=Judge_Success();

    }
    return;
}
void Calclute_Dist()//计算到各个簇点的距离
{
    int i,j;
    printf("各个点到簇心距离如下,从左到右依次为距A,B,C类簇心的距离:\n");
     for(i=0;i<City_All;i++)
    {
        printf("%12s:",node[i].city);
        d[0][i]=sqrt(pow(Normal_data[i][0]-A[count][0],2)+pow(Normal_data[i][1]-A[count][1],2)+pow(Normal_data[i][2]-A[count][2],2));//计算距离
        d[1][i]=sqrt(pow(Normal_data[i][0]-B[count][0],2)+pow(Normal_data[i][1]-B[count][1],2)+pow(Normal_data[i][2]-B[count][2],2));//计算距离
        d[2][i]=sqrt(pow(Normal_data[i][0]-C[count][0],2)+pow(Normal_data[i][1]-C[count][1],2)+pow(Normal_data[i][2]-C[count][2],2));//计算距离
        printf("%.4lf  %.4lf  %.4lf  \n",d[0][i],d[1][i],d[2][i]);
    }
    return;
}
void Classify()
{
    int i;
    for(i=0;i<City_All;i++)//分类
    {
        if((d[0][i]<d[1][i]&&d[1][i]<d[2][i])||(d[0][i]<d[2][i]&&d[2][i]<d[1][i]))
        {
            top1[count][A_save[count]]=i;
            A_save[count]++;
        }
        else if((d[1][i]<d[0][i]&&d[0][i]<d[2][i])||(d[1][i]<d[2][i]&&d[2][i]<d[0][i]))
        {
           top2[count][B_save[count]]=i;
           B_save[count]++;
        }
        else
        {
            top3[count][C_save[count]]=i;
            C_save[count]++;
        }
    }
    printf("A类：");
    for(i=0;i<A_save[count];i++)
    {
        printf("%s  ",node[top1[count][i]].city);
    }
    printf("\n");
     printf("B类：");
     for(i=0;i<B_save[count];i++)
    {
        printf("%s  ",node[top2[count][i]].city);
    }
        printf("\n");
     printf("C类：");
     for(i=0;i<C_save[count];i++)
    {
        printf("%s  ",node[top3[count][i]].city);
    }
    printf("\n");
    return;

}
void Update()
{
    printf("\n");
    printf("更新簇点\n");
    int i;
    int j;
    double sum_A[3]={0};
    double sum_B[3]={0};
    double sum_C[3]={0};
    for(j=0;j<3;j++)//寻找A类节点新的簇点
    {
        for(i=0;i<A_save[count];i++)
      {
         sum_A[j]=sum_A[j]+Normal_data[top1[count][i]][j];
      }
       A[count+1][j]=sum_A[j]/(A_save[count]-1);
    }
    printf("A点：(%.2lf,%.2lf,%.2lf)\n",A[count+1][0],A[count+1][1],A[count+1][2]);
     for(j=0;j<3;j++)//寻找B类节点新的簇点
    {
        for(i=0;i<B_save[count];i++)
      {
         sum_B[j]=sum_B[j]+Normal_data[top2[count][i]][j];
      }
       B[count+1][j]=sum_B[j]/(B_save[count]-1);
    }
    printf("B点：(%lf,%lf,%lf)\n",B[count+1][0],B[count+1][1],B[count+1][2]);
     for(j=0;j<3;j++)//寻找C类节点新的簇点
    {
        for(i=0;i<C_save[count];i++)
      {
         sum_C[j]=sum_C[j]+Normal_data[top3[count][i]][j];
      }
       C[count+1][j]=sum_C[j]/(C_save[count]-1);
    }
    printf("C点：(%lf,%lf,%lf)\n",C[count+1][0],C[count+1][1],C[count+1][2]);
    count++;
}
int Judge_Success()
{
    printf("进入判断\n");
    int i;
    if(A_save[count]==A_save[count-1]&&B_save[count]==B_save[count-1])
    {
        for(i=0;i<A_save[count];i++)
        {
            if(top1[count][i]!=top1[count-1][i]||top2[count][i]!=top2[count-1][i])
            {
                return 1;
            }
        }
      printf("恭喜你！前后两次分类一致，分类成功！\n");
      return 0;
    }
    else
    {
        return 1;
    }
}
int main()
{
    int text=0;
    Openfp();//打开文件存储信息
    printf("总共有%d个国家\n",City_All);
    printf("\n");
    Normalize();//规格化数据
    Display_Normal();//显示规格化后的数据
    for(text=0;text<2;text++)
    {
        printf("\n");
        printf("第%d次进行K-means\n",text+1);
        K_means();
        printf("一共进行了%d次迭代\n",count+1);
        count=0;
        judge=1;
    }
    printf("Hello world!\n");
    return 0;
}
