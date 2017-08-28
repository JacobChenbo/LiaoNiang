//
//  CalculateSlideCell.h
//  LiaoNiang
//
//  Created by Jacob on 9/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculateToolModel.h"

@interface CalculateSlideCell : UITableViewCell

@property (nonatomic, strong) CalculateToolModel *toolModel;

+ (CalculateSlideCell *)cellWithTableView:(UITableView *)tableView;

@end
