//
//  Calculate3ResultView.m
//  LiaoNiang
//
//  Created by Jacob on 9/20/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate3ResultView.h"

@implementation Calculate3ResultView

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *OGLabel = [UILabel new];
    [self addSubview:OGLabel];
    [OGLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(OGLabel.superview).offset(kPadding);
        make.top.equalTo(OGLabel.superview).offset(5);
        make.height.equalTo(@20);
    }];
    OGLabel.text = @"煮沸前比重(估算值)：";
    OGLabel.textColor = CommonMainFontColor;
    OGLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *OGValue = [UILabel new];
    [self addSubview:OGValue];
    [OGValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(OGLabel.mas_right).offset(0);
        make.top.bottom.equalTo(OGLabel);
    }];
    OGValue.textColor = CommonMainFontColor;
    OGValue.font = [UIFont systemFontOfSize:14];
    OGValue.text = @"1.043";
    self.OGValue = OGValue;
    
    UILabel *kuduLabel = [UILabel new];
    [self addSubview:kuduLabel];
    [kuduLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(OGLabel);
        make.top.equalTo(OGLabel.mas_bottom).offset(5);
        make.height.equalTo(@20);
    }];
    kuduLabel.text = @"总苦度值：";
    kuduLabel.textColor = CommonMainFontColor;
    kuduLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel *kuduValue = [UILabel new];
    [self addSubview:kuduValue];
    [kuduValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kuduLabel.mas_right);
        make.top.bottom.equalTo(kuduLabel);
    }];
    kuduValue.textColor = CommonMainFontColor;
    kuduValue.font = [UIFont systemFontOfSize:14];
    kuduValue.text = @"0.00";
    self.kuduValue = kuduValue;
    
    UIButton *calButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:calButton];
    [calButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kuduLabel);
        make.top.equalTo(kuduLabel.mas_bottom).offset(8);
        make.height.equalTo(@40);
        make.right.equalTo(calButton.superview.mas_centerX).offset(-5);
    }];
    [calButton setTitle:@"计算" forState:UIControlStateNormal];
    calButton.backgroundColor = UIColorFromRGB(0x2591CF);
    [calButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    calButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [calButton addTarget:self action:@selector(onClickCalButton) forControlEvents:UIControlEventTouchUpInside];
    calButton.layer.cornerRadius = 4.0;
    calButton.layer.masksToBounds = YES;
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:resetButton];
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(resetButton.superview.mas_centerX).offset(5);
        make.top.equalTo(kuduLabel.mas_bottom).offset(8);
        make.height.equalTo(@40);
        make.right.equalTo(calButton.superview).offset(-kPadding);
    }];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setBackgroundColor:UIColorFromRGB(0x2591CF)];
    [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [resetButton addTarget:self action:@selector(onClickResetButton) forControlEvents:UIControlEventTouchUpInside];
    resetButton.layer.cornerRadius = 4.0;
    resetButton.layer.masksToBounds = YES;
}

- (void)onClickCalButton {
    if (self.onClickCalculateBlock) {
        self.onClickCalculateBlock();
    }
}

- (void)onClickResetButton {
    if (self.onClickResetBlock) {
        self.onClickResetBlock();
    }
}

@end
