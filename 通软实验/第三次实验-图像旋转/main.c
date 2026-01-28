/**************************************************************************
  * @brief           	: 图像旋转 
  * @author        		: 雷宇航 
  * @copyright    		: 归作者所有 
  * @version       		: Version 1.0
  * @note            	: None
  * @history        	: None
***************************************************************************/

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

BITMAPFILEHEADER fileHead;
BITMAPINFOHEADER infoHead;
/**************************************************************************
  * @brief              	: 输出图像参数 
  * @param[in]     			: 文件头、信息头 
  * @param[out]   			: None 
  * @return            		:  
  * @others           		:  
***************************************************************************/
void bmp_information(BITMAPFILEHEADER fileHead,BITMAPINFOHEADER infoHead)//打印图片信息
{
    unsigned long size, offBits;//文件大小,偏移大小
    long width, height;//图像宽度大小,图像高度大小
    unsigned short bitCount, planes;//位深大小,调色板大小
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
/**************************************************************************
  * @brief              	: BMP图像旋转处理 
  * @param[in]     			: None 
  * @param[out]   			: None 
  * @return            		:  
  * @others           		:  
***************************************************************************/
void bmp()
{
    int i,j,k;
    FILE *fp = fopen("C:\\Users\\86185\\Desktop\\通软实验\\第三次实验-图像旋转\\mmexport1713456037257.bmp", "rb");
    if (fp == NULL)
    {
        printf("文件打开失败\n");
        exit(1);
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
    FILE *newfp = fopen("test1.bmp", "wb");
    if (newfp == NULL)
    {
        printf("文件创建失败\n");
        exit(1);
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
    system("test2.bmp");

}
/**************************************************************************
  * @brief              	: 高度信息与宽度信息的交换 
  * @param[in]     			: 文件头、信息头 
  * @param[out]   			: None 
  * @return            		:  
  * @others           		:  
***************************************************************************/
void exchange(char *a,char *b)
{
    char n;
    n=*a;
    *a=*b;
    *b=n;
}

int main()
{
    int i,j,k;
//打开原图像文件
    printf("请选择要旋转的图片类型\n");
    bmp();
    return 0;
}

