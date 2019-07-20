//
//  NSNumber+BinAdd.h
//  CommonElement
//
//  Created by mac-333 on 16/6/3.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (BinAdd)
#pragma mark - NumberWithString
///=============================================================================
/// @name numberWithString
///=============================================================================

/**
 @param string  The string described an number.
 
 @return an NSNumber when parse succeed, or nil if an error occurs.
 */
+ (nullable NSNumber *)numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END