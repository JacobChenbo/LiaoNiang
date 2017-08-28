//
//  UIResponder+FirstResponder.m
//  LiaoNiang
//
//  Created by Jacob on 9/9/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "UIResponder+FirstResponder.h"
static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
