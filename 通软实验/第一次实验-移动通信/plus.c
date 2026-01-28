/**************************************************************************
  * @brief           	: 移动通信-信号强度计算 
  * @author        		: 雷宇航 
  * @copyright    		: 归作者所有 
  * @version       		: Version 1.0
  * @note            	: None
  * @history        	: None
***************************************************************************/
                        

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define M 100                                    
#define EPS 1e-20
 
int i,j,k,g,h,t,s,x;                                                                                         
int a,b;                                           	//存储小区信号所需的下标 
int NumData,NumPdata;                              	//小区每路信号数目，PSS每路信号数目 
int CellNum,PssNum;									//小区数目，PSS数目 
char filename[M];                                  	//创建文件名存储数组 
double sum;                                			//信号强度求和 
double temp;                                       	//用于冒泡排序
FILE *fp;                                          	//创建文件指针 


/**************************************************************************
  * @brief              	: 自动计算txt文件数据长度，以最大长度开辟空间，本实验假设每个数据长度相差不大 
  * @param[in]     			: Num所需打开文件个数；flag标志为0打开PSS文件，反之打开data文件
  * @param[out]   			: None 
  * @return            		: 返回所需开辟空间大小 
  * @others           		: 本实验假设每个数据长度相差不大 
***************************************************************************/
int AutoCntLen(int Num,int flag)
{
	int *len=(int*)calloc(Num,sizeof(int));
	int c;
	int cnt;
	for(cnt=0;cnt<Num;cnt++)
	{
		g=cnt+20;
		if (flag==0)
		{
			sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\PSS%d.txt",cnt);
		}
		else
		{
			sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\data%d.txt",g);
		}
		
   		if((fp=fopen(filename,"rt"))==NULL)
    	{
        	printf("Fail to open file!");
        	exit(0);
    	}
		while((c = fgetc(fp)) != EOF)	//C 库函数 int fgetc(FILE *stream) 从指定的流 stream 获取下一个字符（一个无符号字符），并把位置标识符往前移动。
    	{
        	if(c == '\n')				//碰到换行符，则行数+1
        	len[cnt]++;
    	}
    	len[cnt]=len[cnt]/2;
    	if(len[cnt]>=len[0])
    	{
    		len[0]=len[cnt];			//确认最大数据长度 
		}
		fclose(fp);
	}
	c=len[0];
	free(len);
    len=NULL;	
    return c;
}

/**************************************************************************
  * @brief              	: 二维数组内存动态分配 
  * @param[in]     			: rows二维数组行数；cols二维数组列数 
  * @param[out]   			: None 
  * @return            		: 二维数组地址 
  * @others           		: None
***************************************************************************/
double ** AllocateandInit(int rows,int cols)
{
	double** array = (double**)calloc(rows,sizeof(double*));			//分配行指针数组的内存 
    if (array == NULL) 
	{
        printf("Memory allocation failed.\n");
        exit(1);
    }
    *array = (double*)calloc(rows * cols, sizeof(double));						//直接开辟一块连续空间 
    for (i = 1; i < rows; i++) 
	{
        array[i] = array[0] + i * 2;
        if (array[i] == NULL) 
		{
            printf("Memory allocation failed.\n");
            exit(1);
        }
	}
//    for (i = 0; i < rows; i++) //分配列的内存并初始化为零,可能造成内存分配不连续 
//	{
//        array[i] = (double*)calloc(cols,sizeof(double));
//        if (array[i] == NULL) 
//		{
//            printf("Memory allocation failed.\n");
//            exit(1);
//        }
//
//    }
    return array;
}

/**************************************************************************
  * @brief              	: 二维数组内存释放
  * @param[in]     			: array指针数组首地址；rows二维数组行数 
  * @param[out]   			: None 
  * @return            		: None 
  * @others           		: None
***************************************************************************/
void FreeMemory(double ** array, int rows) 
{
    for (i = 0; i < rows; i++) 
	{
        free(array[i]); // 释放每行内存
    }
    free(*array);
    *array=NULL;
    free(array); // 释放行指针数组内存
    array=NULL;
}

/**************************************************************************
  * @brief              	: 读取自同步信号 
  * @param[in]     			: Pss_I为PSS的I路信号存储首地址；Pss_Q为PSS的Q路信号存储首地址；
  							  PssNum为PSS文件数目；NumPdata为PSS数据长度 
  * @param[out]   			: None 
  * @return            		: None 
  * @others           		: None
***************************************************************************/
void ReadPssData(double **Pss_I,double **Pss_Q,int PssNum,int NumPdata)
{
	printf("读取PSS数据\n");
	for(s=0;s<PssNum;s++)
	{
		printf("正在读取pss%d的数据\n",s);
		sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\PSS%d.txt",s);
   		if((fp=fopen(filename,"rt"))==NULL)
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

/**************************************************************************
  * @brief              	: 读取小区信号
  * @param[in]     			: I为小区的I路信号存储首地址；Q为小区的Q路信号存储首地址； 
  							  CellNum为小区文件数目；PssNum为PSS文件数目； 
							  NumPdata为PSS数据长度；NumData为小区信号强度； 
							  p为小区信号强度；z_I存储每次滑动相关的I路信号； 
							  z_Q存储每次滑动相关的Q路信号； 
							  Pss_I存储PSS的I路信号；Pss_Q存储PSS的Q路信号； 
							  z存储小区与PSS的滑动相关；max存储每个小区与每个PSS相关后的最大相关 ；
							  sum2aveR存储每个小区与每个PSS相关后的平均相关； 
							  relevant存储每个小区的最大相关 ；
							  Pss_Max存储与每个小区最大相关的下标； 
  * @param[out]   			: None 
  * @return            		: None 
  * @others           		: None
***************************************************************************/
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
        	sum+=sqrt(I[a]*I[a]+Q[b]*Q[b]);
    	}
    	p[i]=sum/(1.0*NumData);                                      							//信号总强度
    	printf("data%d小区信号强度是%lf\n",g,p[i]);
    	printf("计算data%d的相关\n",g);
    	for(s=0;s<PssNum;s++)                                 					//计算滑动相关
    	{
        	z_I[i][s]=0;
        	z_Q[i][s]=0;
        	for(k=0;k<NumData-NumPdata;k++)
        	{
            	for(t=0,x=k;t<NumPdata;t++)
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

/**************************************************************************
  * @brief              	: 信号强度排序
  * @param[in]     			: Sa指向用于小区信号强度排序数组首地址 ；Sb指向小区的信号强度数组首地址；
  							  CellNum为小区数目				   
  * @param[out]   			: None 
  * @return            		: None 
  * @others           		: None
***************************************************************************/
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

/**************************************************************************
  * @brief              	: 打印信号强度排序 
  * @param[in]     			: PSa指向用于小区信号强度排序数组首地址 ；Psb指向小区的信号强度数组首地址；
  							  PSc指向存储小区区号数组首地址；CellNum为小区数目；				   
  * @param[out]   			: None 
  * @return            		: None 
  * @others           		: None
***************************************************************************/
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

/**************************************************************************
  * @brief              	: 主函数
  * @param[in]     			: None				   
  * @param[out]   			: None 
  * @return            		: None 
  * @others           		: None
***************************************************************************/
void main()
{
	//输入文本长度 
    printf("How much cell and PSS there?  \n");
    scanf("%d",&CellNum);
    scanf("%d",&PssNum);
    
    //计算开辟空间数量 
	NumData=AutoCntLen(CellNum,1);
	NumPdata=AutoCntLen(PssNum,0);
	
	//内存开辟 
    double* p=(double*)calloc(CellNum,sizeof(double));  				//小区的信号强度 
    double* sort=(double*)calloc(CellNum,sizeof(double));				//用于小区信号强度排序 
    double* relevant=(double*)calloc(CellNum,sizeof(double));			//存储每个小区的最大相关 
    int* Pss_Max=(int*)calloc(CellNum,sizeof(int));						//存储与每个小区最大相关的下标 
    int* top=(int*)calloc(CellNum,sizeof(int));							//用于信号排序 
	double* I=(double*)calloc(NumData,sizeof(double));					//存储小区I路信号 
	double* Q=(double*)calloc(NumData,sizeof(double));					//存储小区Q路信号 
	double* z=(double*)calloc(NumData-NumPdata,sizeof(double)); 		//存储小区与PSS的滑动相关 
	double **Pss_I=AllocateandInit(PssNum,NumPdata);					//存储PSS的I路信号 
	double **Pss_Q=AllocateandInit(PssNum,NumPdata);					//存储PSS的Q路信号 
	double **z_I=AllocateandInit(CellNum,PssNum);						//存储每次滑动相关的I路信号 
	double **z_Q=AllocateandInit(CellNum,PssNum);						//存储每次滑动相关的Q路信号 
	double **max=AllocateandInit(CellNum,PssNum);						//存储每个小区与每个PSS相关后的最大相关 
	double **sum2aveR=AllocateandInit(CellNum,PssNum);					//存储每个小区与每个PSS相关后的平均相关 
	
	//子函数调用 
	ReadPssData(Pss_I,Pss_Q,PssNum,NumPdata);		
	ReadData(I,Q,CellNum,PssNum,NumData,NumPdata,p,z_I,z_Q,Pss_I,Pss_Q,z,max,sum2aveR,relevant,Pss_Max);
	Sort(sort,p,CellNum); 
    PrintSort(sort,p,top,CellNum);
    
    //内存释放 
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
    //注意：指针一定要赋值为NULL，因为释放内存后，指针还有指向那块空间的地址，赋值为空防止二次访问报错 
    p=NULL;
	sort=NULL;
	relevant=NULL;
	Pss_Max=NULL;
	top=NULL;
	I=NULL;
	Q=NULL;
	z=NULL;
	 
}
