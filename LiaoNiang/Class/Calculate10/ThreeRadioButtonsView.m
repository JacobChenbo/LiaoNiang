//
//  ThreeRadioButtonsView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/28.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "ThreeRadioButtonsView.h"
#import "RadioButton.h"
#import "UIView+JWMasonryConstraint.h"

@implementation ThreeRadioButtonsView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    RadioButton *button0 = [RadioButton new];
    button0.textLabel.text = @"Gyle";
    button0.selected = YES;
    [self addSubview:button0];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kPadding);
        make.centerY.equalTo(self);
    }];
    
    RadioButton *button1 = [RadioButton new];
    button1.textLabel.text = @"Gyle w/ different OG/FG";
    [self addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button0.mas_right).offset(3);
        make.centerY.equalTo(self);
    }];
    
    RadioButton *button2 = [RadioButton new];
    button2.textLabel.text = @"Krauseing";
    [self addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button1.mas_right).offset(3);
        make.centerY.equalTo(self);
    }];
    
    button0.tag = 10000;
    button1.tag = 10001;
    button2.tag = 10002;

    
    @weakify(button0,button1,button2);
    void (^buttonEvent)(RadioButton *) = ^void(RadioButton *sender){
        @strongify(button0,button1,button2);
        button0.selected = NO;
        button1.selected = NO;
        button2.selected = NO;
        
        sender.selected = YES;
        
        !self.selectedIndexDidChangeBlock?:self.selectedIndexDidChangeBlock(sender.tag - 10000);
        
    };
    
    [button0 bk_addEventHandler:buttonEvent forControlEvents:UIControlEventTouchUpInside];
    [button1 bk_addEventHandler:buttonEvent forControlEvents:UIControlEventTouchUpInside];
    [button2 bk_addEventHandler:buttonEvent forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Debug

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
}


@end
