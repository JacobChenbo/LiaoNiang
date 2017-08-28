//
//  CustomNavBarView.h
//  LiaoNiang
//
//  Created by Jacob on 8/23/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavBarView : UIView

@property (nonatomic, copy) void (^backActionBlock)();
@property (nonatomic, strong) UILabel *title;
- (void)updateNavBarWithStatus:(BOOL)isHide;

@end
