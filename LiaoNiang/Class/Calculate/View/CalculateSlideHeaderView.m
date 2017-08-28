//
//  CalculateSlideHeaderView.m
//  LiaoNiang
//
//  Created by Jacob on 9/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CalculateSlideHeaderView.h"

@implementation CalculateSlideHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = UIColor_RGB(53, 166, 225);
    
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(imageView.superview).offset(kPadding);
//        make.centerY.equalTo(imageView.superview);
//        make.size.mas_equalTo(CGSizeMake(120, 160));
        make.edges.equalTo(imageView.superview);
    }];
    imageView.image = [UIImage imageNamed:@"tool_menu_head"];
    
//    UILabel *title = [UILabel new];
//    [self addSubview:title];
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(imageView.mas_right).offset(10);
//        make.centerY.equalTo(title.superview);
//    }];
//    title.text = @"聊酿计算工具";
//    title.font = [UIFont boldSystemFontOfSize:18];
//    title.textColor = CommonMainFontColor;
}

@end
