//
//  HXNumericTextField.m
//  HXTestWorkSpace
//
//  Created by Jacob on 16/8/18.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "HXNumericTextField.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface HXNumericTextFieldBuilder ()

@property (nonatomic, assign) BOOL shouldAutoZeroWhenEmpty;

@property (nonatomic, assign) BOOL isFloatNum;
@property (nonatomic, assign) NSUInteger maxFloatPrecision;

@property (nonatomic, assign) BOOL shouldCorrectMaxValue;
@property (nonatomic, assign) double theMaxValue;

@property (nonatomic, assign) BOOL shouldCorrectMaxDigit;
@property (nonatomic, assign) double theMaxDigit;

@end

@implementation HXNumericTextFieldBuilder

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.shouldAutoZeroWhenEmpty = YES;
    self.isFloatNum = NO;
    self.maxFloatPrecision = 300;
    self.shouldCorrectMaxValue = NO;
    self.theMaxValue = MAXFLOAT;
    self.shouldCorrectMaxDigit = NO;
    self.theMaxDigit = 300;
}

- (HXNumericTextFieldBuilder *(^)(BOOL))autoZeroWhenEmpty{
    return ^HXNumericTextFieldBuilder *(BOOL autoZeroWhenEmpty){
        self.shouldAutoZeroWhenEmpty = autoZeroWhenEmpty;
        return self;
    };
}

- (HXNumericTextFieldBuilder *(^)(NSUInteger))floatPrecision{
    return ^HXNumericTextFieldBuilder *(NSUInteger floatPrecision){
        self.isFloatNum = YES;
        self.maxFloatPrecision = floatPrecision<=300?floatPrecision:300;
        return self;
    };
}

- (HXNumericTextFieldBuilder *(^)(double))maxValue{
    return ^HXNumericTextFieldBuilder *(double maxValue){
        self.shouldCorrectMaxValue = YES;
        self.theMaxValue = maxValue;
        return self;
    };
}

- (HXNumericTextFieldBuilder *(^)(NSUInteger))maxDigit{
    return ^HXNumericTextFieldBuilder *(NSUInteger maxDigit){
        self.shouldCorrectMaxDigit = YES;
        self.theMaxDigit = maxDigit<=300?maxDigit:300;
        return self;
    };
}

@end






@interface HXNumericTextField ()

@property (nonatomic, strong) HXNumericTextFieldBuilder *builder;

@property (nonatomic, assign) BOOL autoZeroWhenEmpty;

@property (nonatomic, assign) BOOL isFloatNum;
@property (nonatomic, assign) NSUInteger maxFloatPrecision;

@property (nonatomic, assign) BOOL shouldCorrectMaxValue;
@property (nonatomic, assign) double maxValue;
@property (nonatomic, copy) void(^maxValueDidCorrectedBlock)(double maxValue);

@property (nonatomic, assign) BOOL shouldCorrectDigit;
@property (nonatomic, assign) NSUInteger maxDigit;


@end

@implementation HXNumericTextField

- (instancetype)initWithBuilder:(void (^)(HXNumericTextFieldBuilder *build))configBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        HXNumericTextFieldBuilder *builder = [HXNumericTextFieldBuilder new];
        configBlock(builder);
        self.builder = builder;
        [self commonInit];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithBuilder:^(HXNumericTextFieldBuilder *build) {
    }];
    self.frame = frame;
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInit{
    
    HXNumericTextFieldBuilder *builder = self.builder;
    
    self.autoZeroWhenEmpty = builder.shouldAutoZeroWhenEmpty;
    
    self.isFloatNum = builder.isFloatNum;
    self.maxFloatPrecision = builder.maxFloatPrecision;
    
    self.shouldCorrectMaxValue = builder.shouldCorrectMaxValue;
    self.maxValue = builder.theMaxValue;
    
    self.shouldCorrectDigit = builder.shouldCorrectMaxDigit;
    self.maxDigit = builder.theMaxDigit;
    
    self.maxValueDidCorrectedBlock = builder.maxValueDidCorrectedBlock;
    
    self.builder = nil;
    
    [self makeSignal];
}

static NSCharacterSet* numberSet;

- (void)makeSignal{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * kNumber =@"0123456789.";
        numberSet = [[NSCharacterSet characterSetWithCharactersInString:kNumber]invertedSet];
    });
    
    @weakify(self);
    
    RACSignal *textSignal = self.rac_textSignal;
    
    //整数位数
    RACSignal *intPlaceSignal = [textSignal map:^id(NSString *value) {
        NSArray <NSString *> *numbers = [value componentsSeparatedByString:@"."];
        return @(numbers.firstObject.length);
    }];
    
    //小数位数
    RACSignal *floatPrecisionSignal = [[textSignal takeWhileBlock:^BOOL(id x) {
        @strongify(self);
        return self.isFloatNum;
    }] map:^id(NSString *value) {
        NSArray <NSString *> *numbers = [value componentsSeparatedByString:@"."];
        if (numbers.count == 2) {
            return @(numbers[1].length);
        }
        return @(0);
    }];
    
    //没有字符
    RACSignal *textEmptySignal = [textSignal filter:^BOOL(NSString *value) {
        return !value.length;
    }];
    
    //字符不合法
    RACSignal *textInalidSignal = [textSignal filter:^BOOL(NSString *value) {
        return !([value rangeOfCharacterFromSet:numberSet].location == NSNotFound);
    }];
    
    //以0开始
    RACSignal *textStartWithZeroSingal = [textSignal filter:^BOOL(NSString *value) {
        return [value hasPrefix:@"0"] && value.length > 1 && ![value hasPrefix:@"0."];
    }];
    
    //以.开始
    RACSignal *textStartWithDotSignal = [textSignal filter:^BOOL(NSString *value) {
        return [value hasPrefix:@"."];
    }];

    //.过多
    RACSignal *textDotTooMuchSignal = [textSignal filter:^BOOL(NSString *str) {
        @strongify(self);
        if (!self.isFloatNum) {
            if (!([str rangeOfString:@"."].location == NSNotFound)) {
                return YES;
            }
        }
        
        NSUInteger count = 0, length = [str length];
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound)
        {
            range = [str rangeOfString: @"." options:0 range:range];
            if(range.location != NSNotFound)
            {
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
                count++;
                
                if (count > 1) {
                    return YES;
                }
            }
        }
        return NO;
    }];

    //超出最大值
    double maxValue = self.maxValue;
    RACSignal *correctMaxValueSignal = [[[[[textSignal takeWhileBlock:^BOOL(id x) {
        @strongify(self);
        return self.shouldCorrectMaxValue;
    }]map:^NSNumber *(NSString *value) {
        return @(value.doubleValue);
    }] filter:^BOOL(NSNumber *value) {
        return value.doubleValue > maxValue;
    }] map:^id(id value) {
        return [NSString stringWithFormat:@"%@",@(maxValue)];
    }] doNext:^(id x) {
        @strongify(self);
        !self.maxValueDidCorrectedBlock?:self.maxValueDidCorrectedBlock(maxValue);
    }];
    
    //超出最大整数位数
    NSUInteger maxDigit = self.maxDigit;
    RACSignal *outOfMaxDigitSignal = [[intPlaceSignal takeWhileBlock:^BOOL(id x) {
        @strongify(self);
        return self.shouldCorrectDigit;
    }] filter:^BOOL(NSNumber *value) {
        return [value unsignedIntegerValue] > maxDigit;
    }];
    //超出小数精度
    RACSignal *outOfMaxFloatPrecisionSignal = [floatPrecisionSignal filter:^BOOL(NSNumber *value) {
        @strongify(self);
        return value.unsignedIntegerValue > self.maxFloatPrecision;
    }];
    
    //修正不合法字符
    RACSignal *correctInvalidTextSignal = [textInalidSignal map:^id(NSString *value) {
        return [[value componentsSeparatedByCharactersInSet:numberSet]componentsJoinedByString:@""];
    }];
    //修正0起始
    RACSignal *correctStartZeroSignal = [textStartWithZeroSingal map:^id(NSString *value) {
        return [value substringFromIndex:1];
    }];
    //修正.起始
    RACSignal *correctDotSignal = [textStartWithDotSignal map:^id(NSString *value) {
        return [NSString stringWithFormat:@"0%@",value];
    }];
    //修正过多小数点
    [textDotTooMuchSignal subscribeNext:^(NSString *x) {
        @strongify(self);
        [self deleteBackward];
    }];
    //修正最大位数
    [outOfMaxDigitSignal subscribeNext:^(id x) {
        @strongify(self);
        [self deleteBackward];
    }];
    //修正小数位数
    [outOfMaxFloatPrecisionSignal subscribeNext:^(id x) {
        @strongify(self);
        [self deleteBackward];
    }];
    //修正空
    [[textEmptySignal takeWhileBlock:^BOOL(id x) {
        @strongify(self);
        return self.autoZeroWhenEmpty;
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.text = @"0";
    }];
    
    //修正
    [[RACSignal merge:@[correctInvalidTextSignal,correctMaxValueSignal,correctStartZeroSignal,correctDotSignal]] subscribeNext:^(NSString *x) {
        @strongify(self);
        self.text = x;
    }];
    
}

#pragma mark - Debug

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
}


@end
