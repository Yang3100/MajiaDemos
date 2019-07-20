//
//  ZJ_RulesLineMovingView.m
//  ceshi
//
//  Created by shao_Mac on 2018/5/4.
//  Copyright © 2018年 shao_Mac. All rights reserved.
//

#import "ZJ_RulesLineMovingView.h"

@interface ZJ_RulesLineMovingView()
@property (assign, nonatomic) CGPoint beginpoint;
@end

@implementation ZJ_RulesLineMovingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (SlideHeight-((32*SCREEN_WIDTH)/374))/2, SCREEN_WIDTH, (32*SCREEN_WIDTH)/374)];
        imageView.image = [UIImage imageNamed:@"zhichizhixiang"];
        [self addSubview:imageView];
        
//        // 移动手势
//        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
//        [self addGestureRecognizer:panGestureRecognizer];
        
    }
    return self;
}

//// 处理拖拉手势
//- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
//{
//    UIView *view = panGestureRecognizer.view;
//    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
//        [view setCenter:(CGPoint){view.center.x, view.center.y + translation.y}];
//        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
//        if ([self.delegate respondsToSelector:@selector(valueChange)]) {
//            [self.delegate valueChange];
//        }
//    }
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y += currentLocation.y - self.beginpoint.y;
    
    if (frame.origin.y < - (SlideHeight/2)) {
        frame.origin.y = - (SlideHeight/2);
    }
    
    if (frame.origin.y > SCREEN_HEIGHT - SlideHeight/2) {
        frame.origin.y = SCREEN_HEIGHT - SlideHeight/2;
    }
    
    self.frame = frame;
    if ([self.delegate respondsToSelector:@selector(valueChange)]) {
        [self.delegate valueChange];
    }


}



@end
