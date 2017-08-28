//
//  JCDefine.h
//  TestProject
//
//  Created by Jacob on 6/28/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#ifndef JCDefine_h
#define JCDefine_h

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

// 多行文本获取高度
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define multilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define multilineTextSize(text, font, maxSize) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize] : CGSizeZero;
#endif

/////////////////////////////////////////////////////
#pragma mark - Singleton
/////////////////////////////////////////////////////

#define DEFINE_SINGLETON_FOR_HEADER(className) \
+ (className *)sharedInstance;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


#pragma mark - Color

#define UIColorFromRGBA(rgb,a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgb) UIColorFromRGBA(rgb,1.0f)
#define UIColor_RGB(R,G,B) ([UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0])

/////////////////////////////////////////////////////
#pragma mark - Device
/////////////////////////////////////////////////////

#define IS_IOS7_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define IS_IOS8_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define IS_IOS9_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < DBL_EPSILON)

#define kLineColor UIColorFromRGB(0xd5d5d5)
#define kBackgroundColor UIColorFromRGB(0xFAFAFA)
// 主要文字颜色
#define CommonMainFontColor UIColorFromRGBA(0x000000, 0.87)
// 次要文字颜色
#define CommonMinorFontColor UIColorFromRGBA(0x000000, 0.54)
// 左右两边留白
#define kPadding    20

#endif /* JCDefine_h */
