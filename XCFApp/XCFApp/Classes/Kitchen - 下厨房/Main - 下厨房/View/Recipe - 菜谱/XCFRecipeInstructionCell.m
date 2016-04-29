//
//  XCFRecipeInstructionCell.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/7.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeInstructionCell.h"
#import "XCFRecipeInstruction.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface XCFRecipeInstructionCell ()

@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *image;

@end

@implementation XCFRecipeInstructionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _stepLabel = [[UILabel alloc] init];
        _stepLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeFirstTitle];
        [self.contentView addSubview:_stepLabel];
        [_stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(XCFRecipeCellMarginTitle);
        }];
        
        
        // 图片
        _image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stepLabel);
            make.left.equalTo(self.contentView).offset(XCFRecipeCellMarginTitle * 3);
            make.size.mas_equalTo(CGSizeMake(220, 180));
        }];
        
        
        // 用量
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:XCFRecipeCellFontSizeTitle];
        _descLabel.numberOfLines = 0;
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.image.mas_bottom).offset(XCFRecipeCellMarginTitle);
            make.left.equalTo(self.image);
            make.right.equalTo(self.contentView.mas_right).offset(-XCFRecipeCellMarginTitle);
        }];
        
        
    }
    return self;
}


- (void)setInstruction:(XCFRecipeInstruction *)instruction {
    _instruction = instruction;
    
    self.stepLabel.text = [NSString stringWithFormat:@"%zd", instruction.step + 1];
    self.descLabel.text = instruction.text;
    
    // 判断有无图片
    if (instruction.url.length) {
        self.image.hidden = NO;
        [self.image sd_setImageWithURL:[NSURL URLWithString:instruction.url]];
    } else {
        self.image.hidden = YES;
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stepLabel);
            make.left.equalTo(self.contentView).offset(XCFRecipeCellMarginTitle * 3);
            make.right.equalTo(self.contentView.mas_right).offset(-XCFRecipeCellMarginTitle);
        }];
    }
}



@end


