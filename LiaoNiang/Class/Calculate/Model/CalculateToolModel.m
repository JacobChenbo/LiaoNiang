//
//  CalculateToolModel.m
//  LiaoNiang
//
//  Created by Jacob on 9/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CalculateToolModel.h"

@implementation CalculateToolModel

- (id)initWithUrl:(NSString *)url title:(NSString *)title index:(NSInteger)index {
    if (self = [super init]) {
        self.url = url;
        self.title = title;
        self.index = index;
    }
    return self;
}

@end
