//
//  XCFCreateRecipe.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateRecipe.h"
#import "XCFCreateIngredient.h"
#import "XCFCreateInstruction.h"
#import "XCFMyInfo.h"

@implementation XCFCreateRecipe

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_image       forKey:@"image"];
    [aCoder encodeObject:_name        forKey:@"name"];
    [aCoder encodeObject:_desc        forKey:@"desc"];
    [aCoder encodeObject:_ingredient  forKey:@"ingredient"];
    [aCoder encodeObject:_instruction forKey:@"instruction"];
    [aCoder encodeObject:_tips        forKey:@"tips"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.image       = [decoder decodeObjectForKey:@"image"];
        self.name        = [decoder decodeObjectForKey:@"name"];
        self.desc        = [decoder decodeObjectForKey:@"desc"];
        self.ingredient  = [decoder decodeObjectForKey:@"ingredient"];
        self.instruction = [decoder decodeObjectForKey:@"instruction"];
        self.tips        = [decoder decodeObjectForKey:@"tips"];
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"instruction" : [XCFCreateInstruction class],
             @"ingredient"  : [XCFCreateIngredient class]};
}

- (XCFAuthorDetail *)author {
    return [XCFMyInfo info];
}

- (CGFloat)headerHeight {
    CGFloat imageHeight = 200;
    CGFloat nameHeight = [self.name getSizeWithTextSize:CGSizeMake(250, MAXFLOAT) fontSize:20].height;
    
    if (self.desc.length) {
        CGFloat descHeight = [self.desc getSizeWithTextSize:CGSizeMake(280, MAXFLOAT) fontSize:14].height;
        _headerHeight = imageHeight + nameHeight + descHeight + 40;
    } else {
        _headerHeight = imageHeight + nameHeight + 70;
    }
    return _headerHeight;
}

@end
