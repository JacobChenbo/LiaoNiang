//
//  WeightAndGrainView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "WeightAndGrainView.h"

#import "TwoRadioItemView.h"

#import "LabelCellView.h"
#import "CalcButtonView.h"

@implementation WeightAndGrainView

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
    
    UIView *contentView = [UIView new];
    self.contentView = contentView;
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kPadding);
        make.right.equalTo(self).offset(-kPadding);
        make.top.bottom.equalTo(self);
    }];
    
    TitleAndTextFieldView *textFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"重量(千克)"];
    self.textFieldView = textFieldView;
    [self addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(3);
        make.width.equalTo(@150);
    }];
    
    FloatingSelectorView *floatView = [FloatingSelectorView new];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        floatView.tableWidthMultiple = 2.0;
    } else {
        floatView.tableWidthMultiple = 1.5;
    }
    self.floatingView = floatView;
    [self addSubview:floatView];
    [floatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textFieldView.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.height.equalTo(@40);
        
        make.right.equalTo(self).offset(-kPadding-10);
    }];
    
}

@end
