//
//  NSAttributedString+KJSize.h
//  SenbaUsed
//
//  Created by 杨科军 on 2017/5/29.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (KJSize)
/**
 *  动态计算文字的宽高（多行）
 *  @param limitSize 限制的范围
 *
 *  @return 计算的宽高
 */
- (CGSize)kj_sizeWithLimitSize:(CGSize)limitSize;

/**
 *  动态计算文字的宽高（多行）
 *  @param limitWidth 限制宽度 ，高度不限制
 *
 *  @return 计算的宽高
 */
- (CGSize)kj_sizeWithLimitWidth:(CGFloat)limitWidth;
@end
