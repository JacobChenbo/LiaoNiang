//
//  Calculate4HeaderView.m
//  LiaoNiang
//
//  Created by Jacob on 9/13/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate4HeaderView.h"

@interface Calculate4HeaderView()

@property (nonatomic, strong) NSString *title;

@end

@implementation Calculate4HeaderView

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
        make.edges.equalTo(contentView.superview).insets(UIEdgeInsetsMake(10, 20, 10, 20)).priority(999);
    }];
    contentView.backgroundColor = UIColorFromRGB(0xE2E2E2);
    
    UILabel *titleLabel = [UILabel new];
    self.titleLabel = titleLabel;
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLabel.superview);
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = CommonMainFontColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
}

@end
