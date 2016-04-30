//
//  XCFTopicDetailController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/27.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFTopicDetailController.h"
#import "XCFTopicCell.h"
#import "XCFCommentCell.h"
#import "XCFAddCommentView.h"

#import "XCFTopic.h"
#import "XCFTopicComment.h"
#import "XCFCommentTool.h"
#import "XCFAuthor.h"

#import <UIImageView+WebCache.h>

@interface XCFTopicDetailController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *cmtTableView;
@property (nonatomic, strong) UITableView *atUsersTableView; // 编辑框输入@时显示的view
@property (nonatomic, strong) NSMutableArray *cmtArray;      // 评论数组
@property (nonatomic, strong) NSMutableArray *atUserArray;   // 能@的用户数组
@property (nonatomic, strong) XCFAddCommentView *addCmtView; // 底部编辑栏
@property (nonatomic, assign) CGFloat keyboardHeight;        // 记录键盘高度
@end

@implementation XCFTopicDetailController

static NSString *const cmtReuseIdentifier = @"commentCell";
static NSString *const atUserReuseIdentifier = @"atUserCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题";
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"reportIcon"
                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)
                                                                                  target:self
                                                                                  action:@selector(report)];
    [self setupCmtTableView];
    [self setupHeader];
    [self setupAtUsersTableView];
    [self setupAddCmtView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}


#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (tableView == self.cmtTableView) {
        count = self.cmtArray.count;
    }
    else if (tableView == self.atUsersTableView) {
        count = self.atUserArray.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.cmtTableView) { // 评价界面
        XCFCommentCell *cmtCell = [tableView dequeueReusableCellWithIdentifier:cmtReuseIdentifier];
        cmtCell.comment = self.cmtArray[indexPath.row];
        cell = cmtCell;
    } else if (tableView == self.atUsersTableView) { // @用户界面
        cell = [tableView dequeueReusableCellWithIdentifier:atUserReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = XCFGlobalBackgroundColor;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        XCFAuthor *author = self.atUserArray[indexPath.row];
        [cell.imageView setHeaderWithURL:[NSURL URLWithString:author.photo]];
        cell.textLabel.text = author.name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.cmtTableView) {
        XCFTopicComment *cmt = self.cmtArray[indexPath.row];
        self.addCmtView.author = cmt.author;
    } else if (tableView == self.atUsersTableView) {
        self.addCmtView.author = self.atUserArray[indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44;
    if (tableView == self.cmtTableView) {
        height = [self.cmtArray[indexPath.row] cellHeight];
    }
    return height;
}


#pragma mark - 属性

- (void)setupCmtTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = XCFGlobalBackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFCommentCell class]) bundle:nil]
    forCellReuseIdentifier:cmtReuseIdentifier];
    self.cmtTableView = tableView;
}

- (void)setupHeader {
    XCFTopicCell *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFTopicCell class])
                                                          owner:self options:nil] lastObject];
    header.contentView.backgroundColor = [UIColor whiteColor];
    header.frame = CGRectMake(0, 0, XCFScreenWidth, self.topic.cellHeight);
    header.topic = self.topic;
    self.cmtTableView.tableHeaderView = header;
}

- (void)setupAtUsersTableView {
    _atUsersTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _atUsersTableView.backgroundColor = XCFGlobalBackgroundColor;
    _atUsersTableView.dataSource = self;
    _atUsersTableView.delegate = self;
    _atUsersTableView.hidden = YES;
    _atUsersTableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
    [self.view addSubview:_atUsersTableView];
    [_atUsersTableView registerClass:[UITableViewCell class]
              forCellReuseIdentifier:atUserReuseIdentifier];
}

- (void)setupAddCmtView {
    WeakSelf;
    XCFAddCommentView *addCmtView = [XCFAddCommentView addCommentViewWithEditingTextBlock:^(NSString *comment) {
         // 根据textView内容动态改变Y、height，如果是自动布局的话，直接在控件内修改约束就可以了
//        if (comment.length) {
            CGFloat height = [comment getSizeWithTextSize:CGSizeMake(XCFScreenWidth-115, MAXFLOAT) fontSize:14].height;
            CGFloat displayHeight = height + 30;
        
            weakSelf.addCmtView.frame = CGRectMake(0, XCFScreenHeight-self.keyboardHeight-displayHeight, XCFScreenWidth, displayHeight);
//        }
        
    } sendCmtBlock:^(NSString *comment, NSArray *atUsers) { // 发送评论回调
        // 恢复显示评价tableView
        self.atUsersTableView.hidden = YES;
        self.cmtTableView.hidden = NO;
        // 新建一个评论数据
        if (comment.length) { // 如果有内容才发表
            [UILabel showStats:@"发表成功！" atView:weakSelf.view];
            XCFTopicComment *newCmt = [XCFTopicComment commentWithContent:comment
                                                                  atUsers:atUsers
                                                                 byAuthor:[XCFAuthor me]];
            
            // 添加评论到本地数据（模拟效果）
            [XCFCommentTool addComment:newCmt];
            [weakSelf.view endEditing:YES];
            [weakSelf.cmtTableView reloadData];
            // 滚动到最下面
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:weakSelf.cmtArray.count-1 inSection:0];
            [weakSelf.cmtTableView scrollToRowAtIndexPath:indexPath
                                         atScrollPosition:UITableViewScrollPositionBottom
                                                 animated:YES];
        } else {
            [UILabel showStats:@"请输入评论！" atView:weakSelf.view];
        }
    }];
    
    // 判断是否有字符“@”， 有就显示用户列表
    addCmtView.atUserBlock = ^(NSString *lastString) {
        if ([lastString isEqualToString:@"@"]) {
            weakSelf.atUsersTableView.hidden = NO;
        } else {
            weakSelf.atUsersTableView.hidden = YES;
        }
    };
    
    addCmtView.frame = CGRectMake(0, XCFScreenHeight-44, XCFScreenWidth, 44);
    [self.view addSubview:addCmtView];
    self.addCmtView = addCmtView;
}

- (NSMutableArray *)cmtArray {
    _cmtArray = [NSMutableArray arrayWithArray:[XCFCommentTool totalComments]];
    return _cmtArray;
}
- (NSMutableArray *)atUserArray {
    _atUserArray = [NSMutableArray arrayWithArray:[XCFCommentTool totalAuthors]];
    return _atUserArray;
}


#pragma mark - 事件处理
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = rect.size.height;
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat finalY = rect.origin.y - XCFScreenHeight;
    [UIView animateWithDuration:duration animations:^{
        self.addCmtView.transform = CGAffineTransformMakeTranslation(0, finalY);
    }];
}

// 举报
- (void)report {
    // 测试：还原评论
    [XCFCommentTool recovery];
    [self.cmtTableView reloadData];
}

#pragma mark - 关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
