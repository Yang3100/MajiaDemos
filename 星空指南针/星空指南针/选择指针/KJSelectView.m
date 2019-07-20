//
//  KJSelectView.m
//  星空指南针
//
//  Created by 杨科军 on 2018/10/21.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJSelectView.h"

#define select_white_height  SCREEN_HEIGHT/4

@interface KJSelectView(){
    NSArray *nameArr;
}

@property(nonatomic,strong) UIView *whiteBackView;

@end

@implementation KJSelectView

+ (instancetype)createSelectView:(void(^)(KJSelectView *obj))block{
    KJSelectView *backView = [[KJSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.alpha = 0;
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:backView action:@selector(cancleAction)]];
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    // 回调出去数据
    if (block) {
        block(backView);
    }
    
    [backView addSubview:backView.whiteBackView];
    [backView setUI];
    
    //    [backView moveAnimationIsUp:YES];
    [UIView animateWithDuration:0.2 animations:^{
        backView.whiteBackView.frame = CGRectMake(0, SCREEN_HEIGHT-select_white_height, SCREEN_WIDTH, select_white_height);
        backView.alpha = 1;
    }];
    
    int64_t delayInSeconds = 0.2; // 延迟的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 变大抖动动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.duration = 0.4;
        animation.keyTimes = @[@0,@0.5,@0.6,@0.7,@0.8,@0.9,@1];
        animation.values = @[@0,@1.04,@0.97,@1.02,@0.98,@1.01,@1];
        [backView.whiteBackView.layer addAnimation:animation forKey:@"transform.scale"];
    });
    
    
    return backView;
}

- (void)setUI{
    // 1.创建UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, select_white_height); // frame中的size指UIScrollView的可视范围
    [self.whiteBackView addSubview:scrollView];
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    nameArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    CGFloat sp = 10;
    CGFloat w = select_white_height-sp*2;
    for (int i = 0; i<nameArr.count; i++) {
        UIButton *button = InsertImageButton(scrollView, CGRectZero, i, GetImage(nameArr[i]), nil, self, @selector(btnClick:));
        button.backgroundColor = UIColorFromHEXA(0xffffff, 0.2);
        [KJTools makeCornerRadius:sp borderColor:MainColor layer:button.layer borderWidth:Handle(0.5)];
        CGFloat x = sp*2 + i*(sp+w);
        button.frame = CGRectMake(x, sp, w, w);
    }
    
    // 设置UIScrollView的滚动范围（内容大小）
    scrollView.contentSize = CGSizeMake(nameArr.count*(w+sp)+sp*3, 0);
}

- (void)btnClick:(UIButton*)sender{
    !self.updateClicked?:self.updateClicked(nameArr[sender.tag]);
}

#pragma mark - 视图消失
- (void)cancleAction{
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteBackView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, select_white_height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 背景面板
- (UIView*)whiteBackView{
    if (!_whiteBackView) {
        _whiteBackView = InsertView(nil, CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, select_white_height), UIColorFromHEXA(0xffffff, 0.1));
//        [KJTools makeCornerRadius:Handle(5) borderColor:MainColor layer:_whiteBackView.layer borderWidth:0.5];
        _whiteBackView.userInteractionEnabled = YES;
    }
    return _whiteBackView;
}


@end
