//
//  Calculate1ResultView.m
//  LiaoNiang
//
//  Created by Jacob on 9/7/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate1ResultView.h"

@interface Calculate1ResultView()

@end

@implementation Calculate1ResultView

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
        make.height.equalTo(@200);
    }];
    
    UIView *topLine = [UIView new];
    [contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(topLine.superview);
        make.height.equalTo(@1);
    }];
//    topLine.backgroundColor = kLineColor;
    
    UILabel *jiuJingDuLabel = [UILabel new];
    [contentView addSubview:jiuJingDuLabel];
    [jiuJingDuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiuJingDuLabel.superview).offset(kPadding);
        make.top.equalTo(jiuJingDuLabel.superview).offset(5);
    }];
    jiuJingDuLabel.text = @"酒精度：";
    jiuJingDuLabel.font = [UIFont boldSystemFontOfSize:14];
    jiuJingDuLabel.textColor = CommonMainFontColor;
    
    UILabel *jiuJingDuValue = [UILabel new];
    [contentView addSubview:jiuJingDuValue];
    [jiuJingDuValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiuJingDuLabel.mas_right).offset(1);
        make.top.bottom.equalTo(jiuJingDuLabel);
    }];
    jiuJingDuValue.font = [UIFont boldSystemFontOfSize:14];
    jiuJingDuValue.textColor = CommonMainFontColor;
    jiuJingDuValue.text = @"4.99%";
    self.jiuJingDuValue = jiuJingDuValue;
    
    UILabel *faXiaoDuLabel = [UILabel new];
    [contentView addSubview:faXiaoDuLabel];
    [faXiaoDuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiuJingDuLabel);
        make.top.equalTo(jiuJingDuLabel.mas_bottom).offset(5);
    }];
    faXiaoDuLabel.text = @"外观发酵度：";
    faXiaoDuLabel.font = [UIFont boldSystemFontOfSize:14];
    faXiaoDuLabel.textColor = CommonMainFontColor;
    
    UILabel *faJiaoDuValue = [UILabel new];
    [contentView addSubview:faJiaoDuValue];
    [faJiaoDuValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(faXiaoDuLabel.mas_right).offset(1);
        make.top.bottom.equalTo(faXiaoDuLabel);
    }];
    faJiaoDuValue.textColor = CommonMainFontColor;
    faJiaoDuValue.font = [UIFont boldSystemFontOfSize:14];
    faJiaoDuValue.text = @"78.5%";
    self.faJiaoDuValue = faJiaoDuValue;
    
    UILabel *kaLuLiLabel = [UILabel new];
    [contentView addSubview:kaLuLiLabel];
    [kaLuLiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiuJingDuLabel);
        make.top.equalTo(faXiaoDuLabel.mas_bottom).offset(5);
    }];
    kaLuLiLabel.text = @"卡路里：";
    kaLuLiLabel.textColor = CommonMainFontColor;
    kaLuLiLabel.font = [UIFont boldSystemFontOfSize:14];
    
    UILabel *kaLuLiValue = [UILabel new];
    [contentView addSubview:kaLuLiValue];
    [kaLuLiValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kaLuLiLabel.mas_right).offset(1);
        make.top.bottom.equalTo(kaLuLiLabel);
    }];
    kaLuLiValue.font = [UIFont boldSystemFontOfSize:14];
    kaLuLiValue.textColor = CommonMainFontColor;
    kaLuLiValue.text = @"157.3 每 330ml bottle";
    self.kaLuLiValue = kaLuLiValue;
    
    UILabel *OGLabel = [UILabel new];
    [contentView addSubview:OGLabel];
    [OGLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiuJingDuLabel);
        make.top.equalTo(kaLuLiLabel.mas_bottom).offset(5);
    }];
    OGLabel.text = @"初始比重：";
    OGLabel.font = [UIFont boldSystemFontOfSize:14];
    OGLabel.textColor = CommonMainFontColor;
    
    UILabel *OGValue = [UILabel new];
    [contentView addSubview:OGValue];
    [OGValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(OGLabel.mas_right).offset(1);
        make.top.bottom.equalTo(OGLabel);
    }];
    OGValue.textColor = CommonMainFontColor;
    OGValue.font = [UIFont boldSystemFontOfSize:14];
    OGValue.text = @"11.91 °P, 1.048";
    self.OGValue = OGValue;
    
    UILabel *FGLabel = [UILabel new];
    [contentView addSubview:FGLabel];
    [FGLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jiuJingDuLabel);
        make.top.equalTo(OGLabel.mas_bottom).offset(5);
    }];
    FGLabel.text = @"终点比重：";
    FGLabel.textColor = CommonMainFontColor;
    FGLabel.font = [UIFont boldSystemFontOfSize:14];
    
    UILabel *FGValue = [UILabel new];
    [contentView addSubview:FGValue];
    [FGValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FGLabel.mas_right).offset(1);
        make.top.bottom.equalTo(FGLabel);
    }];
    FGValue.textColor = CommonMainFontColor;
    FGValue.font = [UIFont boldSystemFontOfSize:14];
    FGValue.text = @"2.56 °P, 1.010";
    self.FGValue = FGValue;
    
    CalcButtonView *button = [CalcButtonView new];
    [contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.superview).offset(0);
        make.right.equalTo(button.superview).offset(-0);
        make.top.equalTo(FGValue.mas_bottom).offset(10);
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
