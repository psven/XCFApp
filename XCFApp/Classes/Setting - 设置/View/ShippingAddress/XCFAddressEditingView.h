//
//  XCFAddressEditingView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

typedef NS_ENUM(NSInteger, XCFAddressEditingContent) {
    XCFAddressEditingContentName,
    XCFAddressEditingContentPhone,
    XCFAddressEditingContentProvince,
    XCFAddressEditingContentDetailAddress
};

#import <UIKit/UIKit.h>
@class XCFAddressInfo;

@interface XCFAddressEditingView : UIView
@property (nonatomic, strong) XCFAddressInfo *addressInfo;
@property (nonatomic, copy) void (^editingBlock)(XCFAddressEditingContent, NSString *);
@property (nonatomic, copy) void (^editingLocationBlock)(NSString *);
@property (nonatomic, copy) void (^deleteBlock)();
@end
