#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define M 100
#define EPS 1e-7
int i,j,k,g,h,t,s;                                                                                         
int a,b;                                           
int NumData,NumPdata;                              	//小区每路信号数目，PSS每路信号数目 
int CellNum,PssNum;									//小区数目，PSS数目 
char filename[M];                                  	//创建data文件名存储数组 
char pssname[M];                                   	//创建pss文件名存储数组 
double sum;                                
double powand;                                     	//平方和
double temp;                                       	//用于冒泡排序
FILE *fp;                                          	//创建文件指针 

//二维数组内存动态分配 
double ** AllocateandInit(int rows,int cols)
{
	double** array = (double**)malloc(rows * sizeof(double*));//分配行指针数组的内存 
    if (array == NULL) 
	{
        printf("Memory allocation failed.\n");
        exit(1);
    }
    for (i = 0; i < rows; i++) //分配列的内存并初始化为零 
	{
        array[i] = (double*)calloc(cols,sizeof(double));
        if (array[i] == NULL) 
		{
            printf("Memory allocation failed.\n");
            exit(1);
        }

    }
    return array;
}

void FreeMemory(double ** array, int rows) 
{
    for (i = 0; i < rows; i++) 
	{
        free(array[i]); // 释放每行内存
    }
    free(array); // 释放行指针数组内存
}
//读取自同步信号 
void ReadPssData(double **Pss_I,double **Pss_Q,int PssNum,int NumPdata)
{
	printf("读取PSS数据\n");
	
	for(s=0;s<PssNum;s++)
	{
		printf("正在读取pss%d的数据\n",s);
		sprintf(pssname,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\PSS%d.txt",s);
   		if((fp=fopen(pssname,"rt"))==NULL)
    	{
        	printf("Fail to open file!");
        	exit(0);
    	}
    	for(t=0,j=0,h=0;t<2*NumPdata;t++)
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
	fclose(fp);                                      							//关闭文件
		
	}
	printf("PSS数据读取完成\n");
}
//读取小区信号 
void ReadData(double *I,double *Q,int CellNum,int PssNum,int NumData,int NumPdata,double *p,double **z_I,double **z_Q,double** Pss_I,double** Pss_Q,double *z,double **max,double **sum2aveR,double *relevant,int *Pss_Max)
{
	double *data=(double *)calloc(2*NumData,sizeof(double));
	for(i=0;i<CellNum;i++)
	{
		g=i+20;
		sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\data%d.txt",g);
    	if ( (fp = fopen(filename, "rt")) == NULL ) 
		{
       		puts("Fail to open file!");											//判断文件是否打开失败
        	exit(0);                                     					
    	}
    	sum=0;
    	memset(data, 0.0, sizeof(double)*(2*NumData));
    	printf("\n");
    	printf("正在读取data%d小区...\n",g);
    	for(t=0;t<2*NumData;t++)                             					//读取小区数据
    	{
        	fscanf(fp,"%lf",&data[t]);
    	}

    	printf("计算data%d小区信号强度...\n",g);
    	for(j=0,h=1,a=0,b=0;j<=2*NumData-1;j+=2,h+=2,a++,b++)  					//计算信号总强度
    	{
        	I[a]=data[j];
        	Q[b]=data[h];
        	powand=sqrt(pow(I[a],2)+pow(Q[b],2));
        	sum=sum+powand;
    	}
    	p[i]=sum/(1.0*NumData);                                      			//信号平均强度
    	printf("data%d小区信号强度是%lf\n",g,p[i]);
    	printf("计算data%d的相关\n",g);
    	for(s=0;s<PssNum;s++)                                 					//计算滑动相关
    	{
        	z_I[i][s]=0;
        	z_Q[i][s]=0;
        	for(k=0;k<NumData-NumPdata;k++)
        	{
            	for(t=0;t<NumPdata;t++)
            	{
                	z_I[i][s]=z_I[i][s]+Pss_I[s][t]*I[t+k]-Pss_Q[s][t]*Q[t+k];	//结果的实部
                	z_Q[i][s]=z_Q[i][s]+Pss_I[s][t]*Q[t+k]+Pss_Q[s][t]*I[t+k];	//结果的虚部
            	}
            	z[k]=sqrt(pow(z_I[i][s],2)+pow(z_Q[i][s],2));
            	sum2aveR[i][s]+=z[k];

        	}
            for(k=0;k<NumData-NumPdata;k++)      								//找出每一个PSS里面最大的相关
            {
                if(z[k]>max[i][s])
                {
                    max[i][s]=z[k];
                }
            }
            sum2aveR[i][s]=sum2aveR[i][s]/((NumData-NumPdata)*1.0);
            printf("data%d小区与PSS%d的相关=%lf,以及平均相关=%lf\n",g,s,max[i][s],sum2aveR[i][s]);
        }
        for(s=0;s<PssNum;s++)                   								//找出与小区相关最大的PSS
        {
            if(max[i][s]>relevant[i])
            {
                relevant[i]=max[i][s];
                Pss_Max[i]=s;
            }
        }
        printf("data%d小区与PSS%d相关最大=%lf\n",g,Pss_Max[i],relevant[i]);
        fclose(fp);																//关闭文件                   
	}
}
//信号强度排序 
void Sort(double *Sa,double *Sb,int CellNum)
{
	for(i=0;i<CellNum;i++)                      								//存储信号强度用于排序
    {
        *(Sa+i)=*(Sb+i);
    }
     for(i=0;i<CellNum-1;i++)                     								//冒泡排序
    {
        for(j=0;j<CellNum-1-i;j++)
        {
            if(*(Sa+j)<*(Sa+j+1))
            {
                temp=*(Sa+j);
                *(Sa+j)=*(Sa+j+1);
                *(Sa+j+1)=temp;
            }
        }
    }
	printf("\n");
	
	
}
void PrintSort(double *PSa,double *PSb,int *PSc,int CellNum)
{
	printf("12个小区信号强度排名从大到小如下（包含21和27）：\n");
    for(i=0;i<CellNum;i++)//对小区进行排序
    {
        for(j=0;j<CellNum;j++)
        {
            if(fabs(*(PSa+i)-*(PSb+j))<EPS)
                break;
        }
        *(PSc+i)=j+20;
        printf("data%d小区：%lf\n",*(PSc+i),*(PSa+i));
    }
	
	
}
int main()
{
    printf("打开文件...\n");
    printf("How much cell and PSS there?  \n");
    scanf("%d",&CellNum);
    scanf("%d",&PssNum);
    printf("How much I or Q there?\n");
	scanf("%d",&NumData);
	printf("How much Pss_I or Pss_Q there?\n");			 
	scanf("%d",&NumPdata);
    double* p=(double*)calloc(CellNum,sizeof(double));  				//小区的信号强度 
    double* sort=(double*)calloc(CellNum,sizeof(double));	//用于小区信号强度排序 
    double* relevant=(double*)calloc(CellNum,sizeof(double));	//存储每个小区的最大相关 
    int* Pss_Max=(int*)calloc(CellNum,sizeof(int));			//存储与每个小区最大相关的下标 
    int* top=(int*)calloc(CellNum,sizeof(int));				//用于信号排序 
	double* I=(double*)calloc(NumData,sizeof(double));	//存储小区I路信号 
	double* Q=(double*)calloc(NumData,sizeof(double));	//存储小区Q路信号 
	double* z=(double*)calloc(NumData-NumPdata,sizeof(double)); 					//存储小区与PSS的滑动相关 
	double **Pss_I=AllocateandInit(PssNum,NumPdata);
	double **Pss_Q=AllocateandInit(PssNum,NumPdata);
	double **z_I=AllocateandInit(CellNum,PssNum);
	double **z_Q=AllocateandInit(CellNum,PssNum);
	double **max=AllocateandInit(CellNum,PssNum);	//存储每个小区与每个PSS相关后的最大相关 
	double **sum2aveR=AllocateandInit(CellNum,PssNum);					//存储每个小区与每个PSS相关后的平均相关 
	ReadPssData(Pss_I,Pss_Q,PssNum,NumPdata);		
	ReadData(I,Q,CellNum,PssNum,NumData,NumPdata,p,z_I,z_Q,Pss_I,Pss_Q,z,max,sum2aveR,relevant,Pss_Max);
	Sort(sort,p,CellNum); 
    PrintSort(sort,p,top,CellNum);
    FreeMemory(Pss_I,PssNum);
    FreeMemory(Pss_Q,PssNum);
    FreeMemory(z_I,CellNum);
    FreeMemory(z_Q,CellNum);
    FreeMemory(max,CellNum);
    FreeMemory(sum2aveR,CellNum);
    free(p);
    free(sort);
    free(relevant);
    free(Pss_Max);
    free(top);
    free(I);
    free(Q);
    free(z);
    return 0; 
}
