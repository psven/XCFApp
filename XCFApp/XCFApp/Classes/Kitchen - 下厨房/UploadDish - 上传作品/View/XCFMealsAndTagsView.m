//
//  XCFMealsAndTagsView.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFMealsAndTagsView.h"
#import "XCFTagView.h"
#import <Masonry.h>

@interface XCFMealsAndTagsView ()
@property (weak, nonatomic) IBOutlet UIButton *breakfast;
@property (weak, nonatomic) IBOutlet UIButton *lunch;
@property (weak, nonatomic) IBOutlet UIButton *supper;
@property (weak, nonatomic) IBOutlet UIButton *addTagButton;
@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsViewHeightCon;

@end

@implementation XCFMealsAndTagsView

- (void)awakeFromNib {
    [self.breakfast addTarget:self
                       action:@selector(selectedBreakfast:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.lunch addTarget:self
                   action:@selector(selectedLunch:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.supper addTarget:self
                    action:@selector(selectedSupper:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.addTagButton addTarget:self
                          action:@selector(addTag)
                forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 点击事件
- (void)selectedBreakfast:(UIButton *)sender {
    sender.selected = YES;
    self.lunch.selected = NO;
    self.supper.selected = NO;
    !self.selectedMealBlock ? : self.selectedMealBlock(sender.titleLabel.text);
}

- (void)selectedLunch:(UIButton *)sender {
    sender.selected = YES;
    self.breakfast.selected = NO;
    self.supper.selected = NO;
    !self.selectedMealBlock ? : self.selectedMealBlock(sender.titleLabel.text);
}

- (void)selectedSupper:(UIButton *)sender {
    sender.selected = YES;
    self.breakfast.selected = NO;
    self.lunch.selected = NO;
    !self.selectedMealBlock ? : self.selectedMealBlock(sender.titleLabel.text);
}

- (void)addTag {
    !self.addTagBlock ? : self.addTagBlock();
}

#pragma mark - 构造方法
- (void)setTagsArray:(NSArray *)tagsArray {
    _tagsArray = tagsArray;
    CGFloat currentX = 15;
    CGFloat currentY = 8;
    
    // 每次进来都清空已存在的view
    for (UIView *subview in self.tagsView.subviews) {
        [subview removeFromSuperview];
    }
    
    if (tagsArray.count) {
        for (NSInteger index=0; index<tagsArray.count; index++) {
            NSString *tagString = tagsArray[index];
            CGFloat textWidth = [tagString getSizeWithTextSize:CGSizeMake(MAXFLOAT, 30) fontSize:14].width;
            CGFloat displayWidth = textWidth + 55;
            
            if ((currentX+displayWidth-15) > XCFScreenWidth) { // 如果当前x+标签宽度大于屏幕高度，就转行
                currentX = 15;
                if (index > 0) currentY += 35;
                if (displayWidth >= XCFScreenWidth) displayWidth = XCFScreenWidth; // 如果单个标签宽度大于屏幕宽度
            }
            
            WeakSelf;
            XCFTagView *tagView = [XCFTagView tagViewWithString:tagsArray[index] deleteTagBlock:^{
                !weakSelf.deleteTagBlock ? : weakSelf.deleteTagBlock(index);
            }];
            [self.tagsView addSubview:tagView];
            [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.tagsView).offset(currentX);
                make.top.equalTo(self.tagsView).offset(currentY);
                make.size.mas_equalTo(CGSizeMake(displayWidth, 30));
            }];
            
            currentX += displayWidth+5;
        }
        self.tagsViewHeightCon.constant = currentY + 38;
    } else {
        self.tagsViewHeightCon.constant = 0;
    }
    
}


@end
