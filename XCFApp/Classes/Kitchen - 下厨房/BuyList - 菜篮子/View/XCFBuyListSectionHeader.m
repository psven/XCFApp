//
//  XCFBuyListSectionHeader.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFBuyListSectionHeader.h"
#import "XCFRecipe.h"


@interface XCFBuyListSectionHeader ()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation XCFBuyListSectionHeader

- (void)awakeFromNib {
    self.scrollView.scrollEnabled = NO;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToShowDeleteButton:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.scrollView addGestureRecognizer:swipe];
}

- (void)swipeToShowDeleteButton:(UISwipeGestureRecognizer *)swipe {
    self.scrollView.scrollEnabled = YES;
    CGPoint point1 = [swipe locationInView:self];
    CGPoint point2 = [swipe locationOfTouch:1 inView:self];
    XCFLog(@"%zd %zd \n %zd %zd", point1.x, point1.y, point2.x, point2.y);
    self.scrollView.transform = CGAffineTransformMakeTranslation(-70, 0);
}

- (void)setRecipe:(XCFRecipe *)recipe {
    _recipe = recipe;
    self.nameLabel.text = recipe.name;
}



@end
