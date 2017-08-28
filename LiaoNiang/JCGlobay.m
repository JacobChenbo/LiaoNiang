//
//  JCGlobay.m
//  LiaoNiang
//
//  Created by Jacob on 9/12/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "JCGlobay.h"
#import "CalculateToolModel.h"

@implementation JCGlobay

DEFINE_SINGLETON_FOR_CLASS(JCGlobay)

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (double)roundDecimal:(double)plato number:(NSInteger)places {
    if (places < 0) {
        return 0;
    }
    if (places > 10) {
        return 0;
    }
    
    double rounded = round(plato * pow(10, places)) / pow(10, places);
    NSString *stringRounded = [NSString stringWithFormat:@"%f", rounded];
    NSInteger decimalPointPosition = 0;
    
    NSRange decimalPointRange = [stringRounded rangeOfString:@"."];
    if (decimalPointRange.location == NSNotFound) {
        decimalPointPosition = -1;
    } else {
        decimalPointPosition = decimalPointRange.location;
    }
    
    if (decimalPointPosition == 0) {
        stringRounded = [NSString stringWithFormat:@"0%@", stringRounded];
        decimalPointPosition = 1;
    }
    
    if (places != 0) {
        decimalPointRange = [stringRounded rangeOfString:@"."];
        if (decimalPointRange.location == NSNotFound) {
            decimalPointPosition = -1;
        } else {
            decimalPointPosition = decimalPointRange.location;
        }
        
        if (decimalPointPosition == -1) {
            stringRounded = [NSString stringWithFormat:@"%@%@", stringRounded, @"."];
        }
    }
    
    decimalPointPosition = [stringRounded rangeOfString:@"."].location;
    NSInteger currentPlaces = stringRounded.length - 1 - decimalPointPosition;
    
    if (currentPlaces < places) {
        for (NSInteger i = currentPlaces; i < places; i++) {
            stringRounded = [NSString stringWithFormat:@"%@0", stringRounded];
        }
    }
    
    return [stringRounded doubleValue];
}

- (UIViewController *)currentViewController {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView;
    for (UIView *view in [window subviews]) {
        if ([view isKindOfClass: NSClassFromString(@"UILayoutContainerView")] || [view isKindOfClass: NSClassFromString(@"UITransitionView")]) {
            frontView = view;
        }
    }
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIWindow class]]) {
        nextResponder = [nextResponder rootViewController];
        result = nextResponder;
        if ([nextResponder isKindOfClass:[UITabBarController class]]) {
            nextResponder = [nextResponder selectedViewController];
            result = nextResponder;
            if ([nextResponder isKindOfClass:[UINavigationController class]]) {
                result = [nextResponder topViewController];
                if ([result presentedViewController]) {
                    nextResponder = result.presentedViewController;
                    result = result.presentedViewController;
                    if ([nextResponder isKindOfClass:[UINavigationController class]]) {
                        result = [nextResponder topViewController];
                    }
                }
            }
        }
    } else if ([nextResponder isKindOfClass:[UITabBarController class]]){
        nextResponder = [nextResponder selectedViewController];
        result = nextResponder;
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            result = [nextResponder topViewController];
        }
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        result = [nextResponder topViewController];
    } else if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    } else {
        result = nil;
    }
    
    return result;
}

- (void)showErrorMessage:(NSString *)message {
    [self showErrorTitle:@"" message:message button1:@""];
}

- (void)showErrorTitle:(NSString *)title message:(NSString *)message button1:(NSString *)button1 {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // create actions
    if (button1.length == 0) {
        button1 = @"确定";
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:button1 style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    
    }];
    
    [alertController addAction:cancelAction];

    [[self currentViewController] presentViewController:alertController animated:YES completion:nil];
}

- (NSArray *)calculateTools {
    if (_calculateTools == nil) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        CalculateToolModel *model1 = [[CalculateToolModel alloc] initWithUrl:@"jiujing" title:@"酒精度预测" index:1];
        [tempArray addObject:model1];
        
        CalculateToolModel *model2 = [[CalculateToolModel alloc] initWithUrl:@"sedu" title:@"色度计算" index:7];
        [tempArray addObject:model2];
        
        CalculateToolModel *model3 = [[CalculateToolModel alloc] initWithUrl:@"kudu" title:@"苦度计算" index:3];
        [tempArray addObject:model3];
        
        CalculateToolModel *model4 = [[CalculateToolModel alloc] initWithUrl:@"tanghua" title:@"糖化效率计算" index:9];
        [tempArray addObject:model4];
        
        CalculateToolModel *model5 = [[CalculateToolModel alloc] initWithUrl:@"wendu" title:@"比重温度校准" index:2];
        [tempArray addObject:model5];
        
        CalculateToolModel *model6 = [[CalculateToolModel alloc] initWithUrl:@"maizhi" title:@"麦汁比重调整" index:4];
        [tempArray addObject:model6];
        
        CalculateToolModel *model7 = [[CalculateToolModel alloc] initWithUrl:@"jiaomu" title:@"酵母括培计算" index:5];
        [tempArray addObject:model7];
        
        CalculateToolModel *model8 = [[CalculateToolModel alloc] initWithUrl:@"yongshui" title:@"糖化用水计算" index:8];
        [tempArray addObject:model8];
        
        CalculateToolModel *model9 = [[CalculateToolModel alloc] initWithUrl:@"huansuan" title:@"酒精度换算" index:6];
        [tempArray addObject:model9];
        
        CalculateToolModel *model10 = [[CalculateToolModel alloc] initWithUrl:@"tanhua" title:@"碳化体积计算" index:10];
        [tempArray addObject:model10];
        
        _calculateTools = tempArray;
    }
    
    return _calculateTools;
}

@end
