//
//  HXNoneReuseAutoHeightTabelView.h
//  HXMall
//
//  Created by MacBook on 15/9/25.
//  Copyright (c) 2015年 HXQC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry/Masonry.h"

@protocol HXNoneReuseTableViewAutoHeight <NSObject>

- (MASViewAttribute *)suggestedBottom;

@end

@interface HXNoneReuseAutoHeightTabelView : UIView

@property (nonatomic, assign) CGFloat cellHeight;//默认cell高度

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIView *contentView;

//自动高度
- (void)addAutoHeightCellView:(UIView<HXNoneReuseTableViewAutoHeight> *)cellView;

//手动高度
- (void)addCellView:(UIView *)cellView cellHeight:(CGFloat)cellHeight;
- (void)addCellView:(UIView *)cellView;

//重设高度
- (BOOL)resetCellHeight:(CGFloat)height atRow:(NSInteger)row animated:(BOOL)animated;

- (BOOL)resetHeightOfCellView:(UIView *)cellView withHeight:(CGFloat)height animated:(BOOL)animated;

@end
