//
//  Calculate1ResultView.h
//  LiaoNiang
//
//  Created by Jacob on 9/7/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculate1ResultView : UIView

@property (nonatomic, copy) void (^onClickButtonBlock)();

@property (nonatomic, strong) UILabel *jiuJingDuValue;
@property (nonatomic, strong) UILabel *faJiaoDuValue;
@property (nonatomic, strong) UILabel *kaLuLiValue;
@property (nonatomic, strong) UILabel *OGValue;
@property (nonatomic, strong) UILabel *FGValue;

@end
