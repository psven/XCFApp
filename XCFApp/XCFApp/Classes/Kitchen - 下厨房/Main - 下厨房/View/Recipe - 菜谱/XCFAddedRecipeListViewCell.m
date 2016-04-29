//
//  XCFAddedRecipeListViewCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/9.
//  Copyright © 2016年 Joey. All rights reserved.
//

/**
 *  被加入的菜单cell
 */

#import "XCFAddedRecipeListViewCell.h"
#import "XCFRecipeList.h"
#import "XCFRecipe.h"
#import "XCFAuthor.h"
#import <UIImageView+WebCache.h>

@interface XCFAddedRecipeListViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UILabel *comeLabel;

@end

@implementation XCFAddedRecipeListViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = XCFGlobalBackgroundColor;
}


- (void)setAddedList:(XCFRecipeList *)addedList {
    _addedList = addedList;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:addedList.first_recipe.photo140]];
    self.listTitle.text = addedList.name;
    self.comeLabel.text = [NSString stringWithFormat:@"来自：%@", addedList.author.name];
}



@end
