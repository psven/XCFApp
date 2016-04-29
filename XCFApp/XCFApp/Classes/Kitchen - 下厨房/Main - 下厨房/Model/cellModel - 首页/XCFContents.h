//
//  XCFContents.h
//  XCFApp
//
//  Created by 彭世朋 on 16/4/2.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XCFImage, XCFAuthor;
@interface XCFContents : NSObject

//模板1、2、4、5、6
/** 图片内容 */
@property (nonatomic, strong) XCFImage *image;

//模板1、5
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 描述 */
@property (nonatomic, copy) NSString *desc;

//模板2
/** 大标题 */
@property (nonatomic, copy) NSString *title_1st;
/** 小标题 */
@property (nonatomic, copy) NSString *title_2nd;

//模板4
/** 标题 */
@property (nonatomic, copy) NSString *whisper;

//模板5
/** 视频地址 */
@property (nonatomic, copy) NSString *video_url;
/** 作者 */
@property (nonatomic, strong) XCFAuthor *author;
/** 做过的人数 */
@property (nonatomic, assign) NSUInteger n_cooked;
/** 未知 */
@property (nonatomic, assign) NSUInteger n_dishes;
/** 分数 */
@property (nonatomic, assign) NSUInteger score;
/** 食谱id */
@property (nonatomic, strong) NSString *recipe_id;

@end
