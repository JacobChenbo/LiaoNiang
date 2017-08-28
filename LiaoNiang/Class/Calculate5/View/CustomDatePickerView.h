//
//  CustomDatePickerView.h
//  LiaoNiang
//
//  Created by Jacob on 10/11/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDatePickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) void (^datePickerSelectedBlock)(NSString *stringDate);
@property (nonatomic, copy) void (^datePickerCancelBlock)();

@end
