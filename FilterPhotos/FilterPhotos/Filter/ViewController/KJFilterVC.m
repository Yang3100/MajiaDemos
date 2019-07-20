//
//  KJFilterVC.m
//  FilterPhotos
//
//  Created by 杨科军 on 2018/11/17.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJFilterVC.h"
#import "KJWaveView.h"
#import "KJFilterTools.h"

#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]

@interface KJFilterVC ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (nonatomic,strong) UIImage *cacheImage;
@property (nonatomic,strong) NSArray *saveWaveArray;
@property (nonatomic,strong) NSMutableArray *temps;

@end

@implementation KJFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setSubview];
}

- (void)_setSubview{
    [_temps removeAllObjects];
    
    self.topImageView.layer.cornerRadius = 10;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.layer.borderWidth = 1;
    _topImageView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    
    // 保存中转图片
    _cacheImage = _topImageView.image;
    
    for (UIView *view in self.view.subviews) {
//        NSLog(@"%ld",view.tag);
        if (view.tag>=520 && view.tag<=531) {
            [self createWaveViewToSuperView:view];
        }
    }
    // 排序数组
    self.saveWaveArray = [self.temps sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        NSNumber *b1 = [NSNumber numberWithInteger:((UIView*)obj1).tag];
        NSNumber *b2 = [NSNumber numberWithInteger:((UIView*)obj2).tag];
        return [b1 compare:b2]; //升序
    }];
    
//    NSLog(@"saveWaveArray = %@",_saveWaveArray);
}

- (void)createWaveViewToSuperView:(UIView*)view{
    CGFloat h = view.frame.size.width;
    CGFloat w = view.frame.size.height;
    KJWaveView *waveView = [[KJWaveView alloc] initWithFrame:CGRectMake(0, 0, w/2, h)];
    waveView.backgroundColor = UIColorFromHEXA(0x6b98ff, 1);
    waveView.center = CGPointMake(h/2+3*2, w/2+3);
    waveView.transform = CGAffineTransformMakeRotation(M_PI/2); // 旋转90度
    waveView.tag = view.tag;
    [view addSubview:waveView];
    [self.temps addObject:waveView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, h, w)];
    slider.center = CGPointMake(w/2, h/2);
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    slider.minimumTrackTintColor = [UIColor clearColor];  // 最小值这边的背景颜色
    slider.maximumTrackTintColor = [UIColor clearColor];  // 最大值这边的背景颜色
    slider.thumbTintColor = [UIColor clearColor];         // 滑块背景颜色
    slider.value = waveView.progress;
    slider.tag = view.tag;
    slider.transform = CGAffineTransformMakeRotation(-M_PI/2); // 旋转90度
    slider.backgroundColor = [UIColor clearColor];
    slider.continuous = NO;//默认YES  如果设置为NO，则每次滑块停止移动后才触发事件
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [waveView addSubview:slider];
}

#pragma mark - 滑块滑动的响应事件
- (void)sliderChange:(UISlider*)sender{
    ((KJWaveView*)self.saveWaveArray[sender.tag-520]).progress = sender.value;
    
    [self changeImage];
}

- (void)changeImage{
    float p[12];
    for (NSInteger i=0; i<_saveWaveArray.count; i++) {
        KJWaveView *wv = _saveWaveArray[i];
        
        if (i>=9) {
            p[i] = wv.progress;
        }else{
            p[i] = 1 - wv.progress;
        }
    }
    
    KJFilterTools *manager = [KJFilterTools new];
    self.topImageView.image = [manager createImageWithImage:_cacheImage colorMatrix:p];
}

- (NSMutableArray*)temps{
    if (!_temps) {
        _temps = [NSMutableArray array];
    }
    return _temps;
}

@end
