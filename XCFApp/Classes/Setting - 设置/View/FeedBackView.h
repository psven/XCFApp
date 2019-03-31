//
//  FeedBackView.h
//  XCFApp
//
//  Created by Joey on 2019/3/31.
//  Copyright © 2019 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackView : UIView

@property (nonatomic, copy) void (^commitBlock)();
@end

NS_ASSUME_NONNULL_END
