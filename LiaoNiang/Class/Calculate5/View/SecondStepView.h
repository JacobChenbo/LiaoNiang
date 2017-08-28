//
//  SecondStepView.h
//  LiaoNiang
//
//  Created by Jacob on 10/8/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNoneReuseAutoHeightTabelView.h"
#import "FloatLabelTextField.h"

@interface SecondStepView : UIView<HXNoneReuseTableViewAutoHeight>

@property (nonatomic, strong) FloatLabelTextField *startYeast;
@property (nonatomic, strong) NSMutableArray *secondStepData;

@property (nonatomic, copy) void (^dataFromAboveBlock)();
@property (nonatomic, copy) void (^calButtonClickBlock)();

@end
