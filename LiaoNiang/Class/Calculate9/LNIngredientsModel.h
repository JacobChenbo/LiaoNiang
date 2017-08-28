//
//  LNIngredientsModel.h
//
//  Created by 俊伟 谢 on 16/9/18
//  Copyright (c) 2016 HXQC. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LNIngredientsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double ppg;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double mashable;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) double lovibond;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
