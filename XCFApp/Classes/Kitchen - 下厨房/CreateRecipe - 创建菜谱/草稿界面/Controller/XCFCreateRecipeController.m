//
//  XCFCreateRecipeController.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/17.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFCreateRecipeController.h"
#import "XCFEditController.h"
#import "XCFIngredientEditController.h"
#import "XCFRecipeViewController.h"
// headerFooter
#import "XCFRecipeEditViewHeader.h"
#import "XCFRecipeEditViewFooter.h"
// cell
#import "XCFRecipeIngredientCell.h"
#import "XCFCreateRecipeInstructionCell.h"
#import "XCFCreateTipsCell.h"
// sectionFooter
#import "XCFCreateIngredientFooter.h"
#import "XCFCreateInstructionFooter.h"
// model
#import "XCFCreateRecipe.h"
#import "XCFRecipeDraftTool.h"
//#import "XCFCreateRecipeTool.h"
#import "XCFCreateIngredient.h"
#import "XCFCreateInstruction.h"

#import <Masonry.h>
#import <SVProgressHUD.h>

@interface XCFCreateRecipeController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) XCFRecipeEditViewHeader *header;
@property (nonatomic, strong) UIActionSheet *headerActionSheet;         // 顶部图片ActionSheet
@property (nonatomic, strong) UIActionSheet *instructActionSheet;       // 做法步骤ActionSheet
@property (nonatomic, strong) UIImagePickerController *headerPicker;    // 顶部图片选取器
@property (nonatomic, strong) UIImagePickerController *instructPicker;  // 做法步骤图片选取器
@property (nonatomic, assign) NSInteger setImageIndex;
@property (nonatomic, strong) NSMutableArray<XCFCreateIngredient *> *ingredientArray;       // 用料数组
@property (nonatomic, strong) NSMutableArray<XCFCreateInstruction *> *instructionArray;     // 步骤数组
@property (nonatomic, assign) tableViewAdjustStyle style;                                   // 做法调整按钮类型
@end

@implementation XCFCreateRecipeController
static NSString *const createHeaderIdentifier              = @"createHeader";              // header
static NSString *const instructionFooterIdentifier         = @"instructionFooter";         // 用料footer
static NSString *const ingredientFooterIdentifier          = @"ingredientFooter";          // 做法footer
static NSString *const createIngredientCellIdentifier      = @"createIngredientCell";      // 用料
static NSString *const createInstructionCellIdentifier     = @"createInstructionCell";     // 做法
static NSString *const createTipsCellIdentifier            = @"createTipsCell";            // 小贴士


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建菜谱";
    [self setupTableView];
    [self setupFooter];
}


#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.header.createRecipe = self.createRecipe; // 刷新header的显示
    self.header.frame = CGRectMake(0, 0, XCFScreenWidth, self.createRecipe.headerHeight);
    self.tableView.tableHeaderView = self.header; // 需要重新设置才能生效
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) count = self.ingredientArray.count;
    if (section == 1) count = self.instructionArray.count;
    if (section == 2) count = 1;;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) { // 用料
        XCFRecipeIngredientCell *ingredientCell = [tableView dequeueReusableCellWithIdentifier:createIngredientCellIdentifier
                                                                                  forIndexPath:indexPath];
        if (self.ingredientArray.count) ingredientCell.createIngredient = self.ingredientArray[indexPath.row];
        cell = ingredientCell;
        
        
    } else if (indexPath.section == 1) { // 步骤
        XCFCreateRecipeInstructionCell *instructionCell = [tableView dequeueReusableCellWithIdentifier:createInstructionCellIdentifier
                                                                                          forIndexPath:indexPath];
        // 默认显示2个步骤 如果数据中只有1个步骤 那第一个步骤才从数据中获取
        if (self.instructionArray.count == 1 && indexPath.row == 0) {
            instructionCell.createInstruction = self.instructionArray[indexPath.row];
        } else if (self.instructionArray.count > 1) {
            instructionCell.createInstruction = self.instructionArray[indexPath.row];
        }
        
        instructionCell.index = indexPath.row;
        WeakSelf;
        instructionCell.editTextBlock = ^{  // 编辑步骤描述
            NSString *currentContent = @"";
            if (weakSelf.instructionArray.count == 1 && indexPath.row == 0) {
                currentContent = weakSelf.instructionArray[indexPath.row].text;
            } else if (weakSelf.createRecipe.instruction.count > 1) {
                currentContent = weakSelf.instructionArray[indexPath.row].text;
            }
            
            NSString *title = [NSString stringWithFormat:@"添加步骤%zd", indexPath.row+1];
            XCFEditController *editVC = [[XCFEditController alloc] initWithTitle:title
                                                                  currentContent:currentContent
                                                                   doneEditBlock:^(NSString *result) { // 编辑完文字后的回调，返回编辑后的文字
                                                                       XCFCreateInstruction *instruction = weakSelf.instructionArray[indexPath.row];
                                                                       instruction.text = result;
                                                                       [weakSelf.instructionArray replaceObjectAtIndex:indexPath.row
                                                                                                            withObject:instruction];
                                                                       [weakSelf.tableView reloadData];
                                                                       [weakSelf updateDarft];
                                                                   }];
            [weakSelf.navigationController pushViewController:editVC animated:NO];
        };
        instructionCell.addPhotoBlock = ^ {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                     delegate:weakSelf
                                                            cancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"相机", @"相册", nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            weakSelf.setImageIndex = indexPath.row; // 记录设置图片的步骤
            weakSelf.instructActionSheet = actionSheet;
            [actionSheet showInView:weakSelf.view];
        };
        cell = instructionCell;
    
        
    } else if (indexPath.section == 2) { // 小贴士
        XCFCreateTipsCell *tipsCell = [tableView dequeueReusableCellWithIdentifier:createTipsCellIdentifier
                                                                      forIndexPath:indexPath];
        tipsCell.tips = self.createRecipe.tips;
        cell = tipsCell;
    }
    
    if (!cell) cell = [[UITableViewCell alloc] init];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        XCFIngredientEditController *ingreEditVC = [[XCFIngredientEditController alloc] initWithStyle:UITableViewStylePlain];
        ingreEditVC.ingredientArray = [NSMutableArray arrayWithArray:self.ingredientArray];
        [self.navigationController pushViewController:ingreEditVC animated:NO];
        WeakSelf;
        ingreEditVC.doneEditBlock = ^(NSArray *ingreArray) {
            weakSelf.ingredientArray = [NSMutableArray arrayWithArray:ingreArray];
            [weakSelf.tableView reloadData];
            [weakSelf updateDarft];
        };
    }
    else if (indexPath.section == 2) {
        WeakSelf;
        XCFEditController *editVC = [[XCFEditController alloc] initWithTitle:@"小贴士"
                                                              currentContent:self.createRecipe.tips
                                                               doneEditBlock:^(NSString *result) {
                                                                   weakSelf.createRecipe.tips = result;
                                                                   [weakSelf.tableView reloadData];
                                                                   [weakSelf updateDarft];
                                                               }];
        [self.navigationController pushViewController:editVC animated:NO];
    }
}



#pragma mark - UITableViewDelegate

// 如果不是步骤数组，就回到对应位置
- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSIndexPath *finalIndexPath;
    // 如果拖动到第0组，那么松手就返回第1组第0个
    if (proposedDestinationIndexPath.section == 0) {
        finalIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    }
    else if (proposedDestinationIndexPath.section == 1) {
        finalIndexPath = proposedDestinationIndexPath;
    }
    else if (proposedDestinationIndexPath.section == 2) {
        finalIndexPath = [NSIndexPath indexPathForRow:self.instructionArray.count-1 inSection:1];
    }
//     如果目标section跟原section不一致，就返回至原位置
//    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
//        return sourceIndexPath;
//    } else {
//        return proposedDestinationIndexPath;
//    }
    return finalIndexPath;
}

// 这里只允许第1组cell可以移动
- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果步骤数组有数据，就删除对应位置的数据
    if (self.instructionArray.count) {
        [self.instructionArray removeObjectAtIndex:indexPath.row];
    }
    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                  withRowAnimation:UITableViewRowAnimationFade];
    [self updateDarft];
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.section == 1) {
        XCFCreateInstruction *movingObj = self.instructionArray[sourceIndexPath.row];    // 取出
        [self.instructionArray removeObjectAtIndex:sourceIndexPath.row];
        [self.instructionArray insertObject:movingObj atIndex:destinationIndexPath.row]; // 插入
        [self.tableView reloadData];
        [self updateDarft];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return YES;
    return NO;
}


#pragma mark - UITableViewHeaderFooterView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:createHeaderIdentifier];
    headerView.frame = CGRectMake(0, 0, XCFScreenWidth, 50);
    headerView.contentView.backgroundColor = XCFGlobalBackgroundColor;
    NSInteger tag = 100;
    UILabel *label = [headerView.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        label.font = [UIFont systemFontOfSize:16];
        label.frame = CGRectMake(15, 15, 200, 30);
        [headerView.contentView addSubview:label];
    }
    if (section == 0) label.text = @"用料";
    if (section == 1) label.text = @"做法";
    if (section == 2) label.text = @"小贴士";
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer;
    // 原料footer
    if (section == 0 && !self.ingredientArray.count) {
        XCFCreateIngredientFooter *ingredientFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ingredientFooterIdentifier];
        ingredientFooter.frame = CGRectMake(0, 0, XCFScreenWidth, 40);
        footer = ingredientFooter;
        WeakSelf;
        // 添加原料
        ingredientFooter.addIngredientBlock = ^{
            // 进入原料编辑控制器
            XCFIngredientEditController *ingreEditVC = [[XCFIngredientEditController alloc] initWithStyle:UITableViewStylePlain];
            ingreEditVC.ingredientArray = [NSMutableArray arrayWithArray:weakSelf.ingredientArray];
            [weakSelf.navigationController pushViewController:ingreEditVC animated:NO];
            // 完成编辑后的回调，拿到新原料数据，同步本地数据，刷新界面
            ingreEditVC.doneEditBlock = ^(NSArray *ingreArray) {
                weakSelf.ingredientArray = [NSMutableArray arrayWithArray:ingreArray];
                [weakSelf.tableView reloadData];
                [weakSelf updateDarft];
            };
        };
    }
    // 步骤footer
    else if (section == 1) {
        XCFCreateInstructionFooter *instructionFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:instructionFooterIdentifier];
        instructionFooter.frame = CGRectMake(0, 0, XCFScreenWidth, 70);
        instructionFooter.style = self.style;
        footer = instructionFooter;
        WeakSelf;
        // 增加一行点击回调
        instructionFooter.addInstructionBlock = ^{
            [weakSelf.instructionArray addObject:[[XCFCreateInstruction alloc] init]];
            NSInteger row = weakSelf.instructionArray.count - 1;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:1];
            [weakSelf.tableView insertRowsAtIndexPaths:@[indexPath]
                                      withRowAnimation:UITableViewRowAnimationBottom];
        };
        // 调整回调
        instructionFooter.adjustBlock = ^(tableViewAdjustStyle style) {
            weakSelf.style = style;
            if (style == tableViewAdjustStyleNone) {
                [weakSelf.tableView setEditing:NO animated:YES];
            } else if (style == tableViewAdjustStyleAdjusting) {
                [weakSelf.tableView setEditing:YES animated:YES];
            }
        };
    }
    return footer;
}



#pragma mark - 高度设置

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    if (indexPath.section == 0) {
        height = [self.ingredientArray[indexPath.row] cellHeight];
    }
    else if (indexPath.section == 1) {
        height = [self.instructionArray[indexPath.row] cellHeight];
    }
    else if (indexPath.section == 2) {
        CGFloat tipsHeight = [self.createRecipe.tips getSizeWithTextSize:CGSizeMake(XCFScreenWidth-30, MAXFLOAT)
                                                                fontSize:14].height;
        height = self.createRecipe.tips.length ? tipsHeight : 60;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0;
    if (section == 0 && !self.ingredientArray.count) {
        height = 40;
    } else if (section == 1) {
        height = 70;
    }
    return height;
}



#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *headerPicker = [[UIImagePickerController alloc] init];
    headerPicker.videoQuality = UIImagePickerControllerQualityType640x480;
    headerPicker.delegate = self;
    headerPicker.allowsEditing = YES;
    if (actionSheet == self.headerActionSheet) self.headerPicker = headerPicker;
    if (actionSheet == self.instructActionSheet) self.instructPicker = headerPicker;
    
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
    // 如果是顶部大图
    if (picker == self.headerPicker) {
        self.createRecipe.image = info[UIImagePickerControllerEditedImage];
    }
    // 如果是步骤图
    else if (picker == self.instructPicker) {
        self.instructionArray[self.setImageIndex].image = info[UIImagePickerControllerEditedImage];
    }
    
    [self.tableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:^{
        // 选取完成后更新本地数据
        [self updateDarft];
    }];
}


#pragma mark - tableHeaderFooterView

- (XCFRecipeEditViewHeader *)header {
    if (!_header) {
        _header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFRecipeEditViewHeader class])
                                                 owner:self options:nil] lastObject];
        _header.frame = CGRectMake(0, 0, XCFScreenWidth, self.createRecipe.headerHeight);
        _header.createRecipe = self.createRecipe;
        self.tableView.tableHeaderView = _header;
        WeakSelf;
        _header.editHeaderActionBlock = ^(EditHeaderAction action) {
            if (action == EditHeaderActionAddPhoto) { // 添加照片
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:weakSelf
                                                                cancelButtonTitle:@"取消"
                                                           destructiveButtonTitle:nil
                                                                otherButtonTitles:@"相机", @"相册", nil];
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                weakSelf.headerActionSheet = actionSheet;
                [actionSheet showInView:weakSelf.view];
            }
            
            else if (action == EditHeaderActionAddName) { // 编辑标题
                XCFEditController *editVC = [[XCFEditController alloc] initWithTitle:@"菜谱名称"
                                                                      currentContent:weakSelf.createRecipe.name
                                                                       doneEditBlock:^(NSString *result) {
                                                                           weakSelf.createRecipe.name = result;
                                                                           [weakSelf.tableView reloadData];
                                                                           [weakSelf updateDarft];
                                                                       }];
                [weakSelf.navigationController pushViewController:editVC animated:NO];
            }
            
            else if (action == EditHeaderActionAddSummary) { // 添加简介
                XCFEditController *editVC = [[XCFEditController alloc] initWithTitle:@"简介"
                                                                      currentContent:weakSelf.createRecipe.desc
                                                                       doneEditBlock:^(NSString *result) {
                                                                           weakSelf.createRecipe.desc = result;
                                                                           [weakSelf.tableView reloadData];
                                                                           [weakSelf updateDarft];
                                                                       }];
                [weakSelf.navigationController pushViewController:editVC animated:NO];
            }
        };
    }
    return _header;
}


- (void)setupFooter {
    XCFRecipeEditViewFooter *footer = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XCFRecipeEditViewFooter class])
                                                                     owner:self options:nil] lastObject];
    footer.frame = CGRectMake(0, 0, XCFScreenWidth, 200);
    NSDate *date = [NSDate date];
    NSDateFormatter *dmt = [[NSDateFormatter alloc] init];
    dmt.dateFormat = @"yyyy-MM-dd";
    footer.time = [dmt stringFromDate:date];
    self.tableView.tableFooterView = footer;
    WeakSelf;
    footer.editFooterActionBlock = ^(EditFooterAction action) {
        if (action == EditFooterActionSave) {           // 保存草稿
            [weakSelf updateDarft];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
        else if (action == EditFooterActionPublish) {   // 发布菜谱
//            [UILabel showStats:@"这个木有做" atView:weakSelf.view];
            [SVProgressHUD showWithStatus:@"正在上传"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发布成功"
                                                                                         message:@"您的菜谱将在审核通过后展示"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {        // 保存草稿
                                                                     [weakSelf updateDarft];
                                                                     [weakSelf.navigationController popViewControllerAnimated:YES];
                                                                 }];
                [alertController addAction:okAction];
                [weakSelf.navigationController presentViewController:alertController
                                                            animated:YES
                                                          completion:nil];
            });
        }
        
        else if (action == EditFooterActionDelete) {    // 删除草稿
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除本草稿吗"
                                                                                     message:@"删除之后将不可恢复"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"删除"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 [XCFRecipeDraftTool removeRecipeDraftAtIndex:weakSelf.draftIndex];
                                                                 [weakSelf.navigationController popViewControllerAnimated:YES];
                                                             }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [weakSelf.navigationController presentViewController:alertController
                                                        animated:YES
                                                      completion:nil];
        }
        
    };
}

/**
 *  刷新存档
 */
- (void)updateDarft {
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSInteger index=0; index<self.instructionArray.count; index++) {
        XCFCreateInstruction *instruction = self.instructionArray[index];
        // 如果有文字或者图片，就添加到准备存储的数组中
        if (instruction.text.length || instruction.image) {
            [newArray addObject:instruction];
        }
    }
    self.createRecipe.ingredient = self.ingredientArray;
    self.createRecipe.instruction = newArray;
    [XCFRecipeDraftTool updateRecipeDraftAtIndex:self.draftIndex
                                 withRecipeDraft:self.createRecipe];
}

#pragma mark - 属性

//- (XCFCreateRecipe *)createRecipe {
//    if(!_createRecipe) {
//        _createRecipe = [XCFCreateRecipeTool getCreateRecipe];
//        _createRecipe.name = @"测试标题";
//        //        _createRecipe.desc = @"测试简介";
//        //        _createRecipe.tips = @"测试小贴士";
//
//        //        NSMutableArray *array1 = [NSMutableArray array];
//        //        XCFCreateIngredient *ingredient = [[XCFCreateIngredient alloc] init];
//        //        ingredient.name = @"菜花";
//        //        ingredient.amount = @"一斤";
//        //        [array1 addObject:ingredient];
//        //        _ingredientArray = array1;
//
//        NSMutableArray *array2 = [NSMutableArray array];
//        XCFCreateInstruction *instrution = [[XCFCreateInstruction alloc] init];
//        //        instrution.text = @"不知道怎么煮啊随便把";
//        //        [array2 addObject:instrution];
//        _createRecipe.instruction = array2;
//    }
//    return _createRecipe;
//}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XCFGlobalBackgroundColor;
    self.view.backgroundColor = XCFGlobalBackgroundColor;
    
    [self.tableView registerClass:[UITableViewHeaderFooterView    class] forHeaderFooterViewReuseIdentifier:createHeaderIdentifier];
    [self.tableView registerClass:[XCFCreateIngredientFooter      class] forHeaderFooterViewReuseIdentifier:ingredientFooterIdentifier];
    [self.tableView registerClass:[XCFCreateInstructionFooter     class] forHeaderFooterViewReuseIdentifier:instructionFooterIdentifier];
    [self.tableView registerClass:[XCFRecipeIngredientCell        class] forCellReuseIdentifier:createIngredientCellIdentifier];
    [self.tableView registerClass:[XCFCreateRecipeInstructionCell class] forCellReuseIdentifier:createInstructionCellIdentifier];
    [self.tableView registerClass:[XCFCreateTipsCell              class] forCellReuseIdentifier:createTipsCellIdentifier];
}


- (void)setCreateRecipe:(XCFCreateRecipe *)createRecipe {
    _createRecipe = createRecipe;
    if (!createRecipe.instruction.count) { // 如果没有数据，默认创建两个
        NSMutableArray *originInsArray = [NSMutableArray array];
        for (NSInteger i=0; i<2; i++) {
            [originInsArray addObject:[[XCFCreateInstruction alloc] init]];
        }
        self.createRecipe.instruction = originInsArray;
    }
}

- (NSMutableArray *)instructionArray {
    if (!_instructionArray) {
        _instructionArray = [NSMutableArray arrayWithArray:self.createRecipe.instruction];
    }
    return _instructionArray;
}

- (NSMutableArray<XCFCreateIngredient *> *)ingredientArray {
    if (!_ingredientArray) {
        _ingredientArray = [NSMutableArray arrayWithArray:self.createRecipe.ingredient];
    }
    return _ingredientArray;
}

@end
