//
//  KJWaterfallCell.m
//  MHDevelopExample
//
//  Created by lx on 2018/6/11.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJWaterfallCell.h"

@interface KJWaterfallCell ()
/// waterfall
@property (nonatomic , readwrite , strong) KJWaterfall *waterfall;
/// titleLabel
@property (nonatomic , readwrite , weak) UILabel *titleLabel;
/// imageView
@property (nonatomic , readwrite , weak) UIImageView *imageView;
@property (nonatomic , readwrite , weak) UIImageView *rightImageView;
@end

@implementation KJWaterfallCell
- (void)configureModel:(KJWaterfall *)waterfall{
    self.waterfall = waterfall;
    
    self.titleLabel.text = waterfall.title;
    self.imageView.image = GetImage(waterfall.imageUrl);
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
    self.backgroundColor = MainColor(0.5);
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
//    UIView *vie = [UIView new];
//    vie.backgroundColor = DefaultBackgroudColor;
//    [self.contentView addSubview:vie];
//    [vie mas_makeConstraints:^(MASConstraintMaker *make) {
//
//    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:imageView];
//    [KJTools makeCornerRadius:self.contentView.frame.size.height/4 borderColor:nil layer:imageView.layer borderWidth:0];
    self.imageView = imageView;
    
    /// 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = SystemFontSize(14);
    titleLabel.textColor = UIColor.whiteColor;
//    titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.contentMode = UIViewContentModeScaleToFill;
    rightImageView.image = GetImage(@"home_white_goback");
    self.rightImageView = rightImageView;
    [KJTools makeRotation:rightImageView Degrees:180];
    [self.contentView addSubview:rightImageView];
    
    UIView *line = [UIView new];
    line.backgroundColor = MainColor(1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(0);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView).mas_offset(Handle(-0.5));
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(self.contentView.frame.size.height/3);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView);
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(15);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageView);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(10);
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
    }];
}
@end
