//
//  FloatLabelTextField.h
//  LiaoNiang
//
//  Created by Jacob on 9/20/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatLabelTextField : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *textValue;
@property (nonatomic, assign) BOOL secureTextEntry;

- (id)initWithTitle:(NSString *)title;

@end
