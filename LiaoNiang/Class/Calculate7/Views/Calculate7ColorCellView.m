//
//  Calculate7ColorCellView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/24.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "Calculate7ColorCellView.h"
#import "UIView+JWMasonryConstraint.h"

@implementation Calculate7ColorCellView

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
    UILabel *textLabel = ({
        UILabel *label = [UILabel new];
        label.text = @"近似颜色:";
        [label makeRefuseHuggingAndCompressForAxis:UILayoutConstraintAxisHorizontal];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = CommonMainFontColor;
        label;
    });
    [self addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(kPadding);
    }];
    
    UIView *colorView = [UIView new];
    self.colorView = colorView;
    [self addSubview:colorView]
    ;
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.left.equalTo(textLabel.mas_right);
        make.top.equalTo(self);
    }];
    
}

@end
