//
//  JCGlobay.h
//  LiaoNiang
//
//  Created by Jacob on 9/12/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCGlobay : NSObject

@property (nonatomic, strong) NSArray *calculateTools; // 所有计算工具

DEFINE_SINGLETON_FOR_HEADER(JCGlobay);

- (double)roundDecimal:(double)plato number:(NSInteger)places;

- (UIViewController *)currentViewController;

- (void)showErrorMessage:(NSString *)message;

- (void)showErrorTitle:(NSString *)title message:(NSString *)message button1:(NSString *)button1;

@end
