//
//  ZJ_RulesLineView.m
//  ceshi
//
//  Created by shao_Mac on 2018/5/4.
//  Copyright © 2018年 shao_Mac. All rights reserved.
//

#import "ZJ_RulesLineView.h"
#import "ZJ_RulesLineModel.h"
#import "ZJ_RulesLineMovingView.h"

#define Line_Width 20
#define Line_LargeWidth 30
#define Line_SmallWidth 10


@interface ZJ_RulesLineView () <ValueChangeDelegate>

@property (nonatomic, strong) NSMutableArray *CMPointArr;
@property (nonatomic, strong) NSMutableArray *YCPoineArr;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) ZJ_RulesLineMovingView *moveView;
@property (nonatomic, strong) ZJ_RulesLineMovingView *moveView2;

@property (nonatomic, strong) UILabel *cmLabel;
@property (nonatomic, strong) UILabel *ycLabel;

@property (nonatomic, assign) CGFloat yc;


@end

@implementation ZJ_RulesLineView

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithRed:77/255.f green:211/255.f blue:161/255.f alpha:.4];
        _backView.userInteractionEnabled = NO;
        [self addSubview:_backView];
        
    }
    return _backView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        
        CGFloat sc_w = [[UIScreen mainScreen] bounds].size.width;
        CGFloat sc_h = [[UIScreen mainScreen] bounds].size.height;
        CGFloat sc_s;
        CGFloat ff = [[UIScreen mainScreen] nativeBounds].size.height;
        
        if (ff == 1136) {
            sc_s = 4.0;
        }else if(ff == 1334.0){
            sc_s = 4.7;
        }else if (ff== 1920){
            sc_s = 5.5;
        }else if (ff== 2436){
            sc_s = 5.8;
        }else{
            sc_s = 3.5;
        }
        
        //1 myc的像素点
        _yc = sqrt(sc_w * sc_w + sc_h * sc_h)/(sc_s*10.f);
        ZJ_RulesLineMovingView *moveView = [[ZJ_RulesLineMovingView alloc] initWithFrame:CGRectMake(0, _yc*10.f/25.4*10, sc_w, SlideHeight)];
        moveView.delegate = self;
        [self addSubview:moveView];
        _moveView = moveView;
        
        
        ZJ_RulesLineMovingView *moveView2 = [[ZJ_RulesLineMovingView alloc] initWithFrame:CGRectMake(0, _yc*10.f/25.4*20, sc_w, SlideHeight)];
        moveView2.delegate = self;
        [self addSubview:moveView2];
        _moveView2 = moveView2;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        label1.center = CGPointMake(SCREEN_WIDTH/2+50, SCREEN_HEIGHT/2);
        label1.textColor = [UIColor colorWithRed:77/255.f green:211/255.f blue:161/255.f alpha:1];;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.transform = CGAffineTransformRotate(label1.transform, M_PI_2);
        label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [self addSubview:label1];
        
        _cmLabel = label1;
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        label2.center = CGPointMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2);
        label2.textColor = [UIColor colorWithRed:77/255.f green:211/255.f blue:161/255.f alpha:1];;
        label2.textAlignment = NSTextAlignmentCenter;
        label2.transform = CGAffineTransformRotate(label2.transform, -M_PI_2);
        label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [self addSubview:label2];
        
        _ycLabel = label2;
        
        [self valueChange];
        
    }
    return self;
}

- (void)valueChange
{
    
    CGFloat y1 = _moveView.frame.origin.y;
    CGFloat y2 = _moveView2.frame.origin.y;
    
    CGFloat height = y1-y2;
    if (height < 0) {
        height = y2-y1;
    }
    
    CGFloat ycTotal = height/(_yc*10.f);
    CGFloat cmTotal = ycTotal *2.54;
    
    _ycLabel.text = [NSString stringWithFormat:@"Length: %.2f inch",ycTotal];
    _cmLabel.text = [NSString stringWithFormat:@"Length: %.2f cm",cmTotal];
    
    if (y1 > y2) {
        
        self.backView.frame = CGRectMake(0, y2+(SlideHeight/2), [[UIScreen mainScreen] bounds].size.width, height);
    }else{
        
       self.backView.frame = CGRectMake(0, y1+(SlideHeight/2), [[UIScreen mainScreen] bounds].size.width, height);
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    
    for (int i = 0; i < self.CMPointArr.count; i++) {
        ZJ_RulesLineModel *model = self.CMPointArr[i];
        CGContextMoveToPoint(context, model.fromX, model.fromY);
        CGContextAddLineToPoint(context,model.toX, model.toY);
    }
    
    for (int i = 0; i < self.YCPoineArr.count; i++) {
        ZJ_RulesLineModel *model = self.YCPoineArr[i];
        CGContextMoveToPoint(context, model.fromX, model.fromY);
        CGContextAddLineToPoint(context,model.toX, model.toY);
    }
    
    CGContextStrokePath(context);
    
}

- (NSMutableArray *)YCPoineArr
{
    if (!_YCPoineArr) {
        _YCPoineArr = [NSMutableArray array];
        
        for (int i = 0; i < 130; i++) {
            
            ZJ_RulesLineModel *model = [[ZJ_RulesLineModel alloc] init];
            model.fromX = 0;
            model.fromY = SCREEN_HEIGHT - (i * _yc);
            model.toY = SCREEN_HEIGHT - (i * _yc);
            if (i%5==0) {
                model.toX = Line_LargeWidth;
                
                if (i%10==0) {
                    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(model.toX+2, model.toY-10, 20, 20)];
                    label1.text = [NSString stringWithFormat:@"%d",i/10];
                    label1.textColor = [UIColor whiteColor];
                    label1.textAlignment = NSTextAlignmentCenter;
                    label1.transform = CGAffineTransformRotate(label1.transform, -M_PI_2);
                    label1.font = [UIFont systemFontOfSize:15];
                    [self addSubview:label1];
                }
                
            }else{
                model.toX = Line_SmallWidth;
            }
            [_YCPoineArr addObject:model];
        }
        
        
    }
    return _YCPoineArr;
}

- (NSMutableArray *)CMPointArr
{
    if (!_CMPointArr) {
        _CMPointArr = [NSMutableArray array];
        
        CGFloat sc_w = [[UIScreen mainScreen] bounds].size.width;
       
        CGFloat pmm = _yc*10.f/25.4;//mm
        
        for (int i = 0; i < 130; i++) {
            
            ZJ_RulesLineModel *model = [[ZJ_RulesLineModel alloc] init];
            model.fromX = sc_w;
            model.fromY = (i * pmm);
            model.toY = (i * pmm);
            if (i%10==0) {
                model.toX = sc_w - Line_LargeWidth;
                
                UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(model.toX-22, model.toY-10, 20, 20)];
                label1.text = [NSString stringWithFormat:@"%d",i/10];
                label1.textColor = [UIColor whiteColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.transform = CGAffineTransformRotate(label1.transform, M_PI_2);
                label1.font = [UIFont systemFontOfSize:15];
                [self addSubview:label1];
                
            }else if(i%5==0){
                model.toX = sc_w -  Line_Width;
            }else{
                model.toX = sc_w -  Line_SmallWidth;
            }
            [_CMPointArr addObject:model];
        }
    }
    return _CMPointArr;
}



@end
