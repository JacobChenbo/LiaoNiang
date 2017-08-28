//
//  HomeItemView.m
//  LiaoNiang
//
//  Created by Jacob on 8/23/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "HomeItemView.h"

@interface HomeItemView()

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger buttonTag;

@end

@implementation HomeItemView

- (id)initWithCalculateToolModel:(CalculateToolModel *)toolModel {
    if (self = [super init]) {
        self.iconName = toolModel.url;
        self.title = toolModel.title;
        self.buttonTag = toolModel.index;
        [self setupViews];
    }
    return self;
}

- (id)initWithIconName:(NSString *)iconName title:(NSString *)title tag:(NSInteger)tag {
    if (self = [super init]) {
        self.iconName = iconName;
        self.title = title;
        self.buttonTag = tag;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, kScreenWidth / 3, (kScreenHeight - 64 - 44) / 4);
    
    UIImageView *icon = [UIImageView new];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(icon.superview);
        make.centerY.equalTo(icon.superview.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    icon.image = [UIImage imageNamed:self.iconName];
    
    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom);
        make.bottom.equalTo(titleLabel.superview);
        make.left.equalTo(titleLabel.superview).offset(16);
        make.right.equalTo(titleLabel.superview).offset(-16);
    }];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    
    UIButton *button = [UIButton new];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(button.superview);
    }];
    button.tag = self.buttonTag;
    [button addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickButton:(UIButton *)button {
    NSInteger buttonTag = button.tag;
    if ([self.delegate respondsToSelector:@selector(buttonActionWithTag:)]) {
        [self.delegate buttonActionWithTag:buttonTag];
    }
}

@end
