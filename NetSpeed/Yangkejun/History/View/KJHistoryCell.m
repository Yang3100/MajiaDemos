//
//  KJHistoryCell.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/9.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHistoryCell.h"

@interface KJHistoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Max;
@property (weak, nonatomic) IBOutlet UILabel *Min;
@property (weak, nonatomic) IBOutlet UILabel *Bandwith;

@end

@implementation KJHistoryCell

- (void)setModel:(KJHistoryModel *)model{
    self.Time.text = model.time;
    self.Name.text = model.name;
    self.Max.text = model.max;
    self.Min.text = model.min;
    self.Bandwith.text = model.bandwith;
}

@end
