//
//  XCFRecipeEditViewHeader.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSInteger, EditHeaderAction) {
    EditHeaderActionAddPhoto,
    EditHeaderActionAddName,
    EditHeaderActionAddSummary
};

#import <UIKit/UIKit.h>
@class XCFCreateRecipe;

@interface XCFRecipeEditViewHeader : UIView

@property (nonatomic, strong) XCFCreateRecipe *createRecipe;

@property (nonatomic, copy) void (^editHeaderActionBlock)(EditHeaderAction action);

@end
