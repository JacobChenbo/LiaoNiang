//
//  BaseViewController.h
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *navTitle;

- (BOOL)needBackButton;

- (void)addLeftBarTitle:(NSString *)title target:(id)target sel:(SEL)sel;

- (void)addRightBarTitle:(NSString *)title target:(id)target sel:(SEL)sel;

- (void)showLoadingViewWithTitle:(NSString *)title;

- (void)hideLoadingView;

@end
