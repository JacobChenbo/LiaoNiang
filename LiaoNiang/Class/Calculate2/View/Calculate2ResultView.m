//
//  Calculate2ResultView.m
//  LiaoNiang
//
//  Created by Jacob on 9/12/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate2ResultView.h"

@interface Calculate2ResultView()

@end

@implementation Calculate2ResultView

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
        make.height.equalTo(@80);
    }];
    
    UIView *topLine = [UIView new];
    [contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(topLine.superview);
        make.height.equalTo(@1);
    }];
    //    topLine.backgroundColor = kLineColor;
    
    UILabel *jiaoZhengZhiLabel = [UILabel new];
    [contentView addSubview:jiaoZhengZhiLabel];
    [jiaoZhengZhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiaoZhengZhiLabel.superview).offset(kPadding);
        make.top.equalTo(jiaoZhengZhiLabel.superview).offset(5);
    }];
    jiaoZhengZhiLabel.text = @"校正值：";
    jiaoZhengZhiLabel.font = [UIFont boldSystemFontOfSize:14];
    jiaoZhengZhiLabel.textColor = CommonMainFontColor;
    
    UILabel *jiaoZhengZhiValue = [UILabel new];
    [contentView addSubview:jiaoZhengZhiValue];
    [jiaoZhengZhiValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiaoZhengZhiLabel.mas_right).offset(1);
        make.top.bottom.equalTo(jiaoZhengZhiLabel);
    }];
    jiaoZhengZhiValue.font = [UIFont boldSystemFontOfSize:14];
    jiaoZhengZhiValue.textColor = CommonMainFontColor;
    self.jiaoZhengZhiValue = jiaoZhengZhiValue;
    
    CalcButtonView *button = [CalcButtonView new];
    [contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.superview).offset(0);
        make.right.equalTo(button.superview).offset(-0);
        make.top.equalTo(jiaoZhengZhiValue.mas_bottom).offset(10);
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
