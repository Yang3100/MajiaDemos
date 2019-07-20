//
//  KJBaseTableViewCell.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/24.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseTableViewCell.h"
static NSString *cellID = nil;
@implementation KJBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *classStr = NSStringFromClass(self);
    cellID = [NSString stringWithFormat:@"%@ID",classStr];
    UITableViewCell *baseCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
//    DLog(@"CellId:=====>>>>%@",cellID);
    if (baseCell == nil){
        baseCell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    /**< Incompatible pointer types returning */
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return baseCell;
#pragma clang diagnostic pop
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
}

@end
