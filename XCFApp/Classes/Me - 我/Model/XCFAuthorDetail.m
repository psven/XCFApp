//
//  XCFAuthorDetail.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAuthorDetail.h"

@implementation XCFAuthorDetail

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_type                  forKey:@"type"];
    [aCoder encodeObject:_image                 forKey:@"image"];
    [aCoder encodeObject:_name                  forKey:@"name"];
    [aCoder encodeObject:_desc                  forKey:@"desc"];
    [aCoder encodeObject:_birthday              forKey:@"birthday"];
    [aCoder encodeObject:_gender                forKey:@"gender"];
    [aCoder encodeObject:_profession            forKey:@"profession"];
    [aCoder encodeObject:_hometown_location     forKey:@"hometown_location"];
    [aCoder encodeObject:_current_location      forKey:@"current_location"];
    [aCoder encodeObject:_nfollow               forKey:@"nfollow"];
    [aCoder encodeObject:_nfollowed             forKey:@"nfollowed"];
    [aCoder encodeObject:_create_time           forKey:@"create_time"];
    [aCoder encodeObject:_ndishes               forKey:@"ndishes"];
    [aCoder encodeObject:_nrecipes              forKey:@"nrecipes"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.type                = [decoder decodeIntegerForKey:@"type"];
        self.image               = [decoder decodeObjectForKey:@"image"];
        self.name                = [decoder decodeObjectForKey:@"name"];
        self.desc                = [decoder decodeObjectForKey:@"desc"];
        self.birthday            = [decoder decodeObjectForKey:@"birthday"];
        self.gender              = [decoder decodeObjectForKey:@"gender"];
        self.profession          = [decoder decodeObjectForKey:@"profession"];
        self.hometown_location   = [decoder decodeObjectForKey:@"hometown_location"];
        self.current_location    = [decoder decodeObjectForKey:@"current_location"];
        self.nfollow             = [decoder decodeObjectForKey:@"nfollow"];
        self.nfollowed           = [decoder decodeObjectForKey:@"nfollowed"];
        self.create_time         = [decoder decodeObjectForKey:@"create_time"];
        self.ndishes             = [decoder decodeObjectForKey:@"ndishes"];
        self.nrecipes            = [decoder decodeObjectForKey:@"nrecipes"];
    }
    return self;
}

- (CGFloat)descHeight {
    return [self.desc getSizeWithTextSize:CGSizeMake(XCFScreenWidth-30, MAXFLOAT) fontSize:12].height;
}

- (CGFloat)headerHeight {
    CGFloat infoHeight;
    if (self.type == XCFAuthorTypeMe) {
        infoHeight = 120;
        _headerHeight = infoHeight + 60;
    } else if (self.type == XCFAuthorTypeOther) {
        infoHeight = 150;
        _headerHeight = infoHeight;
    }
    
    if (self.hometown_location.length || self.current_location.length) _headerHeight += 40;
    
    if (self.desc.length) {
        _headerHeight += self.descHeight;
    }
    
    _headerHeight += 44;
    return _headerHeight;
}

@end
