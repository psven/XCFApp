//
//  XCFAddressEditingView.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/21.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFAddressEditingView.h"
#import "XCFAddressInfo.h"
#import "XCFDetailLocation.h"
#import "XCFDetailCity.h"
#import "XCFDetailArea.h"

@interface XCFAddressEditingView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *provinceField;
@property (weak, nonatomic) IBOutlet UITextView *detailAddressField;
@property (weak, nonatomic) IBOutlet UIButton *delete;

@property (nonatomic, strong) UIPickerView *cityPicker;
@property (nonatomic, strong) NSArray *locData;
@property (nonatomic, assign) NSInteger provinceIndex; // 选择器选中的省份
@property (nonatomic, assign) NSInteger cityIndex; // 选择器选中的城市
@end

@implementation XCFAddressEditingView

- (void)awakeFromNib {
    [self.nameField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nameFieldEndEditing)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(phoneFieldEndEditing)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.phoneField];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(detailAddressFieldEndEditing)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self.detailAddressField];
    [self.delete addTarget:self action:@selector(deleteThisAddress) forControlEvents:UIControlEventTouchUpInside];
    [self setupCityPicker];
    // textView没有placeholder
}



#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger count;
    XCFDetailLocation *deLoc = self.locData[[self.cityPicker selectedRowInComponent:0]];
    if (component == 0) {
        count = self.locData.count;
    } else if (component == 1) {
        count = deLoc.citylist.count;
    } else if (component == 2) {
        XCFDetailLocation *deLoc = self.locData[self.provinceIndex];
        XCFDetailCity *deCity = deLoc.citylist[self.cityIndex];
        count = deCity.arealist.count;
    }
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    NSString *title;
    if (component == 0) {
        title = [self.locData[row] provinceName];
    } else if (component == 1) {
        NSArray *cityList = [self.locData[self.provinceIndex] citylist];
        title = [cityList[row] cityName];
    } else if (component == 2) {
        NSArray *cityList = [self.locData[self.provinceIndex] citylist];
        NSArray *areaList = [cityList[self.cityIndex] arealist];
        title = [areaList[row] areaName];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.provinceIndex = row;
        self.cityIndex = 0; // 恢复为0
        [self.cityPicker reloadComponent:1];
        [self.cityPicker reloadComponent:2];
        [self.cityPicker selectRow:0 inComponent:1 animated:YES];
        [self.cityPicker selectRow:0 inComponent:2 animated:YES];
    } else if (component == 1) {
        self.cityIndex = row;
        [self.cityPicker reloadComponent:2];
        [self.cityPicker selectRow:0 inComponent:2 animated:YES];
    }
    
    XCFDetailLocation *province = self.locData[self.provinceIndex];
    XCFDetailCity *city = province.citylist[self.cityIndex];
    NSInteger areaIndex = [self.cityPicker selectedRowInComponent:2];
    XCFDetailArea *area = city.arealist[areaIndex];
    
    self.provinceField.text = [NSString stringWithFormat:@"%@,%@,%@", province.provinceName, city.cityName, area.areaName];
    !self.editingLocationBlock ? : self.editingLocationBlock(self.provinceField.text);
}


- (NSArray *)locData {
    if (!_locData) {
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detaillocation" ofType:@"plist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            XCFDetailLocation *loc = [XCFDetailLocation detailLocationWithDict:dict];
            [newArray addObject:loc];
        }
        _locData = newArray;
    }
    return _locData;
}


#pragma mark - 属性
- (void)setupCityPicker {
    _cityPicker = [[UIPickerView alloc] init];
    _cityPicker.delegate = self;
    _cityPicker.dataSource = self;
    _cityPicker.backgroundColor = XCFDishViewBackgroundColor;
    self.provinceField.inputView = _cityPicker;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 44)];
    toolbar.backgroundColor = XCFDishViewBackgroundColor;
    UIBarButtonItem *doneButton = [UIBarButtonItem barButtonItemWithTitle:@"确定" target:self action:@selector(done)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexible, doneButton];
    self.provinceField.inputAccessoryView = toolbar;
}

- (void)setAddressInfo:(XCFAddressInfo *)addressInfo {
    _addressInfo = addressInfo;
    self.nameField.text = addressInfo.name;
    self.phoneField.text = addressInfo.phone;
    self.provinceField.text = addressInfo.province;
    self.detailAddressField.text = addressInfo.detailAddress;
}


#pragma mark - 事件处理

- (void)deleteThisAddress {
    !self.deleteBlock ? : self.deleteBlock();
}

- (void)nameFieldEndEditing {
    !self.editingBlock ? : self.editingBlock(XCFAddressEditingContentName, self.nameField.text);
}

- (void)phoneFieldEndEditing {
    !self.editingBlock ? : self.editingBlock(XCFAddressEditingContentPhone, self.phoneField.text);
}

- (void)detailAddressFieldEndEditing {
    !self.editingBlock ? : self.editingBlock(XCFAddressEditingContentDetailAddress, self.detailAddressField.text);
}

- (void)done {
    [self endEditing:YES];
    !self.editingLocationBlock ? : self.editingLocationBlock(self.provinceField.text);
}

@end
