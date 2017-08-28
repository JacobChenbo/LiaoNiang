//
//  BaseTabBarController.m
//  TestProject
//
//  Created by Jacob on 8/8/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseCalculateViewController.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "PersonalViewController.h"

@implementation BaseTabBarController

- (id)init {
    if (self = [super init]) {
        [self setupViewControllers];
    }
    return self;
}

- (void)setupViewControllers {
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    bgView.backgroundColor = UIColorFromRGB(0x2A2725);
    [self.tabBar insertSubview:bgView atIndex:0];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"计算工具"
                                                    image:[[UIImage imageNamed:@"calSel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                            selectedImage:[[UIImage imageNamed:@"cal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *homeNav = [[BaseNavigationController alloc] initWithRootViewController:home];
    
    PersonalViewController *personal = [[PersonalViewController alloc] init];
    personal.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的酒"
                                                   image:[[UIImage imageNamed:@"me1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                           selectedImage:[[UIImage imageNamed:@"meSe1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    BaseNavigationController *nav4 = [[BaseNavigationController alloc] initWithRootViewController:personal];
    
    [home.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateSelected];
    [personal.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateSelected];
    
    [self setViewControllers:@[homeNav, nav4]];
}

@end
