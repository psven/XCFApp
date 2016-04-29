//
//  XCFMealDishCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/22.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMealDishCell.h"
#import "XCFDish.h"
#import "XCFAuthor.h"
#import <UIImageView+WebCache.h>


@interface XCFMealDishCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *diggButton;
@property (weak, nonatomic) IBOutlet UILabel *diggCountLabel;
@end

@implementation XCFMealDishCell


- (void)setDish:(XCFDish *)dish {
    _dish = dish;
    NSString *displayName;
    if (dish.author.current_location.length) {
        NSString *currentLoc = [NSString stringWithFormat:@"(%@)", [dish.author.current_location substringToIndex:2]];
        displayName = [NSString stringWithFormat:@"%@ %@", dish.author.name, currentLoc];
    } else {
        displayName = dish.author.name;
    }
    [self.nameLabel setAttributeTextWithString:displayName range:NSMakeRange(0, dish.author.name.length)];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dish.thumbnail]];
    self.descLabel.text = dish.desc;
    if (dish.digged_by_me) self.diggButton.selected = dish.digged_by_me;
    self.diggCountLabel.text = [NSString stringWithFormat:@"%zd", [dish.ndiggs integerValue]];
    
}
@end
