//
//  TitleAndLabelView.m
//  LiaoNiang
//
//  Created by Jacob on 9/29/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "TitleAndLabelView.h"

@interface TitleAndLabelView()

@end

@implementation TitleAndLabelView

- (id)initWithTitle:(NSString *)title {
    if (self = [super init]) {
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
//        make.height.equalTo(@25);
    }];
    
    UILabel *title = [UILabel new];
    [contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.superview).offset(kPadding);
        make.centerY.equalTo(title.superview);
    }];
    title.text = self.title;
    title.textColor = CommonMinorFontColor;
    title.font = [UIFont systemFontOfSize:14];
    title.numberOfLines = 0;
    self.titleLable = title;
    
    UILabel *value = [UILabel new];
    [contentView addSubview:value];
    [value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).offset(1);
        make.right.equalTo(value.superview).offset(-kPadding);
        make.top.bottom.equalTo(value.superview);
    }];
    value.textColor = CommonMainFontColor;
    value.font = [UIFont boldSystemFontOfSize:14];
    value.textAlignment = NSTextAlignmentRight;
    value.numberOfLines = 0;
    self.value = value;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLable.text = title;
}

@end
