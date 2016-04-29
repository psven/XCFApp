//
//  XCFTopicComment.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTopicComment.h"
#import "XCFAuthor.h"

@implementation XCFTopicComment

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_at_users      forKey:@"at_users"];
    [aCoder encodeObject:_author        forKey:@"author"];
    [aCoder encodeObject:_txt           forKey:@"txt"];
    [aCoder encodeObject:_create_time   forKey:@"create_time"];
    [aCoder encodeFloat:_cellHeight     forKey:@"cellHeight"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.at_users       = [decoder decodeObjectForKey:@"at_users"];
        self.author         = [decoder decodeObjectForKey:@"author"];
        self.txt            = [decoder decodeObjectForKey:@"txt"];
        self.create_time    = [decoder decodeObjectForKey:@"create_time"];
        self.cellHeight     = [decoder decodeFloatForKey:@"cellHeight"];
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"at_users" : [XCFAuthor class]};
}

- (CGFloat)cellHeight {
    CGFloat txtHeight = [self.txt getSizeWithTextSize:CGSizeMake(XCFScreenWidth-80, MAXFLOAT) fontSize:15].height;
    _cellHeight = txtHeight + 50;
    return  _cellHeight;
}

+ (instancetype)commentWithContent:(NSString *)content
                           atUsers:(NSArray *)users
                          byAuthor:(XCFAuthor *)author {
    XCFTopicComment *cmt = [[XCFTopicComment alloc] init];
    cmt.txt = content;
    cmt.at_users = users;
    cmt.author = author;
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    cmt.create_time = [fmt stringFromDate:date];
    return cmt;
}

@end
