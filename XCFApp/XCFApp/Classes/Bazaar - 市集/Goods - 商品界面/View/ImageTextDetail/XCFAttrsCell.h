//
//  XCFAttrsCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFGoodsAttrs;

@interface XCFAttrsCell : UITableViewCell

/** 模型数据 */
@property (nonatomic, strong) XCFGoodsAttrs *attrs;

@end
