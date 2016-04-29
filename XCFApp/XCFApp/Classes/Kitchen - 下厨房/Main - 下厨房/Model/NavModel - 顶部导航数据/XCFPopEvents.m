//
//  XCFPopEvents.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/4.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFPopEvents.h"
#import "XCFPopEvent.h"

@implementation XCFPopEvents

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"events" : [XCFPopEvent class]};
}

@end
