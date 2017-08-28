//
//  RadioButtonsView.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "RadioButtonsView.h"

#import "RadioButton.h"
#import "UIView+JWMasonryConstraint.h"
@interface RadioButtonsView ()

@property (nonatomic, strong) NSArray <RadioButton *> *buttons;
@end

@implementation RadioButtonsView

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray <NSString *> *)titles defaultSelectedIndex:(NSInteger)index;
{
    self = [super init];
    if (self) {
        _selectedIndex = -1;
        self.title = title;
        self.titles = titles;
        [self setupViews];
        self.selectedIndex = index;
    }
    return self;
}

- (void)setupViews{
    UILabel *titleLabel = ({
        UILabel *label = [UILabel new];
        [label makeRefuseHuggingAndCompressForAxis:UILayoutConstraintAxisHorizontal];
        label.text = self.title;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = UIColorFromRGBA(0x0, 0.54);
        label;
    });
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kPadding);
        make.top.equalTo(self).offset(8);
    }];
    
    UIView *radioButtonsView = [UIView new];
    [self addSubview:radioButtonsView];
    [radioButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(5);
        make.top.bottom.right.equalTo(self);
    }];
    
    @weakify(self);
    NSArray *buttons = [self.titles bk_map:^id(NSString *title) {
        RadioButton *button = [[RadioButton alloc] init];
        button.textLabel.text = title;
        [button bk_addEventHandler:^(RadioButton *sender) {
            @strongify(self);
            self.selectedIndex = [self.buttons indexOfObject:sender];
        } forControlEvents:UIControlEventTouchUpInside];
        
        return button;
    }];
    self.buttons = buttons;
    [radioButtonsView makeEqualHeightViews:buttons];
}

- (void)unselectAllButtons{
    for (RadioButton *button in self.buttons) {
        button.selected = NO;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex == _selectedIndex || selectedIndex<0 || selectedIndex > self.buttons.count) {
        return;
    }
    [self unselectAllButtons];
    self.buttons[selectedIndex].selected = YES;
    _selectedIndex = selectedIndex;
    !self.selectedIndexDidChangeBlock?:self.selectedIndexDidChangeBlock(self);
}

@end
