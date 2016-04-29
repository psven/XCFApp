//
//  XCFEditingTextCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFEditingTextCell : UITableViewCell
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) void (^editingTextBlock)(NSString *);
@end
