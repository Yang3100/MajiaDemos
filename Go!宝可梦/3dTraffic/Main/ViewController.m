//
//  ViewController.m
//  3dTraffic
//
//  Created by 杨科军 on 2018/11/13.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "KJPictureViewer.h"
#import "KJARVC.h"
#import "UIImage+GIF.h"

#import "KJPresentation.h"
#import "KJBubbleAnimation.h"

@interface ViewController ()<KJPictureViewerDelegate>

@property(weak, nonatomic) IBOutlet UIImageView *topWebView;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) NSArray *temps;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置代理即可 - 隐藏navigation
    self.navigationController.delegate = self;
    
    //  延时执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.imageV.image = [UIImage imageNamed:@"home"];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 本地地址
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shenqibaobei" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    self.topWebView.image = image;
    
    CGFloat h = (MainSize.width-20 - 2*10)/2;
    KJPictureViewer *pictureV = [[KJPictureViewer alloc]initWithFrame:CGRectMake(10, MainSize.height-h-10, MainSize.width-20, h)];
    pictureV.delegate = self;
    NSMutableArray *mua = [NSMutableArray array];
    for (int i=0; i<self.temps.count; i++) {
        [mua addObject:_temps[i]];
    }
    pictureV.kj_imageArray = mua;
    [self.view addSubview:pictureV];
    
    CGFloat y = _topWebView.frame.origin.y + _topWebView.frame.size.height + 10;
    CGFloat hh = MainSize.height - y - pictureV.frame.size.height - 20;
    hh = hh > MainSize.width ? MainSize.width : hh;
    CGFloat x = (MainSize.width - hh)/2;
    CGRect kj_fram = CGRectMake(x, y, hh, hh);
    self.imageV = [[UIImageView alloc]initWithFrame:kj_fram];
    _imageV.image = [UIImage imageNamed:@"home"];
    [self.view addSubview:self.imageV];
}

#pragma mark - KJPictureViewerDelegate
- (void)pictureViewer:(KJPictureViewer *)pictureViewer didGestureSelectedImage:(UIImage *)image andImageWorldRect:(CGRect)imageWorldRect Index:(NSInteger)index{
    self.imageV.image = nil;
    UIImage *im = [UIImage imageNamed:@"jinglingqiu"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:im];
    imageView.frame = imageWorldRect;
    [self.view addSubview:imageView];
    POPBasicAnimation *popAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    popAnimation.toValue = [NSValue valueWithCGPoint:self.imageV.center];
    popAnimation.duration = 0.3;
    popAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAAnimationLinear];
    [imageView.layer pop_addAnimation:popAnimation forKey:nil];
    
    // 动画完成后赋值
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(popAnimation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
        UIImage *im2 = [UIImage imageNamed:@"jinglingqiu2"];
        self.imageV.image = im2;
        KJARVC *vc = [[KJARVC alloc] init];
        vc.name = self.temps[index];
        
        CGFloat w = 10;
        CGFloat h = 10;
        CGFloat x = self.imageV.frame.origin.x + self.imageV.frame.size.width/2 - 5;
        CGFloat y = self.imageV.frame.origin.y + self.imageV.frame.size.height/2 - 5;
        CGRect fr = CGRectMake(x, y, w, h);
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentationBubbleAnimationFromVC:self ToVC:nav Frame:fr StrokeColor:UIColor.blackColor];
    });
}

- (NSArray*)temps{
    if (!_temps) {
        _temps = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"17",@"18",@"19",@"20",@"39",@"142",@"143",@"144",@"145",@"146",@"147",@"148",@"149"];
;
    }
    return _temps;
}

#pragma mark - 转场动画
// Bubble样式的转场动画效果 sourceRect:从什么位置产生气泡  StrokeColor:填充颜色
- (void)presentationBubbleAnimationFromVC:(UIViewController*)fromVC ToVC:(UIViewController*)toVC Frame:(CGRect)sourceRect StrokeColor:(UIColor*)strokeColor{
    KJBubbleAnimation *bubble = [[KJBubbleAnimation alloc] init];
    bubble.sourceRect  = sourceRect;
    bubble.strokeColor = strokeColor;
    bubble.duration = 0.7;
    
    [KJPresentation presentWithPresentationAnimation:bubble presentedViewController:toVC presentingViewController:fromVC];
}

@end
