//
//  XCFUploadDataTool.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFUploadDataTool.h"

@implementation XCFUploadDataTool

//- (CGFloat)tagsViewHeight {
//
//    CGFloat totalWidth = 0;
//    NSUInteger currentLine = 0;
//    for (NSString *tagString in self.tagsArray) {
//        CGFloat textWidth = [tagString getSizeWithTextSize:CGSizeMake(MAXFLOAT, 30) fontSize:14].width;
//        CGFloat displayWidth = textWidth + 55;
//        
//        totalWidth += displayWidth+5;
//        if (totalWidth > XCFScreenWidth) {
//            totalWidth = 0;
//            currentLine++;
//        }
//    }
//    
//    CGFloat currentX = 15;
//    CGFloat currentY = 8;
//    NSMutableArray *frameArray = [NSMutableArray array];
//    for (NSInteger index=0; index<self.tagsArray.count; index++) {
//        NSString *tagString = self.tagsArray[index];
//        CGFloat textWidth = [tagString getSizeWithTextSize:CGSizeMake(MAXFLOAT, 30) fontSize:14].width;
//        CGFloat displayWidth = textWidth + 55;
//        
//        if ((currentX+displayWidth-15) > XCFScreenWidth) { // 如果当前x+标签宽度大于屏幕高度，就转行
//            currentX = 15;
//            currentY += 35;
//            if (displayWidth >= XCFScreenWidth) displayWidth = XCFScreenWidth - 55; // 如果单个标签宽度大于屏幕宽度
//        } else {
//            if (index > 0) currentX += displayWidth+5; // 如果不大于，就叠加
//        }
//        NSDictionary *frameDict = @{@"x"     : @(currentX),
//                                    @"y"     : @(currentY),
//                                    @"width" : @(displayWidth)};
//        [frameArray addObject:frameDict];
//    }
//    
//}

@end
