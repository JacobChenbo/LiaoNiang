//
//  Calculate3ItemView.h
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleAndTextFieldView.h"
#import "FloatingSelectorView.h"

@interface Calculate3ItemView : UIView

@property (nonatomic, strong) TitleAndTextFieldView *keView;
@property (nonatomic, strong) TitleAndTextFieldView *secView;
@property (nonatomic, strong) TitleAndTextFieldView *thView;
@property (nonatomic, strong) FloatingSelectorView *floatView;
@property (nonatomic, strong) UILabel *liYongValue;
@property (nonatomic, strong) UILabel *kuDuZhiValue;

- (id)initWithBackgroundColor:(UIColor *)color;

@end
