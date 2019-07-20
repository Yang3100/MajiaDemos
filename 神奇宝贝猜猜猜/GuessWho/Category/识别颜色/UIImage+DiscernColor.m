//
//  UIImage+DiscernColor.m
//  色彩大淘沙
//
//  Created by 杨科军 on 2018/10/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "UIImage+DiscernColor.h"
#import "UIColor+TDAdditions.h"
#import "KJCountedColorModel.h"
#import <objc/runtime.h>  // Objective-C是基于C加入了面向对象特性和消息转发机制的动态语言

#define Image_scaled_w 100
#define Image_scaled_h 100

@interface UIImage()

@property (nonatomic,assign) NSInteger kj_count;

@end

@implementation UIImage (DiscernColor)

#pragma mark - associated 关联(类别中使用属性)
- (NSInteger)kj_count{
    return (NSInteger)objc_getAssociatedObject(self, @selector(kj_count));
}
- (void)setKj_count:(NSInteger)kj_count{
    objc_setAssociatedObject(self, @selector(kj_count), @(kj_count), OBJC_ASSOCIATION_RETAIN);
}

- (NSArray*)kj_getColorsFromImage:(UIImage *)image count:(NSInteger)count{
    // 保存
    self.kj_count = count;
    
    // 裁剪或者拉伸图片
    UIImage *scaledImage = image;// kj_imageByScalingAndCroppingForTargetSize:CGSizeMake(Image_scaled_w, Image_scaled_h)];
//    UIImage *scaledImage = [image kj_imageCompressForWidth:100];
    if (!scaledImage){
        return nil;
    }
    
    // 去除图片的白色背景
    UIImage *ima = [UIImage kj_imageToTransparent:scaledImage];
    
    // 返回颜色数组
    return [self kj_findColorsOfImage:ima];
}

- (NSArray *)kj_findColorsOfImage:(UIImage *)image{
    size_t width = CGImageGetWidth(image.CGImage);
    size_t height = CGImageGetHeight(image.CGImage);
    
    NSCountedSet *colorSet = [[NSCountedSet alloc] initWithCapacity:width * height];
//    NSMutableArray *imagePoints = [NSMutableArray array];
    for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
            CGPoint point = CGPointMake(x, y);
            UIColor *color = [UIImage kj_colorFromImage:image Point:point];
            // 判断
            [colorSet addObject:color];
//            [imagePoints addObject:NSStringFromCGPoint(point)];
        }
    }
    NSEnumerator *enumerator = [colorSet objectEnumerator];
    UIColor *curColor = nil;
    // 创建一个指定个数的可变数组
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:colorSet.count];
    while ((curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [colorSet countForObject:curColor]; // 颜色出现次数
        // 判断当前颜色是否出现10次以上
        if ( tmpCount < 8 ) {
            continue;
        }
        curColor = [curColor colorWithMinimumSaturation:0.15f];
        NSUInteger colorCount = [colorSet countForObject:curColor];
        KJCountedColorModel *model = [[KJCountedColorModel alloc] init];
        model.count = colorCount;
        model.color = curColor;
//        model.point = CGPointFromString([imagePoints objectAtIndex:i-1]);
        [modelArray addObject:model];
    }
    
    return [KJCountedColorModel getNotRepetitionColors:modelArray maxCount:self.kj_count];
}

//根据图片获取图片的主色调
+ (UIColor*)kj_mostColor:(UIImage*)image{
    // 裁剪图片
//    image = [self kj_cropImageWithAnySize:CGSizeMake(Image_scaled_w, Image_scaled_h) Image:image];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(image.size.width, image.size.height);
    // RGBA 色彩 （显示3色）
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    // 第二步 取每个点的像素值 (开辟空间)
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) return nil;
    // 创建一个NSCountSet统计重复元素
    NSCountedSet *colorSet = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red    = data[offset];
            int green  = data[offset+1];
            int blue   = data[offset+2];
            float alpha  = data[offset+3];
            if (alpha>0) {//去除透明小于0.15以下
                if (red==255&&green==255&&blue==255) {//去除白色
                }else if (red==0&&green==0&&blue==0) {//去掉黑色
                }else {
                    // 将颜色加入Set
                    [colorSet addObject:[UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)]];
                }
            }
        }
    }
    CGContextRelease(context);// 释放资源
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [colorSet objectEnumerator];
    UIColor *cur_rgba = nil;
    UIColor *MaxColor;
    NSUInteger MaxCount=0;   // 用于找到主色调
    while ( (cur_rgba = [enumerator nextObject]) != nil ){  // 遍历颜色数组
        NSUInteger tmpCount = [colorSet countForObject:cur_rgba]; // 颜色当前次数
        // 判断当前颜色是否出现10次以上
        if ( tmpCount < MaxCount ) { continue; }
        MaxCount = tmpCount;
        MaxColor = cur_rgba;
    }
    
    return MaxColor;
}


#pragma mark - 内部方法

// 裁剪图片大小
/**
 *  改变Image的任何的大小
 *
 *  @param size 目的大小
 *
 *  @return 修改后的Image
 */
+ (UIImage *)kj_cropImageWithAnySize:(CGSize)size Image:(UIImage*)image{
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    float scale = w/h;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    
    if (scale > size.width/size.height){
        rect.origin.x = (w - h * size.width/size.height)/2;
        rect.size.width  = h * size.width/size.height;
        rect.size.height = h;
    }else {
        rect.origin.y = (h - w/size.width * size.height)/2;
        rect.size.width  = w;
        rect.size.height = w/size.width * size.height;
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

+ (UIColor *)kj_colorFromImage:(UIImage *)image Point:(CGPoint)point{
    // Put image in buffer
    CGImageRef imageRef = image.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 开辟空间
    unsigned char *rawData = (unsigned char*)calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
                                                 );
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // rawDara now contains the image data in RGBA8888
    NSInteger byteIndex = (bytesPerRow * point.y) + (point.x * bytesPerPixel);
    
    CGFloat red = (rawData[byteIndex] * 1.f) / 255.f;
    CGFloat green = (rawData[byteIndex + 1] * 1.f) / 255.f;
    CGFloat blue = (rawData[byteIndex + 2] * 1.f) / 255.f;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.f;
    free(rawData); // 释放空间
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
// 获取图片上点个颜色Hex  (#FFFFFF白色)
+ (NSString *)kj_colorHexFromImage:(UIImage *)image Point:(CGPoint)point{
    // Put image in buffer
    CGImageRef imageRef = image.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef) / image.scale;
    NSUInteger height = CGImageGetHeight(imageRef) / image.scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*)calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    CGContextRef context = CGBitmapContextCreate(rawData,
                                                 width,
                                                 height,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
                                                 );
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // rawDara now contains the image data in RGBA8888
    NSInteger byteIndex = (bytesPerRow * point.y) + (point.x * bytesPerPixel);
    
    CGFloat red = (rawData[byteIndex] * 1.f);
    CGFloat green = (rawData[byteIndex + 1] * 1.f);
    CGFloat blue = (rawData[byteIndex + 2] * 1.f);
    free(rawData);
    
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)red, (int)green, (int)blue];
}

//去除图片的白色背景
+ (UIImage*)kj_imageToTransparent:(UIImage*)image{
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf,
                                                 imageWidth,
                                                 imageHeight,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast
                                                 );
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
//    //去除白色...将0xFFFFFF00换成其它颜色也可以替换其他颜色。
//    if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {
//        uint8_t* ptr = (uint8_t*)pCurPtr;
//        ptr[0] = 0;
//    }
        
        //接近白色
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        //分别取出RGB值后。进行判断需不需要设成透明。
        uint8_t *ptr = (uint8_t*)pCurPtr;
        if (ptr[1] > 240 && ptr[2] > 240 && ptr[3] > 240) {
            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
            ptr[0] = 0;
        }
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL,
                                                                  rgbImageBuf,
                                                                  bytesPerRow * imageHeight,
                                                                  nil);
    CGImageRef imageRef = CGImageCreate(imageWidth,
                                        imageHeight,
                                        8,
                                        32,
                                        bytesPerRow,
                                        colorSpace,
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little,
                                        dataProvider,
                                        NULL,
                                        true,
                                        kCGRenderingIntentDefault
                                        );
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
    
}

@end

