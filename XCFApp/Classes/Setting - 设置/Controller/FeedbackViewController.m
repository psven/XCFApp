//
//  FeedbackViewController.m
//  XCFApp
//
//  Created by Joey on 2019/3/31.
//  Copyright © 2019 Joey. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedBackView.h"
#import "XCFAddressEditingView.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    FeedBackView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFAddressEditingView class])
                                   owner:nil options:nil] lastObject];
    view.commitBlock = ^{
        
        [UILabel showStats:@"您的意见已经提交，我们将尽快给您回复！" atView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    };
    view.frame = self.view.bounds;
    [self.view addSubview:view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
