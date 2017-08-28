//
//  SecondStepItemView.h
//  LiaoNiang
//
//  Created by Jacob on 10/8/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculate4HeaderView.h"
#import "FloatLabelTextField.h"
#import "FloatingSelectorView.h"
#import "CalcButtonView.h"
#import "TitleAndLabelView.h"

@interface SecondStepItemView : UIView

@property (nonatomic, strong) FloatLabelTextField *biZhongView;
@property (nonatomic, strong) FloatLabelTextField *kuoPeiLiangView;
@property (nonatomic, strong) NSString *growthMethodSelected;
@property (nonatomic, strong) CalcButtonView *buttonView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) TitleAndLabelView *label1;
@property (nonatomic, strong) TitleAndLabelView *label2;
@property (nonatomic, strong) TitleAndLabelView *label3;
@property (nonatomic, strong) TitleAndLabelView *label4;
@property (nonatomic, strong) TitleAndLabelView *label5;

- (id)initWithTitle:(NSString *)title;

@end
