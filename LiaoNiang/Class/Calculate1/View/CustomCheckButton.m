//
//  CustomCheckButton.m
//  LiaoNiang
//
//  Created by Jacob on 9/5/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CustomCheckButton.h"

@interface CustomCheckButton()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIButton *button;

@end

@implementation CustomCheckButton

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
    }];
    
    UIImageView *icon = [UIImageView new];
    [contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon.superview);
        make.left.equalTo(icon.superview).offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    icon.image = [UIImage imageNamed:@"RadioButtonNormal"];
    self.icon = icon;
    
    CGSize size = multilineTextSize(self.title, [UIFont systemFontOfSize:14], CGSizeMake(MAXFLOAT, MAXFLOAT))
    
    UILabel *title = [UILabel new];
    [contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(title.superview);
        if(IS_IPHONE_5 || IS_IPHONE_4) {
            make.left.equalTo(icon.mas_right).offset(5);
        } else {
            make.left.equalTo(icon.mas_right).offset(10);
        }
        make.width.equalTo(@(size.width + 1));
    }];
    title.text = self.title;
    title.textColor = CommonMainFontColor;
    title.font = [UIFont systemFontOfSize:14];
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(title.mas_right).offset(5);
    }];
    
    UIButton *button = [UIButton new];
    [contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(button.superview);
    }];
    [button addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
}

- (void)onClickButton {
    [self selectedButton];
    
    if (self.itemButtonChecked) {
        self.itemButtonChecked();
    }
}

- (void)selectedButton {
    self.button.selected = YES;
    self.icon.image = [UIImage imageNamed:@"RadioButtonSelected"];
}

- (void)unSelectedButton {
    self.button.selected = NO;
    self.icon.image = [UIImage imageNamed:@"RadioButtonNormal"];
}

@end
