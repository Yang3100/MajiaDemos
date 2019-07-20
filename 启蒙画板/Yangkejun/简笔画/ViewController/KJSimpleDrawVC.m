//
//  KJSimpleDrawVC.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJSimpleDrawVC.h"
#import "KJModel.h"

#import "KJAView.h"
#import "KJBView.h"
#import "KJCView.h"
#import "KJDView.h"
#import "KJEView.h"
#import "KJFView.h"
#import "KJGView.h"
#import "KJHView.h"
#import "KJIView.h"
#import "KJJView.h"
#import "KJKView.h"
#import "KJLView.h"
#import "KJMView.h"
#import "KJNView.h"
#import "KJOView.h"
#import "KJPView.h"
#import "KJQView.h"
#import "KJRView.h"

@interface KJSimpleDrawVC ()

@end

@implementation KJSimpleDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"画板";
//    self.view.backgroundColor = MainColor(0.1);
    
    UILabel *laa = InsertLabel(self.view, CGRectZero, NSTextAlignmentCenter, @"小朋友跟着我画哦~", SystemFontSize(40), MainColor(1));
    laa.numberOfLines = 0;
    [laa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-20);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
    }];
}

- (void)setIndex:(NSInteger)index{
    NSArray *className = @[@"KJEView",@"KJFView",@"KJLView",@"KJHView",@"KJIView",@"KJJView",@"KJAView",@"KJBView",@"KJCView",@"KJDView",@"KJKView",@"KJGView",@"KJMView",@"KJNView",@"KJOView",@"KJPView",@"KJQView",@"KJRView"];
    KJBaseView *baseView = [[NSClassFromString(className[index]) alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
    [self abc:baseView];
    [self.view addSubview:baseView];
}

- (void)abc:(KJBaseView*)bv{
    // 2. 第二种画的方式
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为心形路径
    animation.path = bv.path.CGPath;
    // 动画时间间隔
    animation.duration = [UserDefault floatForKey:@"draw_time"];
    // 重复次数为最大值
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationPaced;
    NSString *nam = [self kj_retColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:nam]];
    imageView.frame = CGRectMake(0, -64, 150, 150);
    [bv.shapeLayer addSublayer:imageView.layer];
    // 将动画添加到动画视图上
    [imageView.layer addAnimation:animation forKey:nil];
}

- (NSString*)kj_retColor{
    NSInteger index = [UserDefault integerForKey:@"draw_color"];
    NSString *mColor;
    switch (index) {
        case 520:
            mColor = @"lvsehuabi";
            break;
        case 521:
            mColor = @"huangsehuabi";
            break;
        case 522:
            mColor = @"lansehuabi";
            break;
        case 523:
            mColor = @"hongsehuabi";
            break;
        case 524:
            mColor = @"zisehuabi";
            break;
        case 525:
            mColor = @"heisehuabi";
            break;
            
        default:
            break;
    }
    return mColor;
}

@end
