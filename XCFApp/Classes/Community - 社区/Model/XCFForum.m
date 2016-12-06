//
//  XCFForum.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFForum.h"
#import "XCFAuthor.h"
@implementation XCFForum

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"latest_authors" : [XCFAuthor class]};
}

@end
