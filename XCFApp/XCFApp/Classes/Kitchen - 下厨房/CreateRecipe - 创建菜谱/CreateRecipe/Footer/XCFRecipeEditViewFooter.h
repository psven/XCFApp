//
//  XCFRecipeEditViewFooter.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/18.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSInteger, EditFooterAction) {
    EditFooterActionSave,
    EditFooterActionPublish,
    EditFooterActionDelete
};

#import <UIKit/UIKit.h>

@interface XCFRecipeEditViewFooter : UIView

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) void (^editFooterActionBlock)(EditFooterAction action);

@end
