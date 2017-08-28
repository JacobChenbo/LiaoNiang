//
//  LabelCellView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "LabelCellView.h"

@implementation LabelCellView

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
    self.clipsToBounds = YES;
    
    UILabel *textLabel = ({
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = CommonMainFontColor;
        label;
    });
    self.textLabel = textLabel;
    [self addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kPadding);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
