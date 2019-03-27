//
//  KJSimpleDrawCell.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJSimpleDrawCell.h"

@interface KJSimpleDrawCell ()
/// waterfall
@property (nonatomic , readwrite , strong) KJWaterfall *waterfall;
/// titleLabel
@property (nonatomic , readwrite , weak) UILabel *titleLabel;
/// imageView
@property (nonatomic , readwrite , weak) UIImageView *imageView;
@property (nonatomic , readwrite , weak) UIImageView *rightImageView;
@end


@implementation KJSimpleDrawCell
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
    self.backgroundColor = [UIColor whiteColor];
    [KJTools makeCornerRadius:2 borderColor:MainColor(0.8) layer:self.layer borderWidth:0.5];
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
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
    //    [KJTools makeCornerRadius:self.contentView.frame.size.height/4 borderColor:nil layer:imageView.layer borderWidth:0];
    self.imageView = imageView;
    
    /// 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = KJRegularFont_14;
    titleLabel.textColor = UIColor.blackColor;
    //    titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
//    UIImageView *rightImageView = [[UIImageView alloc] init];
//    rightImageView.contentMode = UIViewContentModeScaleToFill;
//    rightImageView.image = GetImage(@"Arrow");
//    self.rightImageView = rightImageView;
//    [KJTools makeRotation:rightImageView Degrees:180];
//    [self.contentView addSubview:rightImageView];
    
//    UIView *line = [UIView new];
//    line.backgroundColor = DefaultBackgroudColor;
//    [self.contentView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView);
//        make.left.mas_equalTo(self.contentView).mas_offset(0);
//        make.right.mas_equalTo(self.contentView).mas_offset(0);
//        make.height.mas_equalTo(10);
//    }];
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.width.height.mas_equalTo(self.contentView.frame.size.width-20);
    }];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.imageView);
//        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(1);
//        make.height.mas_equalTo(Handle(20));
//    }];
    
//    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.imageView);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(10);
//        make.right.mas_equalTo(self.contentView).mas_offset(-10);
//    }];
}
@end
