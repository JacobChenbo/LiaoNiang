//
//  CustomDatePickerView.m
//  LiaoNiang
//
//  Created by Jacob on 10/11/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CustomDatePickerView.h"

@implementation CustomDatePickerView

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kScreenHeight - 260, kScreenWidth, 260);
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    UIView *containerView = [[UIView alloc] init];
    [self addSubview:containerView];
    containerView.tag = 200;
    containerView.frame = CGRectMake(0, 0, kScreenWidth, 260);
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    [containerView addSubview:topView];
    topView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    
    //取消   确定按钮
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:cancleButton];
    [cancleButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton sizeToFit];
    [cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancleButton.frame = CGRectMake(0, (44 - cancleButton.height) / 2, 80, cancleButton.height);
    
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [topView addSubview:commitButton];
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton sizeToFit];
    [commitButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    commitButton.frame = CGRectMake(kScreenWidth - 80 , (44 - commitButton.height) / 2, 80, commitButton.height);
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
    [datePicker setLocale:locale];
    datePicker.datePickerMode =   UIDatePickerModeDate;
    datePicker.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:datePicker];
    datePicker.frame = CGRectMake(0, 44, kScreenWidth, 216);
    self.datePicker = datePicker;
}

- (void)cancleAction {
    if (self.datePickerCancelBlock) {
        self.datePickerCancelBlock();
    }
}

- (void)commitAction {
    NSDate *date = _datePicker.date;
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy/MM/dd";
    NSString *str = [fmt stringFromDate:date];
    
    if (self.datePickerSelectedBlock) {
        self.datePickerSelectedBlock(str);
    }
}

@end
