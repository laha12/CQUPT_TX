#include <stdio.h>
#include <stdlib.h>
#include<math.h>
int main()
{
    int i;//小区个数
    int t;//读取数据个数
    int j;//实部数据保存
    int h;//虚部数据保存
    int a,b;//实部、虚部
    int x;
    int s; //PSS个数 
    int k;
    int stand=0;//记录满足信号强度的小区个数
    int top[12];
    char filename[M];//创建文件名存储数组 
    double n=15000;
    double I[15000];//I路，实部
    double Q[15000];//虚部
    double sum;
    double min=1000;
    double p[12];//12个小区的信号强度
    double sort[12];//用于排序的12个小区
    double powand;//平方和
    double temp;//用于冒泡排序
    double Pss_I[3][2048];//确定信号的I路数据
    double Pss_Q[3][2048];//确定信号的Q路数据
    double Pss_min=3000000;
    double z_I[12][3];//12个小区与3个pss的相关,I路
    double z_Q[12][3];//12个小区与3个pss的相关,Q路
    double z[12952];//12个小区与3个pss的相关
    double max[12][3]={0};//存储每个小区与每个PSS的相关
    double relevant[12]={0};//存储每个小区的最大相关
    int Pss_Max[12];//存储相关对应的小区ID；
    printf("设置信号强度门限:min=%lf\n",min);//设置强度门限
    printf("设置相关门限Pss_min=%lf\n",Pss_min);//设置相关门限
    printf("打开文件...\n");
    printf("读取PSS数据\n");
    for(s=0;s<3:s++)
	{
		printf("读取pss%d的数据\n",s);
		sprintf(pssname,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\PSS%d.txt",s);
   		if((fp=fopen(pssname,"rt"))==NULL)
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
			
	}
	printf("PSS数据读取完成\n");
    for(i=20;i<32;i++)
	{
		sprintf(filename,"C:\\Users\\86185\\Desktop\\通软实验\\180308204701120_第一次实验数据\\第一次实验数据\\data%d.txt",i);
    	if ( (fp = fopen(filename, "rt")) == NULL ) 
		{
        	puts("Fail to open file!");
        	exit(0);//判断文件是否打开失败
    	}
    	sum=0;
        double data[30000]={0};
        printf("\n");
        printf("读取data%d小区...\n",i);
        for(t=0;t<30000;t++)//读取小区数据
        {
            fscanf(fp,"%lf",&data[t]);
        }

        printf("计算data%d小区信号强度...\n",i);
         for(j=0,h=1,a=0,b=0;j<=29999;j+=2,h+=2,a++,b++)//计算信号强度
        {
            I[a]=data[j];
            Q[b]=data[h];
            powand=sqrt(pow(I[a],2)+pow(Q[b],2));
            sum=sum+powand;
        }
        p[i]=sum/n;//信号强度
        printf("data%d小区信号强度是%lf\n:",i,p[i]);
        printf("计算data%d的相关\n",i);
        for(s=0;s<3;s++)//计算相关
        {
            z_I[i][s]=0;
            z_Q[i][s]=0;
            for(k=0;k<15000-2048;k++)
            {
                for(t=0,x=k;t<2048;t++)
                {
                    z_I[i][s]=z_I[i][s]+Pss_I[s][t]*I[t+k]-Pss_Q[s][t]*Q[t+k];//结果的实部
                    z_Q[i][s]=z_Q[i][s]+Pss_I[s][t]*Q[t+k]+Pss_Q[s][t]*I[t+k];//结果的虚部
                }
                z[k]=sqrt(pow(z_I[i][s],2)+pow(z_Q[i][s],2));

            }
            for(k=0;k<15000-2048;k++)//找出每一个PSS里面最大的相关
            {
                if(z[k]>max[i][s])
                {
                    max[i][s]=z[k];
                }
            }
            printf("data%d小区与PSS%d的相关=%lf\n",i,s,max[i][s]);
        }
        for(s=0;s<3;s++)//找出与小区相关最大的PSS
            {
                if(max[i][s]>relevant[i])
                {
                    relevant[i]=max[i][s];
                    Pss_Max[i]=s;
                }
            }
            printf("data%d小区与PSS%d相关最大=%lf\n",i,Pss_Max[i],relevant[i]);
        fclose(fp);//关闭文件
		
		
	} 
    FILE *fp1=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data12.txt","r");//打开文件
    FILE *fp2=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data13.txt","r");//打开文件
    FILE *fp3=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data14.txt","r");//打开文件
    FILE *fp4=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data15.txt","r");//打开文件
    FILE *fp5=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data15.txt","r");//打开文件
    FILE *fp6=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data16.txt","r");//打开文件
    FILE *fp7=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data17.txt","r");//打开文件
    FILE *fp8=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data18.txt","r");//打开文件
    FILE *fp9=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data19.txt","r");//打开文件
    FILE *fp10=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data20.txt","r");//打开文件
    FILE *fp11=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data21.txt","r");//打开文件
    FILE *fp12=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\data22.txt","r");//打开文件
    FILE *fp_Pss0=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\PSS0.txt","r");//打开文件
    FILE *fp_Pss1=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\PSS1.txt","r");//打开文件
    FILE *fp_Pss2=fopen("D:\\A网课\\通软\\实验\\第一次实验\\第一次实验数据\\PSS2.txt","r");//打开文件
    FILE *fpn[12]={fp1,fp2,fp3,fp4,fp5,fp6,fp7,fp8,fp9,fp10,fp11,fp12};//利用指针数组保存文件
    FILE *fp_Pss[3]={fp_Pss0,fp_Pss1,fp_Pss2};
    printf("读取PSS数据\n");
    for(s=0;s<3;s++)//读取PSS数据
    {
        printf("读取pss%d的数据\n",s);
        for(t=0,j=0,h=0;t<4096;t++)
        {
            if(t%2==0)
            {
                fscanf(fp_Pss[s],"%lf",&Pss_I[s][j]);
                j++;
            }
            else
            {
                 fscanf(fp_Pss[s],"%lf",&Pss_Q[s][h]);
                 h++;
            }
        }
    }
    printf("PSS数据读取完成\n");
    for(i=0,x=0;i<12;i++,x++)
    {
        sum=0;
        double data[30000]={0};
        printf("\n");
        printf("读取data%d小区...\n",i);
        for(t=0;t<30000;t++)//读取小区数据
        {
            fscanf(fpn[i],"%lf",&data[t]);
        }

        printf("计算data%d小区信号强度...\n",i);
         for(j=0,h=1,a=0,b=0;j<=29999;j+=2,h+=2,a++,b++)//计算信号强度
        {
            I[a]=data[j];
            Q[b]=data[h];
            powand=sqrt(pow(I[a],2)+pow(Q[b],2));
            sum=sum+powand;
        }
        p[i]=sum/n;//信号强度
        printf("data%d小区信号强度是:",i);
        printf("%lf\n",p[i]);
        printf("计算data%d的相关\n",i);
        for(s=0;s<3;s++)//计算相关
        {
            z_I[i][s]=0;
            z_Q[i][s]=0;
            for(k=0;k<15000-2048;k++)
            {
                for(t=0,x=k;t<2048;t++)
                {
                    z_I[i][s]=z_I[i][s]+Pss_I[s][t]*I[t+k]-Pss_Q[s][t]*Q[t+k];//结果的实部
                    z_Q[i][s]=z_Q[i][s]+Pss_I[s][t]*Q[t+k]+Pss_Q[s][t]*I[t+k];//结果的虚部
                }
                z[k]=sqrt(pow(z_I[i][s],2)+pow(z_Q[i][s],2));

            }
            for(k=0;k<15000-2048;k++)//找出每一个PSS里面最大的相关
            {
                if(z[k]>max[i][s])
                {
                    max[i][s]=z[k];
                }
            }
            printf("data%d小区与PSS%d的相关=%lf\n",i,s,max[i][s]);
        }
         for(s=0;s<3;s++)//找出与小区相关最大的PSS
            {
                if(max[i][s]>relevant[i])
                {
                    relevant[i]=max[i][s];
                    Pss_Max[i]=s;
                }
            }
            printf("data%d小区与PSS%d相关最大=%lf\n",i,Pss_Max[i],relevant[i]);
        fclose(fp);//关闭文件
    }
    p[12]=sort[12];
    for(i=0;i<12;i++)//存储信号强度用于排序
    {
        sort[i]=p[i];
    }
     for(i=0;i<11;i++)                          //冒泡排序
    {
        for(j=0;j<11-i;j++)
        {
            if(sort[j]<sort[j+1])
            {
                temp=sort[j];
                sort[j]=sort[j+1];
                sort[j+1]=temp;
            }
        }
    }
    printf("\n");
    printf("12个小区信号强度排名从大到小如下：\n");
     for(i=0;i<12;i++)//对小区进行排序
    {
        for(j=0;j<12;j++)
        {
            if(sort[i]==p[j])
                break;
        }
        top[i]=j;
        printf("data%d小区：%lf\n",top[i],sort[i]);
    }
    printf("\n");
    printf("大于强度门限的小区从大到小排名为：\n");
    for(i=0;i<12;i++)//找出大于信号强度门限的小区
    {
        if(sort[i]>min)
        {
            printf("data%d小区：%lf\n",top[i],sort[i]);
            stand=stand+1;
        }
    }
for(i=0;i<stand;i++)
{
    printf("\n");
    if(sort[i]<min&&relevant[i]>Pss_min)
        printf("data%d信号强度不符合要求，寻找下一个小区\n",top[i]);
    else if(relevant[i]<Pss_min&&sort[i]>min)
        printf("data%d信号相关不符合要求，寻找下一个小区\n",top[i]);
    else if(sort[i]<min&&relevant[i]>Pss_min)
        printf("data%d信号强度和信号相关都不符合要求，寻找下一个小区\n",top[i]);
    else
    {
        printf("data%d信号强度和信号相关都符合要求,流程结束\n",top[i]);
        break;
    }

}
}
