//
//  XCFCreateRecipeInstructionCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateRecipeInstructionCell.h"
#import "XCFCreateInstruction.h"
#import <Masonry.h>

@interface XCFCreateRecipeInstructionCell ()

@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIImageView *placeholder;
@property (nonatomic, strong) XCFAddMark *instructionMark;

@end


@implementation XCFCreateRecipeInstructionCell

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textColor = XCFThemeColor;
        _descLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addInstruction)];
        [_descLabel addGestureRecognizer:tap];
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.image.mas_bottom).offset(15);
            make.left.equalTo(self.image);
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }
    return _descLabel;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = XCFGlobalBackgroundColor;
        self.backgroundColor = XCFGlobalBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _stepLabel = [[UILabel alloc] init];
        _stepLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_stepLabel];
        [_stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
        }];
    
        // 图片
        _image = [[UIImageView alloc] init];
        _image.contentMode = UIViewContentModeScaleToFill;
        _image.backgroundColor = XCFDishViewBackgroundColor;
        _image.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
        [_image addGestureRecognizer:tap];
        [self.contentView addSubview:_image];
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stepLabel);
            make.left.equalTo(self.contentView).offset(45);
            make.size.mas_equalTo(CGSizeMake(140, 100));
        }];
        
        _placeholder = [[UIImageView alloc] init];
        _placeholder.image = [UIImage imageNamed:@"createRecipeCamera"];
        [self.contentView addSubview:_placeholder];
        [_placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.image);
            make.left.equalTo(self.contentView).offset(90);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        _instructionMark = [XCFAddMark instructionMarkWithTarget:self action:@selector(addInstruction)];
        [self.contentView addSubview:_instructionMark];
        [_instructionMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.image);
            make.top.equalTo(self.image.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 30));
        }];
        
    }
    return self;
}

- (void)setCreateInstruction:(XCFCreateInstruction *)createInstruction {
    _createInstruction = createInstruction;
    
    if (createInstruction.image) {
        self.image.image = createInstruction.image;
        self.placeholder.hidden = YES;
    } else {
        self.image.image = [UIImage imageNamed:@"handleButtonBackgroundSelected"];
        self.placeholder.hidden = NO;
    }
    
    if (createInstruction.text.length) {
        self.instructionMark.hidden = YES;
        self.descLabel.hidden = NO;
        self.descLabel.text = createInstruction.text;
    } else {
        self.instructionMark.hidden = NO;
        self.descLabel.hidden = YES;
    }
}

- (void)setIndex:(NSInteger)index {
    self.stepLabel.text = [NSString stringWithFormat:@"%zd", index+1];
    self.instructionMark.title = [NSString stringWithFormat:@"添加步骤%zd", index+1];
}


- (void)addInstruction {
    !self.editTextBlock ? : self.editTextBlock();
}

- (void)addPhoto {
    !self.addPhotoBlock ? : self.addPhotoBlock();
}

@end
