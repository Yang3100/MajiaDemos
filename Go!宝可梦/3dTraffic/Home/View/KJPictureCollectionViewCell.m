//
//  KJPictureCollectionViewCell.m
//  AnimationDemo
//
//  Created by 杨科军 on 2016/10/23.
//  Copyright © 2016年 杨科军. All rights reserved.
//

#import "KJPictureCollectionViewCell.h"

CGFloat const gestureMinimumTranslation = 20.0;

// 手势移动
typedef enum : NSInteger {
    kPictureMoveDirectionNone,
    kPictureMoveDirectionUp,
    kPictureMoveDirectionDown,
    kPictureMoveDirectionRight,
    kPictureMoveDirectionLeft
} PictureMoveDirection;

@interface KJPictureCollectionViewCell ()<UIGestureRecognizerDelegate>
/** 是否在运动*/
@property(nonatomic,assign,getter=isOnWindow)BOOL onWindow;
/** 用来判断pan手势的方向*/
@property(nonatomic,assign)PictureMoveDirection direction;

@end

@implementation KJPictureCollectionViewCell

#pragma mark - life
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView  addSubview:self.imageView];
        self.contentView.layer.cornerRadius = 5;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderColor = [UIColor colorWithRed:196/255.0 green:228/255.0 blue:227/255.0 alpha:1].CGColor;
        self.contentView.layer.borderWidth = 1;
    }
    return self;
}
- (void)layoutSubviews{
    self.imageView.frame = CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10);
}

#pragma mark - 手势响应
/**
 拖拽手势相应函数
 @param recognizer 手势
 */
- (void)handGesture:(UIPanGestureRecognizer*)recognizer{
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    // 判断方向
    // 到了拖拽手势
    CGPoint translation = [recognizer translationInView:self.contentView];
    if (recognizer.state == UIGestureRecognizerStateBegan){
        self.direction = kPictureMoveDirectionNone;
    }else if (recognizer.state == UIGestureRecognizerStateChanged && self.direction == kPictureMoveDirectionNone){
        self.direction = [self determinePictureDirectionIfNeeded:translation];
    }
    //---end
    if (self.direction == kPictureMoveDirectionUp||
        self.direction == kPictureMoveDirectionDown) {
        //竖直滑动
        [self verticalActionWithRecognizer:recognizer];
        //锁定在竖直
        if (self.delegate && [self.delegate respondsToSelector:@selector(pictureCollection:lockScollViewWithOnWindow:)]) {
            [self.delegate pictureCollection:self lockScollViewWithOnWindow:self.isOnWindow];
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded ) {//松手的时候执行
        if (self.direction == kPictureMoveDirectionUp ||
            self.direction == kPictureMoveDirectionDown) {
            //返回最后的本地viewCenter的坐标
            CGPoint endPoint =  [self.contentView convertPoint:recognizer.view.center fromView:lastWindow];
            //判断距离
            if (endPoint.y < 0 && self.isOnWindow) {//发送出去
                [self sendImageRecognizer:recognizer];
            }else {//返回cell上
                [self backImageRecognizer:recognizer];
            }
        }
        self.onWindow = NO;
        //解锁scolliew
        if (self.delegate && [self.delegate respondsToSelector:@selector(pictureCollection:lockScollViewWithOnWindow:)]) {
            [self.delegate pictureCollection:self lockScollViewWithOnWindow:self.isOnWindow];
        }
    }
}

// This method will determine whether the direction of the user's swipe

/**
 判断pan手势的方向
 @param translation 移动的距离
 @return 方向
 */
- (PictureMoveDirection)determinePictureDirectionIfNeeded:(CGPoint)translation{
    if (self.direction != kPictureMoveDirectionNone)
        return self.direction;
    // determine if horizontal swipe only if you meet some minimum velocity
    if (fabs(translation.x) > gestureMinimumTranslation){
        BOOL gestureHorizontal = NO;
        if (translation.y ==0.0)
            gestureHorizontal = YES;
        else
            gestureHorizontal = (fabs(translation.x / translation.y) >5.0);
        if (gestureHorizontal){
            if (translation.x >0.0)
                return kPictureMoveDirectionRight;
            else
                return kPictureMoveDirectionLeft;
        }
    }
    // determine if vertical swipe only if you meet some minimum velocity
    else if (fabs(translation.y) > gestureMinimumTranslation){
        BOOL gestureVertical = NO;
        if (translation.x ==0.0)
            gestureVertical = YES;
        else
            gestureVertical = (fabs(translation.y / translation.x) >5.0);
        if (gestureVertical){
            if (translation.y >0.0)
                return kPictureMoveDirectionDown;
            else
                return kPictureMoveDirectionUp;
        }
    }
    return self.direction;
}

/**
 竖直滑动
 @param recognizer 手势
 */
- (void)verticalActionWithRecognizer:(UIPanGestureRecognizer*)recognizer{
//    NSLog(@"竖直移动");
    CGPoint cellCenterPoint = CGPointZero;
    CGPoint worldCenterPoint = CGPointZero;
    //手势移动了多远
    CGPoint translation = [recognizer translationInView:self.contentView];
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    cellCenterPoint = CGPointMake(recognizer.view.center.x, translation.y + recognizer.view.center.y);
    //转回原来的坐标   不是第一次的时候
    if (self.isOnWindow) {
        cellCenterPoint = [self.contentView convertPoint:cellCenterPoint fromView:lastWindow];
    }
    [lastWindow addSubview:recognizer.view];
    //转换为世界坐标
    worldCenterPoint = [self.contentView convertPoint:cellCenterPoint toView:lastWindow];
    recognizer.view.center = worldCenterPoint;
    self.onWindow = YES;
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.contentView];
}

/**
 发送图片
 @param recognizer 手势
 */
- (void)sendImageRecognizer:(UIPanGestureRecognizer*)recognizer{
    NSLog(@"发出去");
    UIImageView *imageV = (UIImageView*)recognizer.view;
    __weak typeof(self) weakSelf = self;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pictureCollection:didGestureSelectedImage:andImageWorldRect:)]) {
        [self.delegate pictureCollection:self didGestureSelectedImage:imageV.image andImageWorldRect:recognizer.view.frame];
    }
    //设置动画初始frame
    imageV.frame  = CGRectMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5, 0, 0);
    [self.contentView addSubview:imageV];
    [UIView animateWithDuration:.3 animations:^{
        imageV.frame = weakSelf.bounds;
    } completion:^(BOOL finished) {

    }];
}

/**
 返回图片
 @param recognizer 手势
 */
- (void)backImageRecognizer:(UIPanGestureRecognizer*)recognizer{
    NSLog(@"返回");
    __weak typeof(self) weakSelf = self;
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    // 添加动画
    CGRect worldOrginalRect = [self.contentView convertRect:self.bounds toView:lastWindow];
    // 一开始要记下frame，动画在window上做，完成后再加到contentView上
    [UIView animateWithDuration:.5 animations:^{
        recognizer.view.frame = worldOrginalRect;
    } completion:^(BOOL finished) {
        [weakSelf.contentView addSubview:recognizer.view];
        recognizer.view.frame =  self.bounds;
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    /*是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
     是否允许多个手势识别器共同识别，一个控件的手势识别后是否阻断手势识别继续向下传播，默认返回NO；如果为YES，响应者链上层对象触发手势识别后，如果下层对象也添加了手势并成功识别也会继续执行，否则上层对象识别后则不再继续传播*/
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - lazy
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        //添加手势
        UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handGesture:)];
        panGest.delegate = self;
        [self.imageView addGestureRecognizer:panGest];
    }
    return _imageView;
}

@end









