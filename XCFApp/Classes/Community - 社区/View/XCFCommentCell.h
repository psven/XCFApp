//
//  XCFCommentCell.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFTopicComment;

@interface XCFCommentCell : UITableViewCell
@property (nonatomic, strong) XCFTopicComment *comment; 
@end
