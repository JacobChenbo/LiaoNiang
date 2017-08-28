//
//  WeightAndGrainView.h
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FloatingSelectorView.h"


#import "TitleAndTextFieldView.h"

/**
 *  重量和谷物填写
 */


//------------------------------
//  重量(千克)    请选择谷物🔻
//------------------------------


@interface WeightAndGrainView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) TitleAndTextFieldView *textFieldView;
@property (nonatomic, strong) FloatingSelectorView *floatingView;
@end
