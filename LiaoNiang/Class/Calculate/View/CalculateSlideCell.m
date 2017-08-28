//
//  CalculateSlideCell.m
//  LiaoNiang
//
//  Created by Jacob on 9/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "CalculateSlideCell.h"

@interface CalculateSlideCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleText;

@end

@implementation CalculateSlideCell

+ (CalculateSlideCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"calculateSlideCell";
    CalculateSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CalculateSlideCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        selectedView.backgroundColor = UIColorFromRGB(0x909090);
        cell.selectedBackgroundView = selectedView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.backgroundColor = UIColorFromRGB(0x464646);
    
    UIImageView *imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.superview).offset(kPadding);
        make.centerY.equalTo(imageView.superview);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.icon = imageView;
    
    UILabel *titleText = [UILabel new];
    [self.contentView addSubview:titleText];
    [titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(kPadding);
        make.centerY.equalTo(titleText.superview);
    }];
    titleText.textColor = [UIColor whiteColor];
    titleText.font = [UIFont systemFontOfSize:16];
    self.titleText = titleText;
    
    UIView *line = [UIView new];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(line.superview);
        make.height.equalTo(@1);
    }];
    line.backgroundColor = UIColorFromRGB(0x2A2725);
}

- (void)setToolModel:(CalculateToolModel *)toolModel {
    _toolModel = toolModel;
    
    self.icon.image = [UIImage imageNamed:toolModel.url];
    self.titleText.text = toolModel.title;
}

@end
