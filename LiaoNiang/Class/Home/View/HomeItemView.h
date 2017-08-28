//
//  HomeItemView.h
//  LiaoNiang
//
//  Created by Jacob on 8/23/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateToolModel.h"

@protocol HomeItemViewDelegate <NSObject>

@required
- (void)buttonActionWithTag:(NSInteger)tag;

@end

@interface HomeItemView : UIView

@property (nonatomic, weak) id<HomeItemViewDelegate> delegate;

- (id)initWithCalculateToolModel:(CalculateToolModel *)toolModel;
- (id)initWithIconName:(NSString *)iconName title:(NSString *)title tag:(NSInteger)tag;

@end
