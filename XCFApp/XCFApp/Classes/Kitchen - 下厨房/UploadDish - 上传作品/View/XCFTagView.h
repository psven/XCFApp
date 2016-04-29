//
//  XCFTagView.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef void (^deleteTagBlock)();

#import <UIKit/UIKit.h>

@interface XCFTagView : UIView

@property (nonatomic, copy) deleteTagBlock callBack;

+ (instancetype)tagViewWithString:(NSString *)string deleteTagBlock:(deleteTagBlock)callBack;

@end
