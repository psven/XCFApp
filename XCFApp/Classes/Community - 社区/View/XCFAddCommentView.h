//
//  XCFAddCommentView.h
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XCFAuthor;

typedef void (^EditingTextBlock)(NSString *);
typedef void (^SendCmtBlock)(NSString *, NSArray *);


@interface XCFAddCommentView : UIView

@property (nonatomic, strong) XCFAuthor *author;                            // 所@的用户
@property (nonatomic, copy) EditingTextBlock editingTextBlock;              // 编辑文字回调
@property (nonatomic, copy) SendCmtBlock sendCmtBlock;                      // 发送评论回调
@property (nonatomic, copy) void (^atUserBlock)(NSString *);                // 显示@用户tableView回调

+ (instancetype)addCommentViewWithEditingTextBlock:(EditingTextBlock)editingTextBlock
                                      sendCmtBlock:(SendCmtBlock)sendCmtBlock;


@end
