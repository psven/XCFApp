//
//  XCFEditController.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef void (^doneEditBlock)(NSString *);

#import <UIKit/UIKit.h>

@interface XCFEditController : UIViewController

@property (nonatomic, copy) doneEditBlock doneEditBlock;

- (instancetype)initWithTitle:(NSString *)title
               currentContent:(NSString *)currentContent
                doneEditBlock:(doneEditBlock)block;

@end
