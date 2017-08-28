//
//  YeastTypeView.h
//  LiaoNiang
//
//  Created by Jacob on 9/28/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNoneReuseAutoHeightTabelView.h"
#import "FloatLabelTextField.h"
@class TitleAndTextFieldView;

@interface YeastTypeView : UIView

@property (nonatomic, copy) void (^yeastTypeChangedBlock)(NSString *type, CGFloat height);
@property (nonatomic, strong) NSString *yeastType;
@property (nonatomic, strong) TitleAndTextFieldView *textField1;
@property (nonatomic, strong) FloatLabelTextField *textField2;
@property (nonatomic, strong) UILabel *viabilityValue;

@end
