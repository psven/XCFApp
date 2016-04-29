//
//  XCFDraftRecipeCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/19.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFDraftRecipeCell.h"
#import "XCFCreateRecipe.h"
#import "XCFAuthorDetail.h"

@interface XCFDraftRecipeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorIcon;
@property (weak, nonatomic) IBOutlet UILabel *authorName;

@end

@implementation XCFDraftRecipeCell


- (void)setRecipeDraft:(XCFCreateRecipe *)recipeDraft {
    _recipeDraft = recipeDraft;
    
    if (recipeDraft.image) {
        self.photoView.image = recipeDraft.image;
    } else {
        self.photoView.image = [UIImage imageNamed:@"handleButtonBackgroundSelected"];
    }
    self.authorIcon.image = [recipeDraft.author.image circleImage];
    self.authorName.text = recipeDraft.author.name;
    self.titleLabel.text = recipeDraft.name;
}

@end
