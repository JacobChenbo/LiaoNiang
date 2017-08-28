//
//  CustomCheckButton.h
//  LiaoNiang
//
//  Created by Jacob on 9/5/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCheckButton : UIView

@property (nonatomic, copy) void (^itemButtonChecked)();
- (id)initWithTitle:(NSString *)title;
- (void)selectedButton;
- (void)onClickButton;
- (void)unSelectedButton;

@end
