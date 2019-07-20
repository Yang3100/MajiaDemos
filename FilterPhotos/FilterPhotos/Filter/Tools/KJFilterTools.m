//
//  KJFilterTools.m
//  FilterPhotos
//
//  Created by 杨科军 on 2018/11/14.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJFilterTools.h"

//全局内存空间地址指针 用于在合适的时候释放内存
static void *bitmap;

@implementation KJFilterTools

#pragma mark - 遍历每个像素，调整色值
//获得以像素为单位的长和宽，开始处理位图中每个像素的值，生成指定效果
- (UIImage *)createImageWithImage:(UIImage *)inImage colorMatrix:(const float *)f{
    // 图片位图像素值数组
    unsigned char *image_pix = RequestImagePixelData(inImage);
    CGImageRef image_ref = [inImage CGImage];
    long w = CGImageGetWidth(image_ref);
    long h = CGImageGetHeight(image_ref);
    
    int temp_w = 0;
    int temp_pix = 0;
    
    /* 遍历修改位图像素值         */
    for (long y = 0; y<h; y++) {
        temp_pix = temp_w;
        for (long x = 0; x<w; x++) {
            int red   = (unsigned char)image_pix[temp_pix];
            int green = (unsigned char)image_pix[temp_pix+1];
            int blue  = (unsigned char)image_pix[temp_pix +2];
            int alpha = (unsigned char)image_pix[temp_pix +3];
            
            // 修改rgb值
            ChangeRGBA(&red, &green, &blue, &alpha,f);
            image_pix[temp_pix] = red;
            image_pix[temp_pix + 1] = green;
            image_pix[temp_pix + 2] = blue;
            image_pix[temp_pix + 3] = alpha;
            temp_pix += 4; // 4个像素点遍历
        }
        temp_w += w * 4 ;
    }
    
    NSInteger dataLength = w * h * 4;
    //创建要输出的图像的相关参数
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, image_pix, dataLength, NULL);
    
    if (!provider) {
        NSLog(@"创建输出图像相关参数失败！");
    }else{
        int bitsPerComponent = 8;
        int bitsPerPixel = 32;
        ItemCount bytesPerRow = 4 * w;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
        CGColorRenderingIntent rederingIntent = kCGRenderingIntentDefault;
        //创建要输出的图像
        CGImageRef imageRef = CGImageCreate(w, h,bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider,NULL, NO, rederingIntent);
        if (!imageRef) {
            NSLog(@"创建输出图像失败");
        }else{
            UIImage *my_image = [UIImage imageWithCGImage:imageRef];
            CFRelease(imageRef);
            CGColorSpaceRelease(colorSpaceRef);
            CGDataProviderRelease(provider);
            
            NSData *data = UIImageJPEGRepresentation(my_image, 1.0);
            
            //在此释放位图空间
            free(bitmap);
            return [UIImage imageWithData:data];
        }
    }
    return nil;
}

#pragma mark - 1.获取图像的每个像素点的RGBA值数组
/*
 注:
 该c方法返回一个指针，该指针指向一个数组，
 数组中的每四个元素都是图像上的一个像素点的RGBA的数值（0-255），
 用无符号的char是因为它正好的取值范围就是0-255
 */
static unsigned char *RequestImagePixelData(UIImage * inImage){
    CGImageRef img = [inImage CGImage];
    CGSize size = [inImage size];
    //使用上面的函数创建上下文
    CGContextRef cgctx = CreateRGBABitmapContex(img);
    CGRect rect = {{0,0},{size.width,size.height}};
    
    //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
    CGContextDrawImage(cgctx, rect, img);
    unsigned char *data = CGBitmapContextGetData(cgctx);
    
    //释放上面的函数创建的上下文
    CGContextRelease(cgctx);
    cgctx = NULL;
    
    return data;
}
#pragma mark - 创建一个使用RGBA通道的位图上下文
static CGContextRef CreateRGBABitmapContex(CGImageRef inImage){
    CGContextRef context = NULL;
    // 颜色通道
    CGColorSpaceRef colorSpace;
    void *bitmapData;//内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
    long bitmapByteCount;
    long bitmapBytePerRow;
    
    //获取像素的横向和纵向个数
    size_t pixelsWith = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    //每一行的像素点占用的字节数，每个像素点的RGBA四个通道各占8bit空间
    bitmapBytePerRow = (pixelsWith * 4);
    
    //整张图片占用的字节数
    bitmapByteCount = (bitmapBytePerRow * pixelsHigh);
    
    //创建依赖设备的RGB通道
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //分配足够容纳图片字节数的内存空间
    bitmapData = malloc(bitmapByteCount);
    
    bitmap = bitmapData;
    
    /* 创建CoreGraphic的图形上下文 该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数 */
    context = CGBitmapContextCreate(bitmapData,
                                    pixelsWith,
                                    pixelsHigh,
                                    8,
                                    bitmapBytePerRow,
                                    colorSpace,
                                    CGImageGetBitmapInfo(inImage));
    
    // Core Foundation中含有Create、Alloc的方法名字创建的指针，需要使用CFRelease（）函数释放
    CGColorSpaceRelease(colorSpace);
    
    if (bitmapData == NULL) {
        return NULL;
    }
    return context;
}

#pragma mark - 2.值调整一个像素点的RGBA值
// 注:如下方法传入参数为数值指针和一个颜色矩阵，通过颜色矩阵调整指针指向地址存储的数值
static void ChangeRGBA(int *red, int *green, int *blue, int *alpha, const float *f){
    int r = *red;
    int g = *green;
    int b = *blue;
    int a = *alpha;
    *red = f[0] * r + f[3]*g + f[6]*b + f[9] * a;
    *green = f[1] * r + f[4]*g + f[7]*b + f[10] * a;
    *blue = f[2] * r + f[5]*g + f[8]*b + f[11] * a;
    
    *red < 0 ? (*red = 0):(0);
    *red > 255 ? (*red = 255):(0);
    
    *green < 0 ? (*green = 0):(0);
    *green > 255 ? (*green = 255):(0);
    
    *blue < 0 ? (*blue = 0):(0);
    *blue > 255 ? (*blue = 255):(0);
    
    *alpha < 0 ? (*alpha = 0):(0);
    *alpha > 255 ? (*alpha = 255):(0);
}


@end
