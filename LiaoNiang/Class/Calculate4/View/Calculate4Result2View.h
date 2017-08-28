//
//  Calculate4Result2View.h
//  LiaoNiang
//
//  Created by Jacob on 9/13/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculate4Result2View : UIView

@property (nonatomic, copy) void (^onClickButtonBlock)();

@property (nonatomic, strong) UILabel *biZhongValue;
@property (nonatomic, strong) UILabel *differenceValue;

@end
