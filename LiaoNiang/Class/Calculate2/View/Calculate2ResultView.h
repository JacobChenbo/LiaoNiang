//
//  Calculate2ResultView.h
//  LiaoNiang
//
//  Created by Jacob on 9/12/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculate2ResultView : UIView

@property (nonatomic, strong) UILabel *jiaoZhengZhiValue;
@property (nonatomic, copy) void (^onClickButtonBlock)();

@end
