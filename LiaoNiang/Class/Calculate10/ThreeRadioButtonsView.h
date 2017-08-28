//
//  ThreeRadioButtonsView.h
//  LiaoNiang
//
//  Created by Jacob on 16/9/28.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeRadioButtonsView : UIView

@property (nonatomic, copy) void (^selectedIndexDidChangeBlock)(NSInteger index);

@end
