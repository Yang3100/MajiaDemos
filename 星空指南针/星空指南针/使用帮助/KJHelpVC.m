//
//  KJHelpVC.m
//  星空指南针
//
//  Created by 杨科军 on 2018/10/22.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHelpVC.h"

@interface KJHelpVC ()

@property(nonatomic,strong) UIImageView *showImg;
@property(nonatomic,strong) CAEmitterLayer *emitterLayer;  // 粒子容器
@property(nonatomic,strong) CAEmitterCell *emitterCell;    // 粒子
@property(nonatomic,strong) CAEmitterCell *emitterCell2;    // 粒子

@end

@implementation KJHelpVC

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *_scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-kSTATUSBAR_NAVIGATION_HEIGHT)];
    CGFloat imgH = [self imgContentHeight];
    _scView.contentSize = CGSizeMake(0,imgH);//设置滚动视图的大小
    //        _scView.pagingEnabled = YES;//设置是否可以进行画面切换  分块显示
    _scView.bounces = NO;
    _scView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    _scView.showsVerticalScrollIndicator = NO;//
    [self.view addSubview:_scView];
    //把视图添加到当前的滚动视图中
    [_scView addSubview:self.showImg];
    
    
    UIButton *leftButton = InsertImageButton(self.view, CGRectZero, 519, GetImage(@"back"), nil, self, @selector(btnClick));
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(Handle(20));
        make.height.width.mas_equalTo(Handle(22));
        make.top.mas_equalTo(self.view).mas_offset(kSTATUSBAR_NAVIGATION_HEIGHT/2);
    }];
    
    UILabel *la = InsertLabel(self.view, CGRectZero, NSTextAlignmentCenter, @"使用帮助", SystemFontSize(20), [UIColor whiteColor]);
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(Handle(22));
        make.top.mas_equalTo(self.view).mas_offset(kSTATUSBAR_NAVIGATION_HEIGHT/2);
    }];
    
    
    // 添加粒子效果
    [self.view.layer addSublayer:self.emitterLayer];
}

- (void)btnClick{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 显示图片的ImgView
-(UIImageView *)showImg{
    if (!_showImg) {
        CGFloat imgH = [self imgContentHeight];
        _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , imgH)];
        //设置imageView的背景图
        [_showImg setImage:[UIImage imageNamed:@"IMG_4529"]];
        //给imageView设置区域
        _showImg.contentMode = UIViewContentModeScaleAspectFill;
        //超出边界的剪切
        //        [_showImg setClipsToBounds:YES];
    }
    return _showImg;
}

#pragma mark - 内容的高度
- (CGFloat)imgContentHeight{
    //获取图片高度
    UIImage *img = [UIImage imageNamed:@"IMG_4529"];
    CGFloat imgHeight = img.size.height;
    CGFloat imgWidth = img.size.width;
    CGFloat imgH = imgHeight * (SCREEN_WIDTH / imgWidth);
    return imgH;
}


#pragma mark - 初始化粒子容器
- (CAEmitterLayer*)emitterLayer{
    if (!_emitterLayer) {
        // 粒子容器
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        emitterLayer.emitterPosition = self.view.center;
        emitterLayer.emitterSize     = self.view.frame.size;
        emitterLayer.emitterMode     = kCAEmitterLayerVolume;
        emitterLayer.emitterShape    = kCAEmitterLayerRectangle;
        emitterLayer.renderMode      = kCAEmitterLayerOldestFirst;
        
//                CAEmitterCell *subCell2 = home_Emitter_subCell([KJTools getImageFromColor:[UIColor blueColor] Rect:CGRectMake(0, 0, 10, 10)]);
        // 将色块粒子加入到容器之中
        emitterLayer.emitterCells = @[self.emitterCell,self.emitterCell2];
        
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

#pragma mark - 粒子设置
- (CAEmitterCell*)emitterCell{
    if (!_emitterCell) {
        _emitterCell = [CAEmitterCell emitterCell];
        
        // 粒子
        // 和CALayer一样，只是用来设置图片
        UIImage *image = GetImage(@"home_emttier_blue");
        _emitterCell.contents = (__bridge id _Nullable)image.CGImage;
        
        _emitterCell.lifetime = 5;    // 粒子存活时间
        _emitterCell.lifetimeRange = 0; // 生命周期范围
        _emitterCell.alphaRange = 0.5f;
        _emitterCell.alphaSpeed = -0.3f;      // 粒子消逝的速度
        _emitterCell.spin = M_PI;             // 自旋转角度
        _emitterCell.spinRange = 2 * M_PI;    // 自旋转角度范围
        
        
        //发射器
        _emitterCell.birthRate = 20;        // 每秒生成粒子的个数
        _emitterCell.yAcceleration = 0.f;   // 粒子的初始加速度
        _emitterCell.xAcceleration = 0.1f;
        _emitterCell.velocity = 20;           // 粒子运动的速度均值
        _emitterCell.velocityRange = 30.f;    // 粒子运动的速度扰动范围
        _emitterCell.emissionRange  = 2*M_PI; // 粒子发射角度范围
        
        _emitterCell.scale = 0.05;             // 缩放比例
        _emitterCell.scaleRange = 0.1;        // 缩放比例范围
        _emitterCell.scaleSpeed = 0.05;
    }
    return _emitterCell;
}

- (CAEmitterCell*)emitterCell2{
    if (!_emitterCell2) {
        CAEmitterCell *_emitterCell = [CAEmitterCell emitterCell];
        
        // 粒子
        // 和CALayer一样，只是用来设置图片
        UIImage *image = imageWithColor([UIColor whiteColor]);
        _emitterCell.contents = (__bridge id _Nullable)image.CGImage;
        
        _emitterCell.lifetime = 5;    // 粒子存活时间
        _emitterCell.lifetimeRange = 0; // 生命周期范围
        _emitterCell.alphaRange = 0.5f;
        _emitterCell.alphaSpeed = -0.3f;      // 粒子消逝的速度
        _emitterCell.spin = M_PI;             // 自旋转角度
        _emitterCell.spinRange = 2 * M_PI;    // 自旋转角度范围
        
        
        //发射器
        _emitterCell.birthRate = 20;        // 每秒生成粒子的个数
        _emitterCell.yAcceleration = 0.f;   // 粒子的初始加速度
        _emitterCell.xAcceleration = 0.1f;
        _emitterCell.velocity = 20;           // 粒子运动的速度均值
        _emitterCell.velocityRange = 30.f;    // 粒子运动的速度扰动范围
        _emitterCell.emissionRange  = 2*M_PI; // 粒子发射角度范围
        
        _emitterCell.scale = 0.2;             // 缩放比例
        _emitterCell.scaleRange = 0.1;        // 缩放比例范围
        _emitterCell.scaleSpeed = 0.05;
        _emitterCell2 = _emitterCell;
    }
    return _emitterCell2;
}

UIImage *imageWithColor(UIColor *color){
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
