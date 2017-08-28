//
//  Calculate4Result2View.m
//  LiaoNiang
//
//  Created by Jacob on 9/13/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate4Result2View.h"

@implementation Calculate4Result2View

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview);
        make.height.equalTo(@120);
    }];
    
    UIView *topLine = [UIView new];
    [contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(topLine.superview);
        make.height.equalTo(@1);
    }];
    //    topLine.backgroundColor = kLineColor;
    
    UILabel *newTiJiLabel = [UILabel new];
    [contentView addSubview:newTiJiLabel];
    [newTiJiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newTiJiLabel.superview).offset(kPadding);
        make.top.equalTo(newTiJiLabel.superview).offset(5);
    }];
    newTiJiLabel.text = @"新比重：";
    newTiJiLabel.font = [UIFont boldSystemFontOfSize:14];
    newTiJiLabel.textColor = CommonMainFontColor;
    
    UILabel *newTiJiValue = [UILabel new];
    [contentView addSubview:newTiJiValue];
    [newTiJiValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newTiJiLabel.mas_right).offset(1);
        make.top.bottom.equalTo(newTiJiLabel);
    }];
    newTiJiValue.font = [UIFont boldSystemFontOfSize:14];
    newTiJiValue.textColor = CommonMainFontColor;
    self.biZhongValue = newTiJiValue;
    
    UILabel *differenceLabel = [UILabel new];
    [contentView addSubview:differenceLabel];
    [differenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newTiJiLabel);
        make.top.equalTo(newTiJiLabel.mas_bottom).offset(5);
    }];
    differenceLabel.text = @"差异：";
    differenceLabel.font = [UIFont boldSystemFontOfSize:14];
    differenceLabel.textColor = CommonMainFontColor;
    
    UILabel *differenceValue = [UILabel new];
    [contentView addSubview:differenceValue];
    [differenceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(differenceLabel.mas_right).offset(1);
        make.top.bottom.equalTo(differenceLabel);
    }];
    differenceValue.textColor = CommonMainFontColor;
    differenceValue.font = [UIFont boldSystemFontOfSize:14];
    self.differenceValue = differenceValue;
    
    CalcButtonView *button = [CalcButtonView new];
    [contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.superview).offset(0);
        make.right.equalTo(button.superview).offset(-0);
        make.top.equalTo(differenceValue.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    [button.button addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickButton {
    if (self.onClickButtonBlock) {
        self.onClickButtonBlock();
    }
}


@end
