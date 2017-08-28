//
//  SecondStepView.m
//  LiaoNiang
//
//  Created by Jacob on 10/8/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "SecondStepView.h"
#import "SecondStepItemView.h"

@interface SecondStepView()

@property (nonatomic, strong) UIView *lastView;

@end

@implementation SecondStepView

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *title = [UILabel new];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(title.superview);
        make.top.equalTo(title.superview).offset(20);
    }];
    title.font = [UIFont boldSystemFontOfSize:17];
    title.text = @"第二步：如果需要，可以进行扩培";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = CommonMainFontColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(button.superview).offset(-kPadding);
        make.top.equalTo(title.mas_bottom).offset(10);
        make.height.equalTo(@45);
        make.width.equalTo(@100);
    }];
    [button setTitle:@"从上表获得" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorFromRGB(0x2591CF)];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.layer.cornerRadius = 4.0;
    [button addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    FloatLabelTextField *startYeast = [[FloatLabelTextField alloc] initWithTitle:@"起始酵母数量(十亿个细胞)："];
    [self addSubview:startYeast];
    [startYeast mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startYeast.superview).offset(kPadding);
        make.right.equalTo(button.mas_left).offset(-15);
        make.top.equalTo(title.mas_bottom).offset(5);
        make.height.equalTo(@60);
    }];
    startYeast.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.startYeast = startYeast;
    
    SecondStepItemView *item1View = [[SecondStepItemView alloc] initWithTitle:@"扩培一"];
    [self addSubview:item1View];
    [item1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item1View.superview);
        make.top.equalTo(startYeast.mas_bottom).offset(0);
        make.bottom.equalTo(item1View.mas_bottom);
    }];
    [item1View.buttonView.button addTarget:self action:@selector(onClickCalButton) forControlEvents:UIControlEventTouchUpInside];
    
    SecondStepItemView *item2View = [[SecondStepItemView alloc] initWithTitle:@"扩培二"];
    [self addSubview:item2View];
    [item2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item2View.superview);
        make.top.equalTo(item1View.mas_bottom).offset(0);
        make.bottom.equalTo(item2View.mas_bottom);
    }];
    [item2View.buttonView.button addTarget:self action:@selector(onClickCalButton) forControlEvents:UIControlEventTouchUpInside];
    item2View.bgView.backgroundColor = UIColorFromRGB(0xEEEEEE);
    
    SecondStepItemView *item3View = [[SecondStepItemView alloc] initWithTitle:@"扩培三"];
    [self addSubview:item3View];
    [item3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item3View.superview);
        make.top.equalTo(item2View.mas_bottom).offset(0);
        make.bottom.equalTo(item3View.mas_bottom);
    }];
    [item3View.buttonView.button addTarget:self action:@selector(onClickCalButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lastView = [UIView new];
    [self addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lastView.superview);
        make.top.equalTo(item3View.mas_bottom).offset(20);
        make.height.equalTo(@1);
    }];
    self.lastView = lastView;
    
    [self.secondStepData addObject:item1View];
    [self.secondStepData addObject:item2View];
    [self.secondStepData addObject:item3View];
}

- (void)onClickButton {
    if (self.dataFromAboveBlock) {
        self.dataFromAboveBlock();
    }
}

- (void)onClickCalButton {
    if (self.calButtonClickBlock) {
        self.calButtonClickBlock();
    }
}

- (MASViewAttribute *)suggestedBottom {
    return self.lastView.mas_bottom;
}

- (NSMutableArray *)secondStepData {
    if (_secondStepData == nil) {
        _secondStepData = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _secondStepData;
}

@end
