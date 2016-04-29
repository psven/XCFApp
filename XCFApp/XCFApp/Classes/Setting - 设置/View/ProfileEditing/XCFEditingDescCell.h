//
//  XCFEditingDescCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFEditingDescCell : UITableViewCell
@property (nonatomic, copy) NSString *displayDesc;
@property (nonatomic, copy) void (^editingDescBlock)(NSString *);
@end
