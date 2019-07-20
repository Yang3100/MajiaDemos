//
//  KJBaseCustomTabBar.m
//  LiveShow
//
//  Created by 杨科军 on 2017/7/17.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import "KJBaseCustomTabBar.h"

@interface KJBaseCustomTabBar ()

@property (nonatomic, strong) UIButton *liveBtn;

@end

@implementation KJBaseCustomTabBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        InsertView(self, CGRectMake(0, 0, SCREEN_WIDTH, 0.5), UIColorHexFromRGB(0xe5e5e5));
//        [self setBackgroundImage:[UIImage imageNamed:@"tabBar_bottom"]];
        self.backgroundColor = [UIColor whiteColor];
        // 添加一个按钮到tabbar中
        UIButton *liveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [liveBtn setImage:[UIImage imageNamed:@"nor_camera"] forState:UIControlStateNormal];
        liveBtn.size = liveBtn.currentImage.size;
        [liveBtn addTarget:self action:@selector(liveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:liveBtn];
        self.liveBtn = liveBtn;

        [[UITabBar appearance] setShadowImage:[UIImage new]];
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        //设置为半透明
        self.translucent = YES;
    }
    return self;
}
-  (void)setFrame:(CGRect)frame{
    [super setFrame:CGRectMake(0, SCREEN_HEIGHT-kTABBAR_HEIGHT, SCREEN_WIDTH, kTABBAR_HEIGHT)];
}

- (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 *  直播按钮点击
 **/
- (void)liveBtnClick{
    if ([self.tabbardelegate respondsToSelector:@selector(tabBarDidClickLiveButton:)]){
        [self.tabbardelegate tabBarDidClickLiveButton:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 1, 设置直播按钮的位置
    self.liveBtn.centerX = self.width * 0.5;
    self.liveBtn.centerY = self.height - kTABBAR_HEIGHT + Handle(10);
    CGFloat tabbarButtonW = self.width / 3;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews){
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]){
            child.width = tabbarButtonW;
            child.x = tabbarButtonIndex * tabbarButtonW;
            // 增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 1){  // 将大图标设置为那个index
                tabbarButtonIndex ++;
            }
        }
    }
}
//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.liveBtn];
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.liveBtn pointInside:newP withEvent:event]) {
            return self.liveBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
