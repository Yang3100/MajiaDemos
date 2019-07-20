//
//  KJExplodeAnimation.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/29.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJExplodeAnimation.h"

@implementation KJExplodeAnimation

- (instancetype)init{
    if (self = [super init]){
        /// 设置默认配置
        [self setupDefaults];
    }
    return self;
}

/**
 *  设置默认配置
 */
- (void)setupDefaults{
    self.duration = 0.7;
}

- (void)setContinueTime:(NSTimeInterval)continueTime{
    if (!continueTime) {
        _continueTime = self.duration;
    }else{
        _continueTime = continueTime;
    }
}

#pragma mark - Override

- (void)beginAnimation{
    BOOL afterScreenUpdates = NO;
    
    if (@available(iOS 10.0, *)) {
        afterScreenUpdates = YES;
    }
    
    [self.contaionerView addSubview:self.toView];
    [self.contaionerView sendSubviewToBack:self.toView];
    
    CGSize size = self.toView.frame.size;
    
    // 碎片存放数组
    NSMutableArray *snapshots = [NSMutableArray new];
    
    CGFloat xFactor = 10.0f;
    CGFloat yFactor = xFactor * size.height / size.width;
    
    UIView *fromViewSnapshot = [self.fromView snapshotViewAfterScreenUpdates:NO];
    
    // 产生碎片
    for (CGFloat x=0; x < size.width; x+= size.width / xFactor){
        for (CGFloat y=0; y < size.height; y+= size.height / yFactor){
            CGRect snapshotRegion = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion  afterScreenUpdates:afterScreenUpdates withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            [self.contaionerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    
    [self.contaionerView sendSubviewToBack:self.fromView];
    
    [UIView animateWithDuration:self.continueTime animations:^{
        for (UIView *view in snapshots){
            CGFloat xOffset = [self randomFloatBetween:-50.0 and:50.0];
            CGFloat yOffset = [self randomFloatBetween:-80.0 and:80.0];
            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
            view.alpha = 0.0;
            view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]), 0.01, 0.01);
        }
    } completion:^(BOOL finished) {
        for (UIView *view in snapshots){
            [view removeFromSuperview];
        }
        
        [self endAnimation];
    }];
}

#pragma mark - Privite Method
// 拆分碎片
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber{
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}


@end
