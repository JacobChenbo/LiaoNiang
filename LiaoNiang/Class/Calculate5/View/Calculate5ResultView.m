//
//  Calculate5ResultView.m
//  LiaoNiang
//
//  Created by Jacob on 9/29/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate5ResultView.h"
#import "CalcButtonView.h"

@implementation Calculate5ResultView

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    TitleAndLabelView *label1 = [[TitleAndLabelView alloc] initWithTitle:@"可用细胞数："];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(label1.superview);
        make.height.equalTo(@25);
    }];
    self.label1 = label1;
    
    TitleAndLabelView *label2 = [[TitleAndLabelView alloc] initWithTitle:@"酵母投放率："];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label2.superview);
        make.top.equalTo(label1.mas_bottom);
        make.height.equalTo(@25);
    }];
    self.label2 = label2;
    
    TitleAndLabelView *label3 = [[TitleAndLabelView alloc] initWithTitle:@"目标投放率细胞数量："];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label3.superview);
        make.top.equalTo(label2.mas_bottom);
        make.height.equalTo(@25);
    }];
    self.label3 = label3;
    
    TitleAndLabelView *label4 = [[TitleAndLabelView alloc] initWithTitle:@"差值："];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label4.superview);
        make.top.equalTo(label3.mas_bottom);
        make.height.equalTo(@25);
    }];
    self.label4 = label4;
    
    CalcButtonView *button = [CalcButtonView new];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.superview).offset(0);
        make.right.equalTo(button.superview).offset(-0);
        make.top.equalTo(label4.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    [button.button addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickButton {
    if (self.calButtonClickBlock) {
        self.calButtonClickBlock();
    }
}

@end
