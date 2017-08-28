//
//  CheckBoxCellView.m
//  LiaoNiang
//
//  Created by Jacob on 2016/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "CheckBoxCellView.h"
#import "RadioButton.h"

@interface CheckBoxCellView ()

@end

@implementation CheckBoxCellView

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
    RadioButton *radioButton = [RadioButton new];
    self.radioButton = radioButton;

    [radioButton.radioImageView setImage:[UIImage imageNamed:@"redcheck"]];
    [radioButton.radioImageView setHighlightedImage:[UIImage imageNamed:@"redchecked"]];
    [self addSubview:radioButton];
    [radioButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kPadding);
    }];

    @weakify(self);
    [radioButton bk_addEventHandler:^(RadioButton *sender) {
        @strongify(self);
        sender.selected = !sender.selected;
        
        !self.checkedDidChangeBlock?:self.checkedDidChangeBlock(sender.selected);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)checked{
    return  self.radioButton.selected;
}

- (void)setChecked:(BOOL)checked{
    self.radioButton.selected = checked;
}

@end
