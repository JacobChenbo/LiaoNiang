//
//  Calculate3ItemView.m
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate3ItemView.h"

@interface Calculate3ItemView()

@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation Calculate3ItemView

- (id)initWithBackgroundColor:(UIColor *)color {
    if (self = [super init]) {
        self.bgColor = color;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview).insets(UIEdgeInsetsMake(5, kPadding - 3, 5, kPadding - 3));
        make.height.equalTo(@80);
    }];
    contentView.backgroundColor = self.bgColor;
    
    TitleAndTextFieldView *keView = [[TitleAndTextFieldView alloc] initWithTitle:@"克" padding:0];
    keView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    keView.textField.text = @"0";
    [contentView addSubview:keView];
    [keView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(keView.superview).offset(3);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    self.keView = keView;
    
    TitleAndTextFieldView *secView = [[TitleAndTextFieldView alloc] initWithTitle:@"阿尔法酸" padding:0];
    secView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    secView.textField.text = @"0";
    [contentView addSubview:secView];
    [secView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(keView.mas_right).offset(8);
        make.top.height.equalTo(keView);
        make.width.equalTo(@75);
    }];
    self.secView = secView;
    
    TitleAndTextFieldView *thView = [[TitleAndTextFieldView alloc] initWithTitle:@"煮沸时间" padding:0];
    thView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    thView.textField.text = @"0";
    [contentView addSubview:thView];
    [thView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secView.mas_right).offset(8);
        make.top.height.equalTo(keView);
        make.width.equalTo(@75);
    }];
    self.thView = thView;
    
    FloatingSelectorView *floatView = [FloatingSelectorView new];
//    self.floatingView = floatView;
    [contentView addSubview:floatView];
    [floatView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(floatView.superview).offset(5);
        make.height.equalTo(@20);
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            make.left.equalTo(thView.mas_right).offset(0);
        } else {
            make.left.equalTo(thView.mas_right).offset(8);
        }
        make.width.equalTo(@60);
    }];
    floatView.titles = @[@"颗粒", @"整花"];
    self.floatView = floatView;
    
    UILabel *liYongLabel = [UILabel new];
    [contentView addSubview:liYongLabel];
    [liYongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keView.mas_bottom);
        make.bottom.equalTo(liYongLabel.superview);
        make.left.equalTo(keView);
    }];
    liYongLabel.text = @"利用:";
    liYongLabel.textColor = CommonMainFontColor;
    liYongLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *liYongValue = [UILabel new];
    [contentView addSubview:liYongValue];
    [liYongValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(liYongLabel.mas_right);
        make.top.bottom.equalTo(liYongLabel);
    }];
    liYongValue.text = @"0.0000";
    liYongValue.textColor = CommonMainFontColor;
    liYongValue.font = [UIFont systemFontOfSize:14];
    self.liYongValue = liYongValue;
    
    UILabel *kuDUZhiLabel = [UILabel new];
    [contentView addSubview:kuDUZhiLabel];
    [kuDUZhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(liYongValue.mas_right).offset(30);
        make.top.bottom.equalTo(liYongLabel);
    }];
    kuDUZhiLabel.text = @"苦度值IBU:";
    kuDUZhiLabel.textColor = CommonMainFontColor;
    kuDUZhiLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *kuDuZhiValue = [UILabel new];
    [contentView addSubview:kuDuZhiValue];
    [kuDuZhiValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kuDUZhiLabel.mas_right);
        make.top.bottom.equalTo(kuDUZhiLabel);
    }];
    kuDuZhiValue.text = @"0.00";
    kuDuZhiValue.textColor = CommonMainFontColor;
    kuDuZhiValue.font = [UIFont systemFontOfSize:14];
    self.kuDuZhiValue = kuDuZhiValue;
}

@end
