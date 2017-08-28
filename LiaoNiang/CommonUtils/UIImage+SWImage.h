//
//  UIImage+SWImage.h
//  manpower
//
//  Created by WangShunzhou on 14-6-27.
//  Copyright (c) 2014 WangShunzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SWImage)
/**
 *  旋转图片
 *
 *  @param orient 旋转方向
 *
 *  @return UIImage
 */
- (UIImage *)rotate:(UIImageOrientation)orient;

/**
 *  为图片增加透明度
 *
 *  @param alpha 0到1
 *
 *  @return UIImage
 */
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

/**
 *  缩放到指定尺寸
 *
 *  @param size 缩放心墙
 *
 *  @return UIImage
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 *  按比例缩放到指定尺寸
 *
 *  @param targetSize 目标尺寸
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

/**
 *  按比例缩放到最大宽度
 *
 *  @param maxWidth 最大宽度
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingWithMaxWidth:(CGFloat)maxWidth;

/**
 *  生成纯色的UIImage
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageFromColor:(UIColor *)color;
@end
