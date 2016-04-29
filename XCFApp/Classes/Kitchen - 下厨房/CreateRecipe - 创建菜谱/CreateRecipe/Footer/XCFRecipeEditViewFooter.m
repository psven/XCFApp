//
//  XCFRecipeEditViewFooter.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeEditViewFooter.h"

@interface XCFRecipeEditViewFooter ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation XCFRecipeEditViewFooter

- (void)setTime:(NSString *)time {
    self.timeLabel.text = time;
}

- (IBAction)saveRecipe:(id)sender {
    !self.editFooterActionBlock ? : self.editFooterActionBlock(EditFooterActionSave);
}

- (IBAction)publish:(id)sender {
    !self.editFooterActionBlock ? : self.editFooterActionBlock(EditFooterActionPublish);
}

- (IBAction)delete:(id)sender {
    !self.editFooterActionBlock ? : self.editFooterActionBlock(EditFooterActionDelete);
}

@end
