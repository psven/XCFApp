//
//  XCFEditingLocationCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFEditingLocationCell : UITableViewCell
@property (nonatomic, copy) NSString *displayLocation;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) void (^cancelEditingBlock)(NSString *);
@property (nonatomic, copy) void (^editingLocationBlock)(NSString *);

@end
