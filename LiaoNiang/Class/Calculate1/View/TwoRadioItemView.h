//
//  TwoRadioItemView.h
//  LiaoNiang
//
//  Created by Jacob on 9/5/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoRadioItemView : UIView

@property (nonatomic, copy) void (^itemSelectedIndexBlock)(NSInteger index);

- (id)initWithTitle:(NSString *)title itemOne:(NSString *)itemOne itemTwo:(NSString *)itemTwo;

- (id)initWithTitle:(NSString *)title itemOne:(NSString *)itemOne itemTwo:(NSString *)itemTwo defaultSelectedIndex:(NSInteger)index;

- (void)onClickButtonIndex:(NSInteger)index;

@end
