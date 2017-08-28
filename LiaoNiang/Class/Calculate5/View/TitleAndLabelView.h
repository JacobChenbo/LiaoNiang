//
//  TitleAndLabelView.h
//  LiaoNiang
//
//  Created by Jacob on 9/29/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleAndLabelView : UIView

@property (nonatomic, strong) UILabel *value;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) NSString *title;

- (id)initWithTitle:(NSString *)title;

@end
