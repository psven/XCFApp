//
//  XCFEditingBirthAndGenderCell.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCFEditingBirthAndGenderCell : UITableViewCell
@property (nonatomic, copy) NSString *displayBirth;
@property (nonatomic, copy) NSString *displaySex;
@property (nonatomic, copy) void (^editingBirthBlock)(NSString *);
@property (nonatomic, copy) void (^editingSexBlock)(NSString *);
@end
