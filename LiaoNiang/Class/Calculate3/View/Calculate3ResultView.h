//
//  Calculate3ResultView.h
//  LiaoNiang
//
//  Created by Jacob on 9/20/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Calculate3ResultView : UIView

@property (nonatomic, strong) UILabel *OGValue;
@property (nonatomic, strong) UILabel *kuduValue;

@property (nonatomic, copy) void (^onClickCalculateBlock)();
@property (nonatomic, copy) void (^onClickResetBlock)();

@end
