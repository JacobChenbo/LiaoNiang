//
//  SecondStepItemView.m
//  LiaoNiang
//
//  Created by Jacob on 10/8/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "SecondStepItemView.h"

@interface SecondStepItemView()

@property (nonatomic, strong) NSString *title;

@end

@implementation SecondStepItemView

- (id)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview);
        make.width.equalTo(@(kScreenWidth));
    }];
    
    UIView *bgView = [UIView new];
    [contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgView.superview).insets(UIEdgeInsetsMake(0, 17, 0, 17));
    }];
    self.bgView = bgView;
    
    Calculate4HeaderView *headerTitleView = [[Calculate4HeaderView alloc] initWithTitle:self.title];
    [contentView addSubview:headerTitleView];
    [headerTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(headerTitleView.superview);
        make.height.equalTo(@45);
    }];
    
    FloatLabelTextField *biZhongView = [[FloatLabelTextField alloc] initWithTitle:@"比重(°P)："];
    [contentView addSubview:biZhongView];
    [biZhongView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerTitleView.mas_bottom).offset(-10);
        make.left.equalTo(biZhongView.superview).offset(kPadding);
        make.height.equalTo(@60);
        make.width.equalTo(@((kScreenWidth - 40 - 20) / 3.0));
    }];
    biZhongView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.biZhongView = biZhongView;
    
    FloatLabelTextField *kuoPeiLiangView = [[FloatLabelTextField alloc] initWithTitle:@"扩培量(升)："];
    [contentView addSubview:kuoPeiLiangView];
    [kuoPeiLiangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(biZhongView.mas_right).offset(10);
        make.width.top.bottom.equalTo(biZhongView);
    }];
    kuoPeiLiangView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.kuoPeiLiangView = kuoPeiLiangView;
    
    FloatingSelectorView *selectorView = [[FloatingSelectorView alloc] init];
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        selectorView.tableWidthMultiple = 2.0;
    } else {
        selectorView.tableWidthMultiple = 1.6;
    }
    [contentView addSubview:selectorView];
    [selectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kuoPeiLiangView.mas_right).offset(10);
        make.top.bottom.equalTo(kuoPeiLiangView);
        make.right.equalTo(selectorView.superview).offset(-kPadding);
    }];
    selectorView.titles = @[@"Braukaiser-Stirplate", @"无搅拌", @"搅拌", @"磁力搅拌器"];
    @weakify(self);
    self.growthMethodSelected = @"Braukaiser-Stirplate";
    [selectorView setSelectionDidChangeBlock:^(NSString *title, NSInteger index) {
        @strongify(self);
        self.growthMethodSelected = title;
    }];
    
    CalcButtonView *calButton = [CalcButtonView new];
    [contentView addSubview:calButton];
    [calButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(calButton.superview);
        make.top.equalTo(biZhongView.mas_bottom).offset(5);
        make.height.equalTo(@40);
    }];
    self.buttonView = calButton;
    
    TitleAndLabelView *label1 = [[TitleAndLabelView alloc] initWithTitle:@"干麦精量："];
    [contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label1.superview);
        make.top.equalTo(calButton.mas_bottom).offset(10);
        make.height.equalTo(@25);
    }];
    label1.value.adjustsFontSizeToFitWidth = YES;
    self.label1 = label1;
    
    TitleAndLabelView *label2 = [[TitleAndLabelView alloc] initWithTitle:@"繁殖率："];
    [contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label2.superview);
        make.top.equalTo(label1.mas_bottom).offset(0);
        make.height.equalTo(@25);
    }];
    label2.value.adjustsFontSizeToFitWidth = YES;
    self.label2 = label2;
    
    TitleAndLabelView *label3 = [[TitleAndLabelView alloc] initWithTitle:@"扩培细胞数："];
    [contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label3.superview);
        make.top.equalTo(label2.mas_bottom).offset(0);
        make.height.equalTo(@25);
    }];
    label3.value.adjustsFontSizeToFitWidth = YES;
    self.label3 = label3;
    
    TitleAndLabelView *label4 = [[TitleAndLabelView alloc] initWithTitle:@"扩培投放率细胞数量："];
    [contentView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label4.superview);
        make.top.equalTo(label3.mas_bottom).offset(0);
        make.height.equalTo(@25);
    }];
    label4.value.adjustsFontSizeToFitWidth = YES;
    self.label4 = label4;
    
    TitleAndLabelView *label5 = [[TitleAndLabelView alloc] initWithTitle:@"扩培结果："];
    [contentView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(label5.superview);
        make.top.equalTo(label4.mas_bottom).offset(0);
        make.height.equalTo(@60);
        make.bottom.equalTo(label5.superview).offset(-5);
    }];
    label5.value.numberOfLines = 0;
    label5.value.adjustsFontSizeToFitWidth = YES;
    self.label5 = label5;
}

@end
