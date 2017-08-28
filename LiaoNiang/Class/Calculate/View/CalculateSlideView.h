//
//  CalculateSlideView.h
//  LiaoNiang
//
//  Created by Jacob on 8/24/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateSlideView : UIView

@property (nonatomic, copy) void (^itemSelectedBlock)(NSInteger index);
- (void)showSlide;
- (void)hideSlide;

@end
