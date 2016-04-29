//
//  XCFCreateIngredientFooter.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateIngredientFooter.h"
#import <Masonry.h>

@interface XCFCreateIngredientFooter ()

@property (nonatomic, strong) XCFAddMark *ingredientMark;
@end

@implementation XCFCreateIngredientFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        
        UIImageView *topSeperator = [[UIImageView alloc] init];
        topSeperator.backgroundColor = RGBA(0, 0, 0, 0.1);
        [self.contentView addSubview:topSeperator];
        [topSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView);
            make.height.equalTo(@(1));
        }];
        
        _ingredientMark = [XCFAddMark ingredientMarkWithTarget:self action:@selector(addIngredient)];
        [self.contentView addSubview:_ingredientMark];
        [_ingredientMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topSeperator);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(XCFScreenWidth, 38));
        }];
        
        UIImageView *bottomSeperator = [[UIImageView alloc] init];
        bottomSeperator.backgroundColor = RGBA(0, 0, 0, 0.1);
        [self.contentView addSubview:bottomSeperator];
        [bottomSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topSeperator);
            make.right.equalTo(topSeperator);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(1));
        }];    }
    return self;
}


- (void)addIngredient {
    !self.addIngredientBlock ? : self.addIngredientBlock();
}

@end
