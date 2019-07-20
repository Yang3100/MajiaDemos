//
//  KJCountedColorModel.m
//  色彩大淘沙
//
//  Created by 杨科军 on 2018/10/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJCountedColorModel.h"
#import "UIColor+TDAdditions.h"

@interface KJCountedColorModel()


@end

@implementation KJCountedColorModel

- (NSComparisonResult)compare:(KJCountedColorModel *)object {
    if ([object isKindOfClass:[KJCountedColorModel class]]) {
        if (self.count < object.count)
            return NSOrderedDescending;
        else if (self.count == object.count)
            return NSOrderedSame;
    }
    return NSOrderedAscending;
}

+ (NSArray*)getNotRepetitionColors:(NSArray*)sortedColors maxCount:(NSInteger)max{
    // 使用compare这个标准给sortedColors排序
    [(NSMutableArray*)sortedColors sortUsingSelector:@selector(compare:)];
    
    NSMutableArray *resultColors = [NSMutableArray array];
    for (KJCountedColorModel *model in sortedColors) {
        BOOL continueFlag = NO;
        for (UIColor *c in resultColors) {
            if (![model.color isDistinct:c]) {  // 判断颜色是否重复(相似)
                continueFlag = YES;
                break;
            }
        }
        if (continueFlag){
            continue;
        }
        if (resultColors.count <= max){
            [resultColors addObject:model.color];
        }
    }
    return resultColors;
}

@end
