//
//  KJDisplayCollectionViewCell.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJDisplayCollectionViewCell.h"

@interface KJDisplayCollectionViewCell()

@property (nonatomic,strong)UILabel    *priceLab;

@end

@implementation KJDisplayCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = Handle(4);
        self.contentView.layer.borderWidth = Handle(1);
        [self creatCollView];
        self.backgroundColor = UIColorHexFromRGB(0xf9f6f6);
    }
    
    return self;
}

- (void)setCell_tag:(NSInteger)cell_tag{
    if (cell_tag==0) {
        _priceLab.text = @"支出";
    }else{
        _priceLab.text = @"收入";
    }
}
- (void)creatCollView{
    _priceLab = InsertLabel(self.contentView, CGRectZero, NSTextAlignmentCenter, @"", SystemBoldFontSize(12), [UIColor blackColor]);
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
    }];
}

- (void)setIsCellSelect:(BOOL)isCellSelect{
    if (isCellSelect){
        self.contentView.layer.borderColor = MainColor(1).CGColor;
        _priceLab.textColor = MainColor(1);
    }else{
        self.contentView.layer.borderColor = UIColorHexFromRGB(0xf9f6f6).CGColor;
        _priceLab.textColor = [UIColor blackColor];
    }
}

@end
