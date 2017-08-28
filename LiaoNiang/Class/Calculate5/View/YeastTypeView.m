//
//  YeastTypeView.m
//  LiaoNiang
//
//  Created by Jacob on 9/28/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "YeastTypeView.h"
#import "FloatingSelectorView.h"
#import "TitleAndTextFieldView.h"
#import "CustomDatePickerView.h"

@interface YeastTypeView()

@property (nonatomic, strong) UIView *vialibityView;

@property (nonatomic, strong) UIView *lastView;
@property (nonatomic, strong) CustomDatePickerView *datePickerView;

@end

@implementation YeastTypeView

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.superview).offset(kPadding);
        make.top.equalTo(titleLabel.superview).offset(5);
    }];
    titleLabel.text = @"酵母种类：";
    titleLabel.textColor = CommonMinorFontColor;
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    FloatingSelectorView *sectorView = [[FloatingSelectorView alloc] init];
    [self addSubview:sectorView];
    [sectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(1);
        make.top.equalTo(sectorView.superview).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@18);
    }];
    sectorView.titles = @[@"干酵母", @"液体酵母", @"酵母泥"];
    sectorView.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    self.yeastType = @"干酵母";
    [sectorView setSelectionDidChangeBlock:^(NSString *title, NSInteger index) {
        @strongify(self);
        CGFloat height = 0;
        if ([title isEqualToString:@"干酵母"]) {
            height = 145;
            self.textField1.title = @"干酵母量(克):";
            self.textField2.title = @"细胞浓度(十亿个细胞/克):";
            self.textField2.textValue = @"0";
            self.textField2.textField.inputView = nil;
            [self.textField2.textField reloadInputViews];
            self.vialibityView.hidden = YES;
        } else if ([title isEqualToString:@"液体酵母"]) {
            height = 190;
            self.textField1.title = @"液体酵母量(瓶)";
            self.textField2.title = @"Mfg 时间(yyyy/mm/dd):";
            NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy/MM/dd";
            self.textField2.textValue = [fmt stringFromDate:[NSDate date]];
            self.textField2.textField.inputView = self.datePickerView;
            self.vialibityView.hidden = NO;
        } else if ([title isEqualToString:@"酵母泥"]) {
            height = 145;
            self.textField1.title = @"酵母泥量(升):";
            self.textField2.title = @"细胞浓度(十亿个细胞/毫升):";
            self.textField2.textValue = @"0";
            self.textField2.textField.inputView = nil;
            [self.textField2.textField reloadInputViews];
            self.vialibityView.hidden = YES;
        }
        
        self.yeastType = title;
        if (self.yeastTypeChangedBlock) {
            self.yeastTypeChangedBlock(title, height);
        }
    }];
    
    TitleAndTextFieldView *textField1 = [[TitleAndTextFieldView alloc] initWithTitle:@"干酵母量(克):"];
    [self addSubview:textField1];
    [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textField1.superview);
        make.top.equalTo(sectorView.mas_bottom).offset(5);
        make.height.equalTo(@60);
    }];
    self.textField1 = textField1;
    
    FloatLabelTextField *textField2 = [[FloatLabelTextField alloc] initWithTitle:@"细胞浓度(十亿个细胞/克):"];
    [self addSubview:textField2];
    [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField2.superview).offset(kPadding);
        make.right.equalTo(textField2.superview).offset(-kPadding);
        make.top.equalTo(textField1.mas_bottom).offset(0);
        make.height.equalTo(@60);
    }];
    textField2.textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField2.textValue = @"0";
    self.textField2 = textField2;
    
    UIView *viabilityView = [UIView new];
    [self addSubview:viabilityView];
    [viabilityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viabilityView.superview);
        make.top.equalTo(textField2.mas_bottom).offset(5);
    }];
    self.vialibityView = viabilityView;
    
    UILabel *viabilityLabel = [UILabel new];
    [viabilityView addSubview:viabilityLabel];
    [viabilityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viabilityLabel.superview).offset(kPadding);
        make.top.equalTo(textField2.mas_bottom).offset(0);
        make.width.equalTo(@70);
    }];
    viabilityLabel.text = @"Viability：";
    viabilityLabel.textColor = CommonMinorFontColor;
    viabilityLabel.font = [UIFont systemFontOfSize:14];

    UILabel *viabilityValue = [UILabel new];
    [viabilityView addSubview:viabilityValue];
    [viabilityValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viabilityLabel.mas_right).offset(1);
        make.top.equalTo(viabilityLabel);
        make.right.equalTo(viabilityValue.superview).offset(-kPadding);
        make.bottom.equalTo(viabilityValue.superview).offset(-5);
    }];
    viabilityValue.textColor = CommonMainFontColor;
    viabilityValue.font = [UIFont systemFontOfSize:14];
    viabilityValue.numberOfLines = 0;
    viabilityValue.text = @" ";
    self.viabilityValue = viabilityValue;
    viabilityView.hidden = YES;
}

- (CustomDatePickerView *)datePickerView {
    if (_datePickerView == nil) {
        _datePickerView = [[CustomDatePickerView alloc] init];
        _datePickerView.datePicker.maximumDate = [NSDate date];
        @weakify(self);
        [_datePickerView setDatePickerCancelBlock:^{
            @strongify(self);
            [self endEditing:YES];
        }];
        [_datePickerView setDatePickerSelectedBlock:^(NSString *date) {
            @strongify(self);
            [self endEditing:YES];
            self.textField2.textField.text = date;
        }];
    }
    return _datePickerView;
}

@end
