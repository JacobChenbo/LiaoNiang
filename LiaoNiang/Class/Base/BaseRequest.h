//
//  BaseRequest.h
//  LiaoNiang
//
//  Created by Jacob on 9/21/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

@property (nonatomic, copy) void (^successWithNetwork)(id response);
@property (nonatomic, copy) void (^failedWithType)(NSInteger type);     // 0 网络错误，1 解析错误

- (id)initWithSoapBody:(NSString *)soapBody soapAction:(NSString *)soapAction;

- (void)startWithPost;

@end
