//
//  XCFGoodsShopCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/15.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFShop;

@interface XCFGoodsShopCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) XCFShop *shop;

@end
