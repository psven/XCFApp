//
//  XCFMealHeader.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMealHeader.h"
#import "XCFMealInfo.h"

@interface XCFMealHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation XCFMealHeader

- (void)setMealInfo:(XCFMealInfo *)mealInfo {
    _mealInfo = mealInfo;
    
    self.descLabel.text = mealInfo.desc;
    
    NSString *name = [mealInfo.name substringToIndex:2];

    if ([name isEqualToString:@"早餐"]) {
        self.image.image = [UIImage imageNamed:@"themeBigPicForBreakfast"];
    } else if ([name isEqualToString:@"午餐"]) {
        self.image.image = [UIImage imageNamed:@"themeBigPicForLaunch"];
    } else if ([name isEqualToString:@"晚餐"]) {
        self.image.image = [UIImage imageNamed:@"themeBigPicForSupper"];
    }
    
}

@end
