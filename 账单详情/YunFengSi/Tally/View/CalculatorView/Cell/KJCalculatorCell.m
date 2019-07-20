//
//  KJCalculatorCell.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJCalculatorCell.h"

@interface KJCalculatorCell()
/// titleLabel
@property (nonatomic , readwrite , weak) UILabel *titleLabel;

@end

@implementation KJCalculatorCell

- (void)setCell_tag:(NSInteger)cell_tag{
    if (cell_tag==11) {
        self.backgroundColor = MainColor(1);
        self.titleLabel.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
    }
}

- (void)configureModel:(KJCalculatorModel *)model{
    self.titleLabel.text = model.title;
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
    [KJTools makeCornerRadius:0 borderColor:MainColor(1) layer:self.layer borderWidth:0.3];
}

#pragma mark - 创建自控制器
- (void)_setupSubViews{
    /// 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.center = self.contentView.center;
    titleLabel.size = CGSizeMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
    titleLabel.font = SystemFontSize(18);
    titleLabel.textColor = UIColor.blackColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

@end
