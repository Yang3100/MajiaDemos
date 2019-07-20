//
//  KJTypeViewCell.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTypeViewCell.h"

@interface KJTypeViewCell()

@property (nonatomic,strong)UILabel    *priceLab;

@end

@implementation KJTypeViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = self.frame.size.width/2;
//        self.contentView.layer.borderWidth = Handle(1);
        [self creatCollView];
    }
    
    return self;
}

- (void)setName:(NSString *)name{
    self.priceLab.text = name;
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
//        self.contentView.layer.borderColor = MainColor(1).CGColor;
        self.contentView.backgroundColor = MainColor(1);
        _priceLab.textColor = [UIColor whiteColor];
    }else{
//        self.contentView.layer.borderColor = UIColorHexFromRGB(0xf9f6f6).CGColor;
        _priceLab.textColor = [UIColor blackColor];
        self.contentView.backgroundColor = MainColor(0.1);
    }
}

@end
