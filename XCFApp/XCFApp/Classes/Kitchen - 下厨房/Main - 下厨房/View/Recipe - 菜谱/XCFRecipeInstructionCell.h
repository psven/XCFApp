//
//  XCFRecipeInstructionCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/7.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFRecipeInstruction;

@interface XCFRecipeInstructionCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) XCFRecipeInstruction *instruction;

@end
