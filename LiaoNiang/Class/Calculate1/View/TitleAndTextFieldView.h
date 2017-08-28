//
//  TitleAndTextFieldView.h
//  LiaoNiang
//
//  Created by Jacob on 9/6/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleAndTextFieldView : UIView

@property (nonatomic, strong) UITextField *textField;

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title padding:(CGFloat)padding;

@property (nonatomic, strong) NSString *title;

@end
