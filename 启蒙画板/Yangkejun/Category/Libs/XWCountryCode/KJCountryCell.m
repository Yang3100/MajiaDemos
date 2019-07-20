//
//  KJCountryCell.m
//  HawkeyeLive
//
//  Created by 杨科军 on 2018/6/5.
//  Copyright © 2018年 HN. All rights reserved.
//

#import "KJCountryCell.h"

@interface KJCountryCell()

@property(nonatomic,strong) UILabel *kj_label;

@end

@implementation KJCountryCell

-  (void)configSubViews{
    [self addSubview:self.kj_label];
    [self.kj_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(Handle(20));
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];
}

- (UILabel*)kj_label{
    if (!_kj_label) {
        _kj_label = InsertLabel(nil, CGRectZero, NSTextAlignmentLeft, @"", [UIFont systemFontOfSize:15], MainColor(1));
    }
    return _kj_label;
}

- (void)setListModel:(KJConturyModel *)listModel{
    _listModel = listModel;
    if ([_listModel.currentLanguage isEqualToString:Zh]) {
        self.kj_label.text = listModel.AnContury;
    }else{
        self.kj_label.text = listModel.EnContury;
    }
}

@end
