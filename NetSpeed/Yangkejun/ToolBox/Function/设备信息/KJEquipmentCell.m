//
//  KJEquipmentCell.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJEquipmentCell.h"

@interface KJEquipmentCell ()
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *subName;

@end

@implementation KJEquipmentCell

- (void)setModel:(KJEquipmentModel *)model{
    self.Name.text = model.name;
    self.subName.text = model.sub_name;
}

@end
