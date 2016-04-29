//
//  XCFMyInfo.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMyInfo.h"
#import "XCFAuthorDetail.h"

@implementation XCFMyInfo

static XCFAuthorDetail *_myInfo;
static NSString *const kMyInfo = @"myInfo";

+ (XCFAuthorDetail *)info {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kMyInfo];
    _myInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!_myInfo) _myInfo = [[XCFAuthorDetail alloc] init];
    // 测试
    _myInfo.type        = XCFAuthorTypeMe;
    _myInfo.nfollow     = @"1";
    _myInfo.nfollowed   = @"99999";
    _myInfo.create_time = @"1970-01-01 13:10:10";
    _myInfo.ndishes     = @"520";
    _myInfo.nrecipes    = @"1314";
    return _myInfo;
}

+ (void)updateInfoWithNewInfo:(XCFAuthorDetail *)info {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kMyInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

@end
