//
//  NSDate+Extension.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/28.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

@end
