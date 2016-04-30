//
//  XCFRecipeCreateController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFRecipeCreateController.h"
#import "XCFCreateRecipeController.h"
#import "XCFDraftBoxViewController.h"
#import "XCFCreateRecipe.h"
#import "XCFRecipeDraftTool.h"

#import <Masonry.h>

@interface XCFRecipeCreateController () <UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation XCFRecipeCreateController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupHeaderView];
    [self setupDraftBox];
}


#pragma mark - 属性

- (void)setupBasic {
    self.title = @"创建菜谱";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"下一步"
                                                                              target:self
                                                                              action:@selector(nextStep)];
}

- (void)setupHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 250)];
    _textField = [[UITextField alloc] init];
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.placeholder = @"例如：清炒小白菜（简约版）";
    [header addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header).offset(100);
        make.left.equalTo(header).offset(30);
        make.size.mas_equalTo(CGSizeMake(XCFScreenWidth-60, 40));
    }];

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = RGB(25, 22, 20);
    label.text = @"创建菜谱的人是厨房里的天使";
    [header addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header);
        make.top.equalTo(self.textField.mas_bottom).offset(50);
    }];

    self.tableView.tableHeaderView = header;
}

- (void)setupDraftBox {
    UIImageView *seperator = [[UIImageView alloc] init];
    seperator.backgroundColor = RGBA(0, 0, 0, 0.1);
    [self.view addSubview:seperator];
    [seperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
        make.height.equalTo(@(1));
    }];
    
    UIButton *draftBox = [[UIButton alloc] init];
    draftBox.backgroundColor = XCFGlobalBackgroundColor;
    draftBox.titleLabel.font = [UIFont systemFontOfSize:14];
    [draftBox setTitleColor:XCFThemeColor forState:UIControlStateNormal];
    [draftBox setTitle:@"草稿箱" forState:UIControlStateNormal];
    [self.view addSubview:draftBox];
    [draftBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seperator.mas_bottom);
        make.centerX.equalTo(seperator);
        make.size.mas_equalTo(CGSizeMake(60, 43));
    }];
    [draftBox addTarget:self action:@selector(goToDraftBox) forControlEvents:UIControlEventTouchUpInside];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


#pragma mark - 事件处理

- (void)nextStep {
    if (self.textField.text.length) {
        XCFCreateRecipe *createRecipe = [[XCFCreateRecipe alloc] init];
        createRecipe.name = self.textField.text;
        XCFCreateRecipeController *vc = [[XCFCreateRecipeController alloc] initWithStyle:UITableViewStyleGrouped];
        vc.createRecipe = createRecipe;
        vc.draftIndex = [XCFRecipeDraftTool totalRecipeDrafts].count;
        [XCFRecipeDraftTool addRecipeDraft:createRecipe];
        [self.navigationController pushViewController:vc animated:YES];
        self.textField.text = @"";
    } else {
        [UILabel showStats:@"请输入菜谱名称" atView:self.view];
    }
}

- (void)goToDraftBox {
    [self.navigationController pushViewController:[[XCFDraftBoxViewController alloc]
                                                   initWithStyle:UITableViewStylePlain] animated:YES];
}


#pragma mark - 关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
