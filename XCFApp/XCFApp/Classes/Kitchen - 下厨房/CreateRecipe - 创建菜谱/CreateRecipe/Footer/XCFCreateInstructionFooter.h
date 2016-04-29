//
//  XCFCreateInstructionFooter.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSInteger, tableViewAdjustStyle) {
    tableViewAdjustStyleNone,
    tableViewAdjustStyleAdjusting
};

#import <UIKit/UIKit.h>

@interface XCFCreateInstructionFooter : UITableViewHeaderFooterView

@property (nonatomic, copy) void (^addInstructionBlock)();
@property (nonatomic, copy) void (^adjustBlock)();

@end
