#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define M 20
#define EPS 1e-7


int i,j,k,h,s,t;                                            
int a,b;                                           //实部、虚部index
double temp;                                       //用于冒泡排序
double sum;                                        
int top[12];                                       //用于信号强度排序 
char filename[M];                                  //创建文件名存储数组 
double I[15000];                                   //实部
double Q[15000];                                   //虚部
double n=15000;
double p[12];                                      //12个小区的信号强度
double sort[12];                                   //用于排序的12个小区
double Pss_I[3][2048];                             //确定信号的I路数据
double Pss_Q[3][2048];                             //确定信号的Q路数据
double z_I[12][3];                                 //12个小区与3个pss的相关,I路
double z_Q[12][3];                                 //12个小区与3个pss的相关,Q路
double z[12952];                                   //12个小区与3个pss的相关
double max[12][3]={0};                             //存储每个小区与每个PSS的相关
double sum2aveR[12][3];                            //存储每个小区与每个PSS的平均相关 
double relevant[12]={0};                           //存储每个小区的最大相关
int Pss_Max[12];								   //存储最大相关的下标 
FILE *fp;                                          //创建文件指针 

void ReadPssData()
{
	printf("读取PSS数据\n");
	for(s=0;s<3;s++)
	{
		printf("正在读取pss%d的数据\n",s);
		sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\PSS%d.txt",s);
   		if((fp=fopen(filename,"rt"))==NULL)
   		{
    	
        	printf("Fail to open file!");
        	exit(0);
    	}
    	for(t=0,j=0,h=0;t<4096;t++)
        {
            if(t%2==0)
            {
                fscanf(fp,"%lf",&Pss_I[s][j]);
                j++;
            }
            else
            {
                fscanf(fp,"%lf",&Pss_Q[s][h]);
                h++;
            }
        }
	fclose(fp);                                      //关闭文件
	}
	printf("PSS数据读取完成\n");
}

void ReadData()
{
	for(i=0;i<12;i++)
	{
		sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\data%d.txt",i+20);
    	if ( (fp = fopen(filename, "rt")) == NULL ) 
		{
       		puts("Fail to open file!");
        	exit(0);                                     //判断文件是否打开失败
    	}
    	sum=0;
    	double data[30000]={0};
    	printf("\n");
    	printf("正在读取data%d小区...\n",i+20);
    	for(t=0;t<30000;t++)                             //读取小区数据
    	{
        	fscanf(fp,"%lf",&data[t]);
    	}

    	printf("计算data%d小区信号强度...\n",i);
    	for(j=0,h=1,a=0,b=0;j<=29999;j+=2,h+=2,a++,b++)  //计算信号总强度
    	{
        	I[a]=data[j];
        	Q[b]=data[h];
        	sum+=sqrt(pow(I[a],2)+pow(Q[b],2));
    	}
    	p[i]=sum/n;                                      //信号平均强度
    	printf("data%d小区信号强度是%lf\n:",i+20,p[i]);
    	printf("计算data%d的相关\n",i+20);
    	for(s=0;s<3;s++)                                 //计算滑动相关
    	{
        	z_I[i][s]=0;
        	z_Q[i][s]=0;
        	for(k=0;k<15000-2048;k++)
        	{
	            for(t=0;t<2048;t++)
	            {
	                z_I[i][s]=z_I[i][s]+Pss_I[s][t]*I[t+k]-Pss_Q[s][t]*Q[t+k];//结果的实部
	                z_Q[i][s]=z_Q[i][s]+Pss_I[s][t]*Q[t+k]+Pss_Q[s][t]*I[t+k];//结果的虚部
	            }
	            z[k]=sqrt(pow(z_I[i][s],2)+pow(z_Q[i][s],2));
	            sum2aveR[i][s]+=z[k];

        	}
            for(k=0;k<15000-2048;k++)      //找出每一个PSS里面最大的相关
            {
                if(z[k]-max[i][s]>EPS)
                {
                    max[i][s]=z[k];
                }
            }
            sum2aveR[i][s]=sum2aveR[i][s]/12952.0;
            printf("data%d小区与PSS%d的相关=%lf,以及平均相关=%lf\n",i+20,s,max[i][s],sum2aveR[i][s]);
        }
        for(s=0;s<3;s++)                   //找出与小区相关最大的PSS
        {
            if(max[i][s]-relevant[i]>EPS)
            {
                relevant[i]=max[i][s];
                Pss_Max[i]=s;
            }
        }
        printf("data%d小区与PSS%d相关最大=%lf\n",i+20,Pss_Max[i],relevant[i]);
        fclose(fp);                        //关闭文件
	}
}
void Sort(double *a,double *b)
{
	for(i=0;i<12;i++)                      //存储信号强度用于排序
    {
        *(a+i)=*(b+i);
    }
     for(i=0;i<11;i++)                     //冒泡排序
    {
        for(j=0;j<11-i;j++)
        {
            if(*(a+j)<*(a+j+1))
            {
                temp=*(a+j);
                *(a+j)=*(a+j+1);
                *(a+j+1)=temp;
            }
        }
    }
	printf("\n");
	
	
}

void PrintSort(double *a,double *b,int *c)
{
	printf("12个小区信号强度排名从大到小如下（包含21和27）：\n");
    for(i=0;i<12;i++)//对小区进行排序
    {
        for(j=0;j<12;j++)
        {
            if(fabs(*(a+i)-*(b+j))<EPS)
                break;
        }
        *(c+i)=j+20;
        printf("data%d小区：%lf\n",*(c+i),*(a+i));
    }
	
	
}

int main()
{
	ReadPssData(); 		
	ReadData();
	Sort(sort,p); 
    PrintSort(sort,p,top);
    return 0; 
}
