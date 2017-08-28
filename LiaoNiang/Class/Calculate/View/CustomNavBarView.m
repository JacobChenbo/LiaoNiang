//
//  CustomNavBarView.m
//  LiaoNiang
//
//  Created by Jacob on 8/23/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CustomNavBarView.h"
#import "UIImage+SWImage.h"

@interface CustomNavBarView()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView *navView1;

@end

@implementation CustomNavBarView

- (id)init {
    if (self = [super init ]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.frame = CGRectMake(0, 0, kScreenWidth, 64);
    self.backgroundColor = UIColorFromRGB(0x2A2725);
    
    UIView *navView1 = [UIView new];
    [self addSubview:navView1];
    [navView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(navView1.superview);
        make.height.equalTo(@44);
    }];
    self.navView1 = navView1;
    
    UIButton *backButton = [UIButton new];
    [navView1 addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.superview).offset(16);
        make.centerY.equalTo(backButton.superview);
        make.size.mas_equalTo(CGSizeMake(12, 20));
    }];
    [backButton addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    [backButton setBackgroundImage:[UIImage imageNamed:@"MenubarBack"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[[UIImage imageNamed:@"MenubarBack"] imageByApplyingAlpha:0.2] forState:UIControlStateHighlighted];
    self.backButton = backButton;
    
    UILabel *title = [UILabel new];
    [navView1 addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(title.superview);
        make.top.bottom.equalTo(title.superview);
        make.width.equalTo(@180);
    }];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    self.title = title;
}

- (void)updateNavBarWithStatus:(BOOL)isHide {
    if ((!self.title.isHidden && !isHide) || (self.title.isHidden && isHide)) {
        return;
    }
    
    if (isHide) {
        self.backgroundColor = [UIColor clearColor];
        self.title.hidden = YES;
    } else {
        self.backgroundColor = UIColorFromRGB(0x2A2725);
        self.title.hidden = NO;
    }
    
    self.alpha = 0;
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.alpha = 1.0;
    }];
}

- (void)onClickBack {
    if (self.backActionBlock) {
        self.backActionBlock();
    }
}

// 扩大back点击区域

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        return nil;
    }
    
    if (view == self || view == self.navView1) {
        if (self.backButton && point.x <= 80) {
            return self.backButton;
        } else {
            return nil;
        }
    } else {
        return view;
    }
}

@end
