//
//  NSString+LNHelper.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/22.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "NSString+LNHelper.h"

@implementation NSString (LNHelper)

- (BOOL)isNumber{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    BOOL isNumeric = [scanner scanDouble:NULL] && [scanner isAtEnd];
    return isNumeric;
}

@end
