//
//  Calculate3ItemsView.h
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculate3ItemView.h"

@interface Calculate3ItemsView : UIView

// 这些数组全都是控件的指针引用
@property (nonatomic, strong) NSMutableArray *oz;       // 重量
@property (nonatomic, strong) NSMutableArray *aa;       // a酸
@property (nonatomic, strong) NSMutableArray *time;     // 时间

@property (nonatomic, strong) NSMutableArray *hoptype;  // 类型
@property (nonatomic, strong) NSMutableArray *divutil;
@property (nonatomic, strong) NSMutableArray *divIBU;   // 苦度

@end
