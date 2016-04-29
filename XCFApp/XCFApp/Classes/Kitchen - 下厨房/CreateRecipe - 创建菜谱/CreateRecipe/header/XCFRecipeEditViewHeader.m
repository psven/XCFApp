//
//  XCFRecipeEditViewHeader.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeEditViewHeader.h"
#import "XCFCreateRecipe.h"
#import <Masonry.h>

@interface XCFRecipeEditViewHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *placeholder;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic, strong) XCFAddMark *summaryMark;

@end

@implementation XCFRecipeEditViewHeader

- (void)awakeFromNib {
    
    UITapGestureRecognizer *tapGesAddPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
    [self.topImage addGestureRecognizer:tapGesAddPhoto];
    
    UITapGestureRecognizer *tapGesAddName = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTitle:)];
    [self.titleLabel addGestureRecognizer:tapGesAddName];
    
    UITapGestureRecognizer *tapGesAddSummary = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addSummary)];
    [self.descLabel addGestureRecognizer:tapGesAddSummary];
    
}

- (XCFAddMark *)summaryMark {
    if (!_summaryMark) {
        _summaryMark = [XCFAddMark summaryMarkWithTarget:self action:@selector(addSummary)];
        [self addSubview:_summaryMark];
        [_summaryMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
    }
    return _summaryMark;
}

- (void)setCreateRecipe:(XCFCreateRecipe *)createRecipe {
    _createRecipe = createRecipe;
    if (createRecipe.image) {
        self.topImage.image = createRecipe.image;
        self.placeholder.hidden = YES;
    } else {
        self.placeholder.hidden = NO;
    }
    self.titleLabel.text = createRecipe.name;
    
    if (createRecipe.desc.length) {
        self.summaryMark.hidden = YES;
        self.descLabel.hidden = NO;
        self.descLabel.text = createRecipe.desc;
    } else {
        self.summaryMark.hidden = NO;
        self.descLabel.hidden = YES;
    }
    
}


#pragma mark - 事件处理

- (void)addPhoto {
    !self.editHeaderActionBlock ? : self.editHeaderActionBlock(EditHeaderActionAddPhoto);
}

- (IBAction)editTitle:(id)sender {
    !self.editHeaderActionBlock ? : self.editHeaderActionBlock(EditHeaderActionAddName);
}

- (void)addSummary {
    !self.editHeaderActionBlock ? : self.editHeaderActionBlock(EditHeaderActionAddSummary);
}

@end
