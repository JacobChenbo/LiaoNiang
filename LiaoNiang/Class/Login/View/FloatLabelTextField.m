//
//  FloatLabelTextField.m
//  LiaoNiang
//
//  Created by Jacob on 9/20/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "FloatLabelTextField.h"

@interface FloatLabelTextField()<UITextFieldDelegate> {
    NSString *_textValue;
}

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *line;

@end

@implementation FloatLabelTextField

- (id)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview);
        make.height.equalTo(@60);
    }];
    
    UIView *line = [UIView new];
    [contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line.superview);
        make.bottom.equalTo(line.superview).offset(-10);
        make.height.equalTo(@1);
    }];
    line.backgroundColor = kLineColor;
    self.line = line;
    
    UITextField *textField = [UITextField new];
    [contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.bottom.equalTo(line.mas_top).offset(-4);
        make.height.equalTo(@15);
    }];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = CommonMainFontColor;
    textField.delegate = self;
    self.textField = textField;
    
    UILabel *label = [UILabel new];
    [contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(textField);
    }];
    label.textColor = CommonMinorFontColor;
    label.font = [UIFont systemFontOfSize:14];
    label.text = self.title;
    self.label = label;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.label.textColor = UIColorFromRGB(0xF7246F);
    self.line.backgroundColor = UIColorFromRGB(0xF7246F);
    
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textField);
            make.top.equalTo(self.label.superview).offset(5);
        }];
        self.label.font = [UIFont systemFontOfSize:12];
        [self.superview layoutIfNeeded];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.label.textColor = CommonMinorFontColor;
    self.line.backgroundColor = kLineColor;
    
    if (self.textField.text.length == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(self.textField);
            }];
            self.label.font = [UIFont systemFontOfSize:14];
        }];
        [self.superview layoutIfNeeded];
    }
}

- (void)setTextValue:(NSString *)textValue {
    _textValue = textValue;
    
    if (textValue.length > 0) {
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.textField);
            make.top.equalTo(self.label.superview).offset(5);
        }];
        self.label.font = [UIFont systemFontOfSize:12];
    }
    self.textField.text = textValue;
}

- (NSString *)textValue {
    return self.textField.text;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.label.text = title;
}

@end
