//
//  FloatingSelectorView.h
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingSelectorView : UIView

@property (nonatomic, copy) NSArray <NSString *> *titles;
@property (nonatomic, assign) CGFloat tableWidthMultiple;

@property (nonatomic, copy) void (^selectionDidChangeBlock)(NSString *title,NSInteger index);

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger index;

@end
