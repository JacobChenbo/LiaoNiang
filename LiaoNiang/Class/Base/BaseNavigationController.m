//
//  BaseNavigationController.m
//  LiaoNiang
//
//  Created by Jacob on 9/14/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.barTintColor = UIColorFromRGB(0x2A2725);
    self.navigationBar.tintColor = UIColorFromRGB(0x2A2725);
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    
    self.navigationBarHidden = YES;
}

@end
