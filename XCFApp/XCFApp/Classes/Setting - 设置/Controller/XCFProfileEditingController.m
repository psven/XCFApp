//
//  XCFProfileEditingController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFProfileEditingController.h"
#import "XCFProfileEditingHeader.h"         // 上传头像
#import "XCFEditingTextCell.h"              // 名称、职位
#import "XCFEditingBirthAndGenderCell.h"    // 生日性别
#import "XCFEditingLocationCell.h"          // 地址
#import "XCFEditingDescCell.h"              // 简述
#import "XCFAuthorDetail.h"

@interface XCFProfileEditingController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) XCFProfileEditingHeader *header;
@property (nonatomic, strong) XCFAuthorDetail *authorDetail;
@end

@implementation XCFProfileEditingController

static NSString *const textCellID           = @"textCellID";
static NSString *const birthAndGenderCellID = @"birthAndGenderCellID";
static NSString *const locationCellID       = @"locationCellID";
static NSString *const descCellID           = @"descCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupTableViewHeader];
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    WeakSelf;
    if (indexPath.row == 0) { // 名称
        XCFEditingTextCell *nameCell = [tableView dequeueReusableCellWithIdentifier:textCellID];
        nameCell.placeholder = @"昵称";
        nameCell.displayName = self.authorDetail.name;
        nameCell.editingTextBlock = ^(NSString *name) { weakSelf.authorDetail.name = name; };
        cell = nameCell;
        
    } else if (indexPath.row == 1) { // 生日、性别
        XCFEditingBirthAndGenderCell *birthNGenderCell = [tableView dequeueReusableCellWithIdentifier:birthAndGenderCellID];
        birthNGenderCell.displayBirth = self.authorDetail.birthday;
        birthNGenderCell.displaySex = self.authorDetail.gender;
        birthNGenderCell.editingBirthBlock = ^(NSString *birth) { weakSelf.authorDetail.birthday = birth; };
        birthNGenderCell.editingSexBlock   = ^(NSString *sex)   { weakSelf.authorDetail.gender = sex; };
        cell = birthNGenderCell;
        
    } else if (indexPath.row == 2) { // 职业
        XCFEditingTextCell *professionCell = [tableView dequeueReusableCellWithIdentifier:textCellID];
        professionCell.placeholder = @"职业";
        professionCell.displayName = self.authorDetail.profession;
        professionCell.editingTextBlock = ^(NSString *profession) { weakSelf.authorDetail.profession = profession; };
        cell = professionCell;
        
    } else if (indexPath.row == 3) { // 家乡
        XCFEditingLocationCell *hometownCell = [tableView dequeueReusableCellWithIdentifier:locationCellID];
        hometownCell.displayLocation = self.authorDetail.hometown_location;
        hometownCell.type = @"家乡";
        hometownCell.editingLocationBlock = ^(NSString *hometown) { weakSelf.authorDetail.hometown_location = hometown; };
        hometownCell.cancelEditingBlock = ^(NSString *originLoc) {
            weakSelf.authorDetail.hometown_location = originLoc;
            [weakSelf.tableView reloadData];
        };
        cell = hometownCell;
        
    } else if (indexPath.row == 4) { // 现居
        XCFEditingLocationCell *currentLocCell = [tableView dequeueReusableCellWithIdentifier:locationCellID];
        currentLocCell.displayLocation = self.authorDetail.current_location;
        currentLocCell.type = @"常居";
        currentLocCell.editingLocationBlock = ^(NSString *currentLoc) { weakSelf.authorDetail.current_location = currentLoc; };
        currentLocCell.cancelEditingBlock = ^(NSString *originLoc) {
            weakSelf.authorDetail.current_location = originLoc;
            [weakSelf.tableView reloadData];
        };

        cell = currentLocCell;
        
    } else if (indexPath.row == 5) { // 简介
        XCFEditingDescCell *descCell = [tableView dequeueReusableCellWithIdentifier:descCellID];
        descCell.displayDesc = self.authorDetail.desc;
        descCell.editingDescBlock = ^(NSString *desc) { weakSelf.authorDetail.desc = desc; };
        cell = descCell;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.header.displayImage = self.authorDetail.image;
    self.header.frame = CGRectMake(0, 0, XCFScreenWidth, 120);
    self.tableView.tableHeaderView = self.header; // 刷新header
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5) return 120;
    return 45;
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *headerPicker = [[UIImagePickerController alloc] init];
    headerPicker.videoQuality = UIImagePickerControllerQualityTypeLow;
    headerPicker.delegate = self;
    headerPicker.allowsEditing = YES;
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) { // 相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            headerPicker.sourceType = sourceType;
            [self presentViewController:headerPicker animated:YES completion:nil];
        } else {
            [UILabel showStats:@"不支持相机" atView:self.view];
        }
    } else if (buttonIndex == 1) { // 相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        headerPicker.sourceType = sourceType;
        [self presentViewController:headerPicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControlleryDeledate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.authorDetail.image = info[UIImagePickerControllerEditedImage];
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - endEditing
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
}

#pragma mark - 存储
- (void)save {
    [XCFMyInfo updateInfoWithNewInfo:self.authorDetail];
    [UILabel showStats:@"存储成功" atView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - 属性

- (void)setupTableView {
    self.title = @"编辑个人资料";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"存储"
                                                                              target:self
                                                                              action:@selector(save)];
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFEditingTextCell class]) bundle:nil]
         forCellReuseIdentifier:textCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFEditingBirthAndGenderCell class]) bundle:nil]
         forCellReuseIdentifier:birthAndGenderCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFEditingLocationCell class]) bundle:nil]
         forCellReuseIdentifier:locationCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XCFEditingDescCell class]) bundle:nil]
         forCellReuseIdentifier:descCellID];
}

- (void)setupTableViewHeader {
    _header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFProfileEditingHeader class])
                                                                     owner:nil options:nil] lastObject];
    _header.displayImage = self.authorDetail.image;
    WeakSelf;
    _header.uploadIconBlock = ^{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:weakSelf
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相机", @"相册", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:weakSelf.view];
    };
    _header.frame = CGRectMake(0, 0, XCFScreenWidth, 120);
    self.tableView.tableHeaderView = _header;
}

- (XCFAuthorDetail *)authorDetail {
    if (!_authorDetail) {
        _authorDetail = [XCFMyInfo info];
    }
    return _authorDetail;
}


@end
