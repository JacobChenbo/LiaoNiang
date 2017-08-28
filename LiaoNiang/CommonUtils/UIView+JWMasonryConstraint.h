//
//  UIView+JWMasonryConstraint.h
//  JWMasonryConstraint
//
//  Created by Jacob on 6/18/15.
//  Copyright (c) 2015 XieJunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JWEqualWidthConstraint)

-(void)makeEqualWidthViews:(NSArray *)views;

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding;

-(void)makeEqualWidthViews:(NSArray *)views
                 TBpadding:(CGFloat)TBpadding;

-(void)makeEqualWidthViews:(NSArray *)views
              viewPadding :(CGFloat)viewPadding;

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding
              viewPadding :(CGFloat)viewPadding;

-(void)makeEqualWidthViews:(NSArray *)views
                 LRpadding:(CGFloat)LRpadding//Left & Right
                 TBpadding:(CGFloat)TBpadding//Top & Bottom
              viewPadding :(CGFloat)viewPadding;

/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         views array
 *  @param leftPadding   左边距
 *  @param rightPadding  右边距
 *  @param topPadding    上边距
 *  @param bottomPadding 下边距
 *  @param viewPadding   view之间的边距
 */
-(void)makeEqualWidthViews:(NSArray *)views
               LeftPadding:(CGFloat)leftPadding
              RightPadding:(CGFloat)rightPadding
                TopPadding:(CGFloat)topPadding
             BottomPadding:(CGFloat)bottomPadding
              viewPadding :(CGFloat)viewPadding;

@end


@interface UIView (JWEqualHeightConstraint)

-(void)makeEqualHeightViews:(NSArray *)views;

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding;

-(void)makeEqualHeightViews:(NSArray *)views
                  TBpadding:(CGFloat)TBpadding;

-(void)makeEqualHeightViews:(NSArray *)views
               viewPadding :(CGFloat)viewPadding;

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding
               viewPadding :(CGFloat)viewPadding;

-(void)makeEqualHeightViews:(NSArray *)views
                  LRpadding:(CGFloat)LRpadding//Left & Right
                  TBpadding:(CGFloat)TBpadding//Top & Bottom
               viewPadding :(CGFloat)viewPadding;

/**
 *  将若干view等高布局于容器containerView中
 *
 *  @param views         views array
 *  @param leftPadding   左边距
 *  @param rightPadding  右边距
 *  @param topPadding    上边距
 *  @param bottomPadding 下边距
 *  @param viewPadding   view之间的边距
 */
-(void)makeEqualHeightViews:(NSArray *)views
                LeftPadding:(CGFloat)leftPadding
               RightPadding:(CGFloat)rightPadding
                 TopPadding:(CGFloat)topPadding
              BottomPadding:(CGFloat)bottomPadding
               viewPadding :(CGFloat)viewPadding;
@end


@interface UIView (JWCoverConstraint)

- (void)jw_makeCoverOnView:(UIView *)superView;

@end


@interface UIView (JWEqualWidthHeightConstraint)

- (void)makeEqualWidthHeightViews:(NSArray *)views numberOfRows:(NSInteger)rows;

- (void)makeEqualWidthHeightViews:(NSArray *)views
                     numberOfRows:(NSInteger)rows
              viewVertivalPadding:(CGFloat)viewVertivalPadding
               viewHorizenPadding:(CGFloat)viewHorizenPadding
                           insets:(UIEdgeInsets)insets;

- (void)makeEqualWidthHeightViews:(NSArray *)views
                  numberOfColumns:(NSInteger)columns
              viewVertivalPadding:(CGFloat)viewVertivalPadding
               viewHorizenPadding:(CGFloat)viewHorizenPadding
                           insets:(UIEdgeInsets)insets;

/**
 *  将若干view等宽等高布局于容器containerView中
 *
 *  @param views               views array
 *  @param rows                总行数
 *  @param columns             总列数
 *  @param viewVertivalPadding view之间的横向间距
 *  @param viewHorizenPadding  view之间的纵向间距
 *  @param insets              边距
 */
- (void)makeEqualWidthHeightViews:(NSArray *)views
                     numberOfRows:(NSInteger)rows
                  numberOfColumns:(NSInteger)columns
              viewVertivalPadding:(CGFloat)viewVertivalPadding
               viewHorizenPadding:(CGFloat)viewHorizenPadding
                           insets:(UIEdgeInsets)insets;


@end



@interface UIView (JWConstraitCommonCalcMethod)

/**
 *  计算应有多少行
 *
 *  @param count   总数
 *  @param columns 列数
 *
 *  @return 行数
 */
+ (NSInteger)numberOfRowsWithItemCount:(NSInteger)count numberOfColumns:(NSInteger)columns;

/**
 *  计算应有多少列
 *
 *  @param count 总数
 *  @param rows  行数
 *
 *  @return 列数
 */
+ (NSInteger)numberOfColumnsWithItemCount:(NSInteger)count numberOfRows:(NSInteger)rows;

/**
 *  计算cellView的长度
 *
 *  @param viewLength       容器宽度
 *  @param numberOfCellView 子视图数量
 *  @param sidePadding      边距
 *  @param otherSidePadding 另一边距
 *  @param viewPadding      子视图间距
 *
 *  @return 子视图长度
 */
+ (CGFloat)cellViewLengthWithViewLength:(CGFloat)viewLength
                       numberOfCellView:(NSInteger)numberOfCellView
                            sidePadding:(CGFloat)sidePadding
                       otherSidePadding:(CGFloat)otherSidePadding
                            viewPadding:(CGFloat)viewPadding;

/**
 *  计算总长度
 *
 *  @param cellViewLength   子视图长度
 *  @param numberOfCellView 子视图数量
 *  @param sidePadding      边距
 *  @param otherSidePadding 另一边距
 *  @param viewPadding      子视图间距
 *
 *  @return 容器总长度
 */
+ (CGFloat)viewLengthWithCellViewLength:(CGFloat)cellViewLength
                       numberOfCellView:(NSInteger)numberOfCellView
                            sidePadding:(CGFloat)sidePadding
                       otherSidePadding:(CGFloat)otherSidePadding
                            viewPadding:(CGFloat)viewPadding;

@end

// //////////////////////////////////////////////////////////////////////////


@interface UIView (JWLayoutPriority)

/**
 *  让视图拒绝被拉伸和压缩
 *
 *  @param axis 方向
 */
- (void)makeRefuseHuggingAndCompressForAxis:(UILayoutConstraintAxis)axis;

@end



@interface UIView (RemoveAllConstraints)

/**
 *  移除全部约束
 */
- (void)jw_removeAllConstraints;

@end




@interface NSArray (RemoveAllConstraints)

/**
 *  移除全部约束
 */
- (void)jw_removeAllConstraints;

@end

