//
//  CalculateToolModel.h
//  LiaoNiang
//
//  Created by Jacob on 9/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateToolModel : NSObject

@property (nonatomic, strong) NSString *url;   // 图片
@property (nonatomic, strong) NSString *title; // 标题
@property (nonatomic, assign) NSInteger index; // 索引

- (id)initWithUrl:(NSString *)url title:(NSString *)title index:(NSInteger)index;

@end
