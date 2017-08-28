//
//  LNIngredientsModel.m
//
//  Created by 俊伟 谢 on 16/9/18
//  Copyright (c) 2016 HXQC. All rights reserved.
//

#import "LNIngredientsModel.h"


NSString *const kLNIngredientsModelPpg = @"ppg";
NSString *const kLNIngredientsModelId = @"id";
NSString *const kLNIngredientsModelMashable = @"mashable";
NSString *const kLNIngredientsModelName = @"name";
NSString *const kLNIngredientsModelCategory = @"category";
NSString *const kLNIngredientsModelLovibond = @"lovibond";


@interface LNIngredientsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LNIngredientsModel

@synthesize ppg = _ppg;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize mashable = _mashable;
@synthesize name = _name;
@synthesize category = _category;
@synthesize lovibond = _lovibond;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.ppg = [[self objectOrNilForKey:kLNIngredientsModelPpg fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kLNIngredientsModelId fromDictionary:dict] doubleValue];
            self.mashable = [[self objectOrNilForKey:kLNIngredientsModelMashable fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kLNIngredientsModelName fromDictionary:dict];
            self.category = [self objectOrNilForKey:kLNIngredientsModelCategory fromDictionary:dict];
            self.lovibond = [[self objectOrNilForKey:kLNIngredientsModelLovibond fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ppg] forKey:kLNIngredientsModelPpg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kLNIngredientsModelId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mashable] forKey:kLNIngredientsModelMashable];
    [mutableDict setValue:self.name forKey:kLNIngredientsModelName];
    [mutableDict setValue:self.category forKey:kLNIngredientsModelCategory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lovibond] forKey:kLNIngredientsModelLovibond];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.ppg = [aDecoder decodeDoubleForKey:kLNIngredientsModelPpg];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kLNIngredientsModelId];
    self.mashable = [aDecoder decodeDoubleForKey:kLNIngredientsModelMashable];
    self.name = [aDecoder decodeObjectForKey:kLNIngredientsModelName];
    self.category = [aDecoder decodeObjectForKey:kLNIngredientsModelCategory];
    self.lovibond = [aDecoder decodeDoubleForKey:kLNIngredientsModelLovibond];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_ppg forKey:kLNIngredientsModelPpg];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kLNIngredientsModelId];
    [aCoder encodeDouble:_mashable forKey:kLNIngredientsModelMashable];
    [aCoder encodeObject:_name forKey:kLNIngredientsModelName];
    [aCoder encodeObject:_category forKey:kLNIngredientsModelCategory];
    [aCoder encodeDouble:_lovibond forKey:kLNIngredientsModelLovibond];
}

- (id)copyWithZone:(NSZone *)zone
{
    LNIngredientsModel *copy = [[LNIngredientsModel alloc] init];
    
    if (copy) {

        copy.ppg = self.ppg;
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.mashable = self.mashable;
        copy.name = [self.name copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
        copy.lovibond = self.lovibond;
    }
    
    return copy;
}


@end
