//
//  XCFGoodsAttrsViewCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/16.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFGoodsAttrsViewCell : UICollectionViewCell
/** 详细属性 */
@property (nonatomic, strong) NSArray *attrsArray;
/** 隐藏图文详情界面 */
@property (nonatomic, copy) void (^viewWillDismissBlock)();

@end
