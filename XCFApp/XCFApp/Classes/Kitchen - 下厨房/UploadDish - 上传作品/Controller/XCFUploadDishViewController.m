//
//  XCFUploadDishViewController.m
//  XCFApp
//
//  Created by 彭世朋 on 16/4/26.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFUploadDishViewController.h"
#import "XCFAddTagViewController.h"
#import "XCFTextAndPhotoView.h"
#import "XCFMealsAndTagsView.h"
#import <Masonry.h>


@interface XCFUploadDishViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) XCFTextAndPhotoView *textPhotoView;
@property (nonatomic, strong) XCFMealsAndTagsView *mealsTagsView;

@property (nonatomic, strong) NSMutableArray *photosArray; // 图片数据
@property (nonatomic, strong) NSMutableArray *tagsArray; // 图片数据

@property (nonatomic, assign) CGFloat photoViewHeight;
@property (nonatomic, assign) CGFloat tagViewHeight;

@end

@implementation XCFUploadDishViewController

static CGFloat const textViewHeight = 100;
static CGFloat const mealsAndAddTagBtnViewHeight = 90;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = XCFGlobalBackgroundColor;
    self.photoViewHeight = textViewHeight + 90;
    self.tagViewHeight = mealsAndAddTagBtnViewHeight;
    [self setupNav];
    [self setupHeader];
}

- (void)setupNav {
    self.title = @"上传作品";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"取消"
                                                                             target:self
                                                                             action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"分享"
                                                                              target:self
                                                                              action:@selector(share)];
}

- (void)setupHeader {
    CGFloat totalHeight = self.tagViewHeight + self.photoViewHeight;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, totalHeight)];
    
    
    /*********** textPhotoView ************/
    
    XCFTextAndPhotoView *textPhotoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFTextAndPhotoView class])
                                                                        owner:self options:nil] lastObject];
    WeakSelf;
    textPhotoView.editingTextBlock = ^(NSString *text) { // 编辑文字
        // 新建个属性保存文字
    };
    textPhotoView.addPhotoBlock = ^{ // 添加图片
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:weakSelf
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相机", @"相册", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:weakSelf.view];
    };
    textPhotoView.deletePhotoBlock = ^(NSUInteger index) {  // 删除图片
        [weakSelf.photosArray removeObjectAtIndex:index];
        [weakSelf updateTextPhotoViewAfterPhotoOperation]; // 更新布局
        [weakSelf.tableView reloadData];
    };
    
    [header addSubview:textPhotoView];
    [textPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(header);
        make.height.equalTo(@(self.photoViewHeight));
    }];
    self.textPhotoView = textPhotoView;
    
    
    
    /*********** mealsTagsview ************/
    
    XCFMealsAndTagsView *mealsTagsview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFMealsAndTagsView class])
                                                                        owner:self options:nil] lastObject];
    mealsTagsview.tagsArray = self.tagsArray;
    mealsTagsview.selectedMealBlock = ^(NSString *mealString) { // 选择 餐
        XCFLog(@"%@", mealString);
    };
    mealsTagsview.addTagBlock = ^{ // 添加标签
        XCFAddTagViewController *addTagVC = [[XCFAddTagViewController alloc] init];
        addTagVC.callBack = ^(NSString *tagString) {
            [weakSelf.tagsArray addObject:tagString];
            [weakSelf updateMealsTagsViewAfterTagsOperation]; // 更新布局
            [weakSelf.tableView reloadData];
        };
        UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:addTagVC];
        [weakSelf.navigationController presentViewController:navCon animated:YES completion:nil];
    };
    mealsTagsview.deleteTagBlock = ^(NSUInteger index) { // 删除标签
        [weakSelf.tagsArray removeObjectAtIndex:index];
        [weakSelf updateMealsTagsViewAfterTagsOperation]; // 更新布局
        [weakSelf.tableView reloadData];
    };
    
    [header addSubview:mealsTagsview];
    [mealsTagsview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textPhotoView.mas_bottom);
        make.left.right.equalTo(header);
        make.height.equalTo(@(self.tagViewHeight));
    }];
    self.mealsTagsView = mealsTagsview;
    
    self.tableView.tableHeaderView = header;
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
    [self.photosArray addObject:info[UIImagePickerControllerEditedImage]];
    [self updateTextPhotoViewAfterPhotoOperation]; // 更新布局
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
    }];
}


// 增删图片后更新textPhotoView的布局
- (void)updateTextPhotoViewAfterPhotoOperation {
    self.textPhotoView.photosArray = self.photosArray;
    NSUInteger line = self.photosArray.count / 4;
    self.photoViewHeight = textViewHeight + 90 * (line+1);
    [self.textPhotoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.photoViewHeight));
    }];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, XCFScreenWidth, self.photoViewHeight+self.tagViewHeight);
}

// 增删标签后更新mealsTagsView的布局
- (void)updateMealsTagsViewAfterTagsOperation {
    self.mealsTagsView.tagsArray = self.tagsArray;
    CGFloat totalWidth = 15;
    NSUInteger currentLine = 0;
    for (NSString *tagString in self.tagsArray) {
        CGFloat textWidth = [tagString getSizeWithTextSize:CGSizeMake(MAXFLOAT, 30) fontSize:14].width;
        CGFloat displayWidth = textWidth + 55;
        totalWidth += displayWidth+5;
        if (totalWidth-5-15 > XCFScreenWidth) {
            totalWidth = 15;
            currentLine++;
        }
    }
    CGFloat addedTagHeight = self.tagsArray.count ? (44 + (30+5)*currentLine) : 0;
    self.tagViewHeight = mealsAndAddTagBtnViewHeight + addedTagHeight;
    [self.mealsTagsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.tagViewHeight));
    }];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, XCFScreenWidth, self.photoViewHeight+self.tagViewHeight);
    
}


#pragma mark - 事件处理
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)share {
    
}


#pragma mark - 关闭键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - 属性
- (NSMutableArray *)photosArray {
    if (!_photosArray) {
        _photosArray = [NSMutableArray array];
    }
    return _photosArray;
}

- (NSMutableArray *)tagsArray {
    if (!_tagsArray) {
        _tagsArray = [NSMutableArray array];
    }
    return _tagsArray;
}

@end
