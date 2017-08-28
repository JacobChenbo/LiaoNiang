//
//  Calculate5ResultView.h
//  LiaoNiang
//
//  Created by Jacob on 9/29/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleAndLabelView.h"

@interface Calculate5ResultView : UIView

@property (nonatomic, strong) TitleAndLabelView *label1;
@property (nonatomic, strong) TitleAndLabelView *label2;
@property (nonatomic, strong) TitleAndLabelView *label3;
@property (nonatomic, strong) TitleAndLabelView *label4;

@property (nonatomic, copy) void (^calButtonClickBlock)();

@end
