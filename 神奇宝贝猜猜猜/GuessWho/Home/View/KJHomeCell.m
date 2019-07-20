//
//  KJHomeCell.m
//  GuessWho
//
//  Created by 杨科军 on 2018/11/18.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHomeCell.h"

@interface KJHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *kj_imageView;

@end

@implementation KJHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setName:(NSString *)name{
    self.kj_imageView.image = [UIImage imageNamed:name];
}

@end
