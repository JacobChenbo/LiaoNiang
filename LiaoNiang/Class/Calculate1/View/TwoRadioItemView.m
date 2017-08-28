//
//  TwoRadioItemView.m
//  LiaoNiang
//
//  Created by Jacob on 9/5/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "TwoRadioItemView.h"
#import "CustomCheckButton.h"

@interface TwoRadioItemView()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *itemOne;
@property (nonatomic, strong) NSString *itemTwo;
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

@property (nonatomic, strong) CustomCheckButton *checkButtonOne;
@property (nonatomic, strong) CustomCheckButton *checkButtonTwo;

@end

@implementation TwoRadioItemView

- (id)initWithTitle:(NSString *)title itemOne:(NSString *)itemOne itemTwo:(NSString *)itemTwo {
    return [self initWithTitle:title itemOne:itemOne itemTwo:itemTwo defaultSelectedIndex:1];
}

- (id)initWithTitle:(NSString *)title itemOne:(NSString *)itemOne itemTwo:(NSString *)itemTwo defaultSelectedIndex:(NSInteger)index {
    if (self = [super init]) {
        self.title = title;
        self.itemOne = itemOne;
        self.itemTwo = itemTwo;
        self.defaultSelectedIndex = index;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview);
        make.height.equalTo(@38);
    }];
    
    UILabel *titleLabel = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(titleLabel.superview);
        make.left.equalTo(titleLabel.superview).offset(20);
    }];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = CommonMinorFontColor;
    
    CustomCheckButton *checkButtonOne = [[CustomCheckButton alloc] initWithTitle:self.itemOne];
    [contentView addSubview:checkButtonOne];
    [checkButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            make.left.equalTo(titleLabel.mas_right).offset(0);
        } else {
            make.left.equalTo(titleLabel.mas_right).offset(5);
        }
        make.top.bottom.equalTo(checkButtonOne.superview);
        make.right.equalTo(checkButtonOne.mas_right);
    }];
    @weakify(self);
    [checkButtonOne setItemButtonChecked:^{
        @strongify(self);
        [self updateCheckWithCheckItem:self.checkButtonOne];
    }];
    self.checkButtonOne = checkButtonOne;
    
    CustomCheckButton *checkButtonTwo = [[CustomCheckButton alloc] initWithTitle:self.itemTwo];
    [contentView addSubview:checkButtonTwo];
    [checkButtonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            make.left.equalTo(checkButtonOne.mas_right).offset(5);
        } else {
            make.left.equalTo(checkButtonOne.mas_right).offset(10);
        }
        make.top.bottom.equalTo(checkButtonTwo.superview);
        make.right.equalTo(checkButtonTwo.mas_right);
    }];
    [checkButtonTwo setItemButtonChecked:^{
        @strongify(self);
        [self updateCheckWithCheckItem:self.checkButtonTwo];
    }];
    self.checkButtonTwo = checkButtonTwo;
    
    if (self.defaultSelectedIndex == 1) {
        [self.checkButtonOne onClickButton];
    } else {
        [self.checkButtonTwo onClickButton];
    }
}

- (void)updateCheckWithCheckItem:(CustomCheckButton *)checkButton {
    NSInteger index = 1;
    if (checkButton == self.checkButtonOne) {
        [self.checkButtonTwo unSelectedButton];
        index = 1;
    } else {
        [self.checkButtonOne unSelectedButton];
        index = 2;
    }
    
    if (self.itemSelectedIndexBlock) {
        self.itemSelectedIndexBlock(index);
    }
}

- (void)onClickButtonIndex:(NSInteger)index {
    if (index == 1) {
        [self.checkButtonOne onClickButton];
    } else {
        [self.checkButtonTwo onClickButton];
    }
}

@end
