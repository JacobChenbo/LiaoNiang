//
//  RadioButton.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "RadioButton.h"
#import "UIView+JWMasonryConstraint.h"

@interface RadioButton ()


@end

@implementation RadioButton

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
    
    UIImageView *radioImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RadioButtonNormal"] highlightedImage:[UIImage imageNamed:@"RadioButtonSelected"]];
    self.radioImageView = radioImageView;
    [self addSubview:radioImageView];
    [radioImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(radioImageView.image.size);
        make.centerY.equalTo(self);
        make.left.equalTo(self);
    }];
    
    UILabel *textLabel = ({
        UILabel *label = [UILabel new];
        [label makeRefuseHuggingAndCompressForAxis:UILayoutConstraintAxisHorizontal];
        if (IS_IPHONE_5 || IS_IPHONE_4) {
            label.font = [UIFont systemFontOfSize:12];
        } else {
            label.font = [UIFont systemFontOfSize:14];
        }
        label.textColor = UIColorFromRGBA(0x0, 0.54);
        label;
    });
    self.textLabel = textLabel;
    [self addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        if (IS_IPHONE_4 || IS_IPHONE_5) {
            make.left.equalTo(radioImageView.mas_right).offset(2);
        } else {
            make.left.equalTo(radioImageView.mas_right).offset(5);
        }
        make.right.equalTo(self).priority(999);
    }];
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(10+5+self.textLabel.intrinsicContentSize.width, 40);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.radioImageView.highlighted = selected;
}

#pragma mark - Debug

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
}


@end
