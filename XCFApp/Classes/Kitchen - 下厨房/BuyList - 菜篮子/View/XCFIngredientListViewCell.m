//
//  XCFIngredientListViewCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/25.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFIngredientListViewCell.h"

@interface XCFIngredientListViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;

@end

@implementation XCFIngredientListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name {
    _name = name;
    self.recipeNameLabel.text = name;
}

@end
