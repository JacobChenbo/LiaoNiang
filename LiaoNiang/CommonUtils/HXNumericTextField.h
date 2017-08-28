//
//  HXNumericTextField.h
//  HXTestWorkSpace
//
//  Created by Jacob on 16/8/18.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface HXNumericTextFieldBuilder : NSObject

@property (nonatomic, copy) void(^maxValueDidCorrectedBlock)(double maxValue);//最大值被纠正回调(eg:提示用户已输入最大值)

- (HXNumericTextFieldBuilder *(^)(BOOL))autoZeroWhenEmpty;//自动归零,默认为YES,删除全部字符后置为0,类似于计算器
- (HXNumericTextFieldBuilder *(^)(NSUInteger))floatPrecision;//浮点精度,设置后将自动纠正,超出精度的输入无效.取值范围:[0,300],超出无效.
- (HXNumericTextFieldBuilder *(^)(double))maxValue;//最大值,设置后将自动纠正,超出最大值时自动置为最大值,可能会造成用户困扰,建议使用最大位数'maxDigit'进行取值范围限制
- (HXNumericTextFieldBuilder *(^)(NSUInteger))maxDigit;//最大位数,设置后将自动纠正,超出最大位数的输入无效.取值范围:[0,300],超出无效.

@end






@interface HXNumericTextField : UITextField

- (instancetype)initWithBuilder:(void(^)(HXNumericTextFieldBuilder *build))config NS_DESIGNATED_INITIALIZER;

@end
