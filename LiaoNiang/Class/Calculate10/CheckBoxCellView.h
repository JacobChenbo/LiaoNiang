//
//  CheckBoxCellView.h
//  LiaoNiang
//
//  Created by Jacob on 2016/10/16.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioButton;

@interface CheckBoxCellView : UIView

@property (nonatomic, strong) RadioButton *radioButton;

@property (nonatomic, assign) BOOL checked;

@property (nonatomic, copy) void (^checkedDidChangeBlock)(BOOL checked);

@end
