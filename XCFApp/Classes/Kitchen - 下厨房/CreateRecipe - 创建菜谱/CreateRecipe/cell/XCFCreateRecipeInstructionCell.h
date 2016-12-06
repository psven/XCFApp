//
//  XCFCreateRecipeInstructionCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFCreateInstruction;

@interface XCFCreateRecipeInstructionCell : UITableViewCell

@property (nonatomic, strong) XCFCreateInstruction *createInstruction;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) void (^editTextBlock)();
@property (nonatomic, copy) void (^addPhotoBlock)();

@end
