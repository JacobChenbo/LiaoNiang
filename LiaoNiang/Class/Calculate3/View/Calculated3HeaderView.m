//
//  Calculated3HeaderView.m
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculated3HeaderView.h"

@implementation Calculated3HeaderView

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
        make.edges.equalTo(contentView.superview).insets(UIEdgeInsetsMake(0, kPadding, 0, kPadding));
        make.height.equalTo(@60);
    }];
    
    TitleAndTextFieldView *zhuFeiView = [[TitleAndTextFieldView alloc] initWithTitle:@"煮沸量(升)" padding:0];
    zhuFeiView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    zhuFeiView.textField.text = @"0";
    [contentView addSubview:zhuFeiView];
    [zhuFeiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(zhuFeiView.superview);
        make.width.equalTo(zhuFeiView.superview).multipliedBy(0.25).offset(-8);
    }];
    zhuFeiView.textField.text = @"27";
    self.zhuFeiView = zhuFeiView;
    
    TitleAndTextFieldView *piCiView = [[TitleAndTextFieldView alloc] initWithTitle:@"批次量(升)" padding:0];
    piCiView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    piCiView.textField.text = @"0";
    [contentView addSubview:piCiView];
    [piCiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhuFeiView.mas_right).offset(8);
        make.top.bottom.width.equalTo(zhuFeiView);
    }];
    piCiView.textField.text = @"21";
    self.piCiView = piCiView;
    
    NSString *targetTitle = @"目标初始比重(OG)(格式 1.xxx)";
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        targetTitle = @"目标初始比重(OG)(1.xxx)";
    }
    
    TitleAndTextFieldView *targetOGView = [[TitleAndTextFieldView alloc] initWithTitle:targetTitle padding:0];
    targetOGView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    targetOGView.textField.text = @"0";
    [contentView addSubview:targetOGView];
    [targetOGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(piCiView.mas_right).offset(8);
        make.right.top.bottom.equalTo(targetOGView.superview);
    }];
    targetOGView.textField.text = @"1.055";
    self.targetOGView = targetOGView;
}

@end
