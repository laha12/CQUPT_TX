#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
BITMAPFILEHEADER fileHead;
BITMAPINFOHEADER infoHead;
void bmp_information(BITMAPFILEHEADER fileHead,BITMAPINFOHEADER infoHead)//打印图片信息
{
    unsigned long size, offBits;
    long width, height;
    unsigned short bitCount, planes;
    size = fileHead.bfSize;
    offBits = fileHead.bfOffBits;
    width = infoHead.biWidth;
    height = infoHead.biHeight;
    bitCount = infoHead.biBitCount;
    planes = infoHead.biPlanes;
    printf("文件大小（bfsize）：%ukb\n",size/1024);
    printf("偏移大小（bfOffBits）：%u\n",offBits);
    printf("图像宽度大小（biWidth）：%ld\n",width);
    printf("图像高度大小（biHeight)：%ld\n",height);
    printf("位深大小（biBitCount）：%u\n",bitCount);
    printf("调色板大小（biPlanes）：%u\n",planes);
}
void bmp1()
{
    int i,j,k;
    FILE *fp = fopen("D:\\A网课\\通软\\实验\\第六次实验\\view_256.bmp", "rb");
    if (fp == NULL)
    {
        printf("文件打开失败\n");
        return 0;
    }
    printf("\n逆时针旋转90度请输1，顺时针旋转90度请输2\n");
    scanf("%d",&k);
    fread(&fileHead, sizeof(BITMAPFILEHEADER), 1, fp);//读取文件头
    fread(&infoHead, sizeof(BITMAPINFOHEADER), 1, fp);//读取信息头
    printf("旋转前：\n\n");
    bmp_information(fileHead,infoHead);//打印原有图像的所需信息
    int width = infoHead.biWidth;//宽度
    int height = infoHead.biHeight;//高度
    int BitCount = infoHead.biBitCount;//图像位数
    int lineByte = (width*BitCount / 8 + 3) / 4 * 4;//行扫描字节
    RGBQUAD *pColorTable;//颜色对照表
    pColorTable = (RGBQUAD *)malloc(sizeof(RGBQUAD)*256);
    fread(pColorTable, sizeof(RGBQUAD), 256, fp);//读取原有图像的颜色对照表
    unsigned char *pBmpBuf;//定义像素点
    pBmpBuf = (unsigned char *)malloc(sizeof(unsigned char)*lineByte*height);
    fread(pBmpBuf, lineByte*height, 1, fp);//读取原图像的像素
    fclose(fp);	    // 顺时针旋转90°
    unsigned char *newpBmpBuf;//定义新图像像素点
    int newlineByte = (height*BitCount / 8 + 3) / 4 * 4;//新图像行扫描字节
    newpBmpBuf = (unsigned char *)malloc(sizeof(unsigned char)*newlineByte*width);	    //初始化像素点
    for (i = 0; i < width; ++i)
    {
        for (j = 0; j < height; ++j)
        {
            unsigned char *p;
            p = (unsigned char *)(newpBmpBuf + newlineByte*i + j);
            (*p) = 255;
        }
    }	    //旋转后像素点与原图像的映射关系
    for (i = 0; i < width; ++i)
    {
        for (j = 0; j < height; ++j)
        {
            unsigned char *p,*newp;
            p = (unsigned char *)(pBmpBuf + lineByte*j + i);  // 原图像
            if(k==1)
            {
                newp = (unsigned char *)(newpBmpBuf + newlineByte*i+height-j-1);// 新图像
            }
            if(k==2)
            {
                newp = (unsigned char *)(newpBmpBuf + newlineByte*(width-1-i)+j);// 新图像
            }
            (*newp) = (*p);
        }
    }//创建旋转后的图像文件
    FILE *newfp = fopen("D:\\A网课\\通软\\实验\\第七次实验\\test1.bmp", "wb");
    if (newfp == NULL)
    {
        printf("文件创建失败\n");
        return 0;
    }
    BITMAPFILEHEADER newfileHead;//新图像文件头
    newfileHead = fileHead;
    BITMAPINFOHEADER newinfoHead;//新图像信息头
    newinfoHead = infoHead;
    newinfoHead.biHeight = width;//新图像高度
    newinfoHead.biSizeImage = newlineByte*width;//图像大小
    newinfoHead.biWidth = height;//宽度
    newfileHead.bfSize = newfileHead.bfOffBits + newinfoHead.biSizeImage;//文件大小
    fwrite(&newfileHead, sizeof(BITMAPFILEHEADER), 1, newfp);//写入文件头
    fwrite(&newinfoHead, sizeof(BITMAPINFOHEADER), 1, newfp);//写入信息头
    fwrite(pColorTable, sizeof(RGBQUAD), 256, newfp);//写入颜色对照表
    fwrite(newpBmpBuf, newlineByte*width, 1, newfp);//写入像素点
    fclose(newfp);//关闭文件
    printf("旋转后：\n\n");
    bmp_information(newfileHead,newinfoHead);//打印旋转后图像的一些信息
    system("test1.bmp");
    return 0;
}
void bmp2(int z)
{

    FILE *fp;
    char bmp_head[54],bh[54];
    char ***bmp_data;
    int i,j,k,m,n,num=0;
    int ws,high,width,size,py;;//位深
    if(!(fp=fopen("D:\\A网课\\通软\\实验\\第七次实验\\view.bmp","rb")))
        printf("open file false!");
    fseek(fp,0,SEEK_END);
    i=(int)ftell(fp);
    fseek(fp,0,SEEK_SET);
    for(i=0; i<54; i++)
    {
        fread(bmp_head+i,1,1,fp);
    }
    ws=bmp_head[29]*256+bmp_head[28];//读取位深
    high=(((bmp_head[25]*256+bmp_head[24])*256+bmp_head[23])*256)+bmp_head[22];//读取高度
    width=(((bmp_head[21]*256+bmp_head[20])*256+bmp_head[19])*256)+bmp_head[18];//读取宽度
    size=bmp_head[2]+bmp_head[3]*256+bmp_head[4]*256*256+bmp_head[5]*256*256*256;//读取大小
    py=(((bmp_head[13]*256+bmp_head[12])*256+bmp_head[11])*256)+bmp_head[10];
    if(ws==24)
    {
        bmp_data=(char***)malloc(width*sizeof(char**));//宽
        for(i=0; i<width; i++)
        {
            bmp_data[i]=(char**)malloc(high*sizeof(char*));//高
            for(j=0; j<high; j++)
                bmp_data[i][j]=(char*)malloc(3*sizeof(char));//位深三字节
        }	        //
        memcpy(bh,bmp_head,54);
        for(i=0; i<high; i++)
        {
            for(j=0; j<width; j++)
            {
                fread(bmp_data[j][i],sizeof(char),3,fp);
            }
            fseek(fp,4-(width*3)%4,SEEK_CUR);
        }
        fclose(fp);	        //
        fp=fopen("D:\\A网课\\通软\\实验\\第七次实验\\test.bmp","wb");
        for(i=18; i<=21; i++)
            exchange(bh+i,bh+i+4);//图像的宽度和高度值交换
        fwrite(bh,54,1,fp);
        printf("\n逆时针旋转90度请输1，顺时针旋转90度请输2\n");
        scanf("%d",&k);
        if(k==1)
        {
            for(i=0; i<width; i++)
            {
                for(j=high-1; j>=0; j--)
                {
                    fwrite(bmp_data[i][j],3,1,fp);
                    num+=3;
                }
                fwrite("\0",1,4-(high*3)%4,fp);
                num+=4-(high*3)%4;
            }
        }
        if(k==2)
        {
            for(i=width-1; i>=0; i--)
            {
                for(j=0; j<high; j++)
                {
                    fwrite(bmp_data[i][j],3,1,fp);
                    num+=3;
                }
                fwrite("\0",1,4-(high*3)%4,fp);
                num+=4-(high*3)%4;
            }
        }
        fseek(fp,34,SEEK_SET);
        fprintf(fp,"%c%c%c%c",(char)(num%256),(char)(num/256%256),(char)(num/256/256%256),(char)(num/256/256/256));
        num+=54;
        fseek(fp,2,SEEK_SET);
        fprintf(fp,"%c%c%c%c",(char)(num%256),(char)(num/256%256),(char)(num/256/256%256),(char)(num/256/256/256));
        fclose(fp);
        printf("旋转之前文件信息：\n");
        printf("文件大小（bfsize）：%ukb\n",size);
        printf("偏移大小（bfOffBits）：54\n",py);
        printf("图像宽度大小（biWidth）：%ld\n",width);
        printf("图像高度大小（biHeight)：%ld\n",high);
        printf("位深大小（biBitCount）：%u\n",ws);
        printf("\n旋转之后文件信息：\n");
        printf("文件大小（bfsize）：%ukb\n",high*width*ws/(8*1024)+2);
        printf("偏移大小（bfOffBits）：54\n");
        printf("图像宽度大小（biWidth）：%ld\n",high);
        printf("图像高度大小（biHeight)：%ld\n",width);
        printf("位深大小（biBitCount）：%u\n",ws);
        system("test.bmp");
    }
}

void exchange(char *a,char *b)//交换函数，将高度，宽度等信息进行交换
{
    char n;
    n=*a;
    *a=*b;
    *b=n;
}
int main()
{
    int i,j,select;
    char answer='Y';
    while(answer!='N'&&answer!='n')
    {
        printf("请选择要旋转的图片类型\n");
        printf("256色的调色板图像请按1，真彩图按2\n");
        scanf("%d",&select);
        if(select==1)
      {
          bmp1(select);//针对8位（256色）的图的旋转
      }
       if(select==2)
      {
          bmp2(select);//针对真彩图的旋转
      }
      printf("是否继续翻转？\n");
      printf("继续按Y/y，退出按N/n\n");
      scanf(" %c",&answer);
    }
}
