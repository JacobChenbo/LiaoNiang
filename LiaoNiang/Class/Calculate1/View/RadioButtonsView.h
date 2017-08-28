//
//  RadioButtonsView.h
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButtonsView : UIView

- (instancetype)initWithTitle:(NSString *)title titles:(NSArray <NSString *> *)titles defaultSelectedIndex:(NSInteger)index;

@property (nonatomic, copy) void (^selectedIndexDidChangeBlock)(RadioButtonsView *);

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;

@end
