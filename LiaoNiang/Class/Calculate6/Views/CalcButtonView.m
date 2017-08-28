//
//  CalcButtonView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "CalcButtonView.h"

@interface CalcButtonView()

@property (nonatomic, strong) NSString *title;

@end

@implementation CalcButtonView

- (id)initWithTitle:(NSString *)title {
    self.title = title;
    
    return [self initWithFrame:CGRectZero];
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.title.length == 0) {
            self.title = @"计算";
        }
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button = button;
    
    button.layer.cornerRadius = 4;
    
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.superview).offset(kPadding);
        make.right.equalTo(button.superview).offset(-kPadding);
        make.centerY.equalTo(self);
        make.height.equalTo(@40);
    }];
    [button setTitle:self.title forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorFromRGB(0x2591CF)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];

}

@end
