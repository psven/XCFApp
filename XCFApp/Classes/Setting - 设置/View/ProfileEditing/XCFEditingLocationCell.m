//
//  XCFEditingLocationCell.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/20.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "XCFEditingLocationCell.h"
#import "XCFLocation.h"
#import "XCFCity.h"

@interface XCFEditingLocationCell () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *locationPicker;
@property (weak, nonatomic) IBOutlet UILabel *locationType;
@property (nonatomic, strong) UIPickerView *cityPicker;
@property (nonatomic, strong) NSArray *locData;
@property (nonatomic, assign) NSInteger index; // 选择器选中的省份
@end

@implementation XCFEditingLocationCell

- (void)awakeFromNib {
    _cityPicker = [[UIPickerView alloc] init];
    _cityPicker.delegate = self;
    _cityPicker.dataSource = self;
    _cityPicker.backgroundColor = XCFDishViewBackgroundColor;
    self.locationPicker.inputView = _cityPicker;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, XCFScreenWidth, 44)];
    toolbar.backgroundColor = XCFDishViewBackgroundColor;
    UIBarButtonItem *cancelButton = [UIBarButtonItem barButtonItemWithTitle:@"取消" target:self action:@selector(cancelPicking)];
    UIBarButtonItem *doneButton = [UIBarButtonItem barButtonItemWithTitle:@"完成" target:self action:@selector(done)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[cancelButton, flexible, doneButton];
    self.locationPicker.inputAccessoryView = toolbar;
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) return self.locData.count;
    NSInteger index = [self.cityPicker selectedRowInComponent:0];
    return [[self.locData[index] cities] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    NSString *title;
    if (component == 0) {
        title = [self.locData[row] province_name];
    } else {
//        NSInteger index = [self.cityPicker selectedRowInComponent:0];
        NSArray *cities = [self.locData[self.index] cities];
        title = [cities[row] city_name];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.index = row;
        [self.cityPicker reloadComponent:1];
        [self.cityPicker selectRow:0 inComponent:1 animated:YES];
    }
    
//    NSInteger provinceIndex = [self.cityPicker selectedRowInComponent:0];
    XCFLocation *province = self.locData[self.index];
    NSInteger cityIndex = [self.cityPicker selectedRowInComponent:1];
    XCFCity *city = province.cities[cityIndex];
    
    self.locationPicker.text = [NSString stringWithFormat:@"%@,%@", province.province_name, city.city_name];
    !self.editingLocationBlock ? : self.editingLocationBlock(self.locationPicker.text);
}


- (NSArray *)locData {
    if (!_locData) {
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"location" ofType:@"json"]];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            XCFLocation *loc = [XCFLocation locationWithDict:dict];
            [newArray addObject:loc];
        }
        _locData = newArray;
    }
    return _locData;
}


#pragma mark - 事件处理

- (void)cancelPicking {
    !self.cancelEditingBlock ? : self.cancelEditingBlock(self.displayLocation);
    [self endEditing:YES];
}

- (void)done {
    [self endEditing:YES];
    !self.editingLocationBlock ? : self.editingLocationBlock(self.locationPicker.text);
}


#pragma mark - 构造方法

- (void)setDisplayLocation:(NSString *)displayLocation {
    _displayLocation = displayLocation;
    self.locationPicker.text = displayLocation;
}

- (void)setType:(NSString *)type {
    _type = type;
    self.locationType.text = type;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 15;
    frame.size.width -= 30;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
