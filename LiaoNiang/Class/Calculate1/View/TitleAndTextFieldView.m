//
//  TitleAndTextFieldView.m
//  LiaoNiang
//
//  Created by Jacob on 9/6/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "TitleAndTextFieldView.h"
#import "HXNumericTextField.h"

@interface TitleAndTextFieldView()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation TitleAndTextFieldView

- (id)initWithTitle:(NSString *)title {
    return [self initWithTitle:title padding:kPadding];
}

- (id)initWithTitle:(NSString *)title padding:(CGFloat)padding {
    if (self = [super init]) {
        self.padding = padding;
        self.title = title;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.clipsToBounds = YES;
    
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview);
        make.height.equalTo(@60).priority(999);
    }];
    
    UILabel *title = [UILabel new];
    self.titleLabel = title;
    [contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.superview).offset(self.padding);
        make.top.equalTo(title.superview).offset(5);
    }];
    title.text = self.title;
    title.font = [UIFont systemFontOfSize:12];
    title.textColor = CommonMinorFontColor;
    [title setAdjustsFontSizeToFitWidth:YES];
    self.titleLabel = title;
    
    UIView *bottomLine = [UIView new];
    [contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomLine.superview).offset(self.padding);
        make.right.equalTo(bottomLine.superview).offset(-self.padding);
        make.bottom.equalTo(bottomLine.superview).offset(-10);
        make.height.equalTo(@1);
    }];
    bottomLine.backgroundColor = kLineColor;
    self.line = bottomLine;
    
    HXNumericTextField *textField = [[HXNumericTextField alloc] initWithBuilder:^(HXNumericTextFieldBuilder *build) {
        build.floatPrecision(8);
    }];
    [contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomLine);
        make.bottom.equalTo(bottomLine.mas_top).offset(-2);
        make.height.equalTo(@15);
    }];
    textField.placeholder = [NSString stringWithFormat:@"%@", self.title];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = CommonMainFontColor;
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.textField = textField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.titleLabel.textColor = UIColorFromRGB(0xF7246F);
    self.line.backgroundColor = UIColorFromRGB(0xF7246F);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.titleLabel.textColor = CommonMinorFontColor;
    self.line.backgroundColor = kLineColor;
}
    
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
    self.textField.placeholder = [NSString stringWithFormat:@"%@", title];
}

@end
