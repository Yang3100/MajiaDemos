//
//  KJShowcaseCell.m
//  涂鸦填填乐
//
//  Created by 杨科军 on 2018/10/27.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJShowcaseCell.h"

@interface KJShowcaseCell ()

@property (nonatomic , readwrite , weak) UIImageView *imageView;
@property (nonatomic , readwrite , weak) UIImageView *xiangkuangImageView;

@end


@implementation KJShowcaseCell
- (void)configureModel:(KJWaterfall *)waterfall Index:(NSInteger)index{
    // 返回图片所在的沙盒路径
    NSString *header_path = [KJTools getImagePathWithName:waterfall.imageUrl];
    UIImage *header_image = [UIImage imageWithContentsOfFile:header_path] != nil ? [UIImage imageWithContentsOfFile:header_path] : GetImage(@"LOGOstore_1024pt");
    
    self.imageView.image = header_image;
    
    NSString *name;
    if (index==0) {
        name = @"xiangkuang3";
    }else{
        name = [NSString stringWithFormat:@"xiangkuang%d",[KJTools getRandomNumber:1 to:3]];
    }
    self.xiangkuangImageView.image = GetImage(name);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
        [self _makeSubViewsConstraints];
    }
    return self;
}

#pragma mark - 事件处理Or辅助方法

#pragma mark - Private Method
- (void)_setup{
    self.theme_backgroundColor = @"block_table_bg";
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.frame.size.width-50);
        make.height.mas_equalTo(self.contentView.frame.size.height-40);
    }];
    
    UIImageView *xiangkuangImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    xiangkuangImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:xiangkuangImageView];
    self.xiangkuangImageView = xiangkuangImageView;
}

@end
