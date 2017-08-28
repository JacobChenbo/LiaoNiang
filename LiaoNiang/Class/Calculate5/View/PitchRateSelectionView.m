//
//  PitchRateSelectionView.m
//  LiaoNiang
//
//  Created by Jacob on 9/28/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "PitchRateSelectionView.h"
#import "FloatingSelectorView.h"

@interface PitchRateSelectionView()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *titleValues;

@end

@implementation PitchRateSelectionView

- (id)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UILabel *title1 = [UILabel new];
    [self addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title1.superview).offset(kPadding);
        make.top.equalTo(title1.superview).offset(5);
    }];
    title1.text = @"目标投放率：";
    title1.textColor = CommonMinorFontColor;
    title1.font = [UIFont systemFontOfSize:14];
    
    FloatingSelectorView *sectorView = [[FloatingSelectorView alloc] init];
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        sectorView.tableWidthMultiple = 1.3;
    }
    [self addSubview:sectorView];
    [sectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title1.mas_right).offset(1);
        make.right.equalTo(sectorView.superview).offset(-kPadding);
        make.top.equalTo(sectorView.superview).offset(3);
        make.height.equalTo(@18);
    }];
    sectorView.backgroundColor = [UIColor whiteColor];
    sectorView.titles = self.titles;
    @weakify(self);
    [sectorView setSelectionDidChangeBlock:^(NSString *title, NSInteger index) {
        @strongify(self);
        self.pitchRate = [[self.titleValues objectAtIndex:index] doubleValue];
    }];
    
    UILabel *title1Desc = [UILabel new];
    [self addSubview:title1Desc];
    [title1Desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectorView);
        make.top.equalTo(sectorView.mas_bottom).offset(5);
    }];
    title1Desc.text = @"(百万个细胞 / 毫升 / 单位糖度)";
    title1Desc.textColor = CommonMinorFontColor;
    title1Desc.font = [UIFont systemFontOfSize:14];
    
    UILabel *title2 = [UILabel new];
    [self addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title1);
        make.top.equalTo(title1Desc.mas_bottom).offset(5);
        make.width.equalTo(title1);
    }];
    title2.textColor = CommonMinorFontColor;
    title2.text = @"关于高比重：";
    title2.font = [UIFont systemFontOfSize:14];
    
    UILabel *title2Desc = [UILabel new];
    [self addSubview:title2Desc];
    [title2Desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(title2.mas_right).offset(1).priority(999);
        make.top.equalTo(title2);
        make.right.equalTo(title2Desc.superview).offset(-kPadding);
    }];
    title2Desc.text = @"这里表示比重大于1.060，糖度高000于15P时";
    title2Desc.textColor = CommonMinorFontColor;
    title2Desc.font = [UIFont systemFontOfSize:14];
    title2Desc.numberOfLines = 0;
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bottomView.superview);
        make.top.equalTo(title2Desc.mas_bottom).offset(5);
        make.height.equalTo(@1);
    }];
    self.bottomView = bottomView;
}

- (MASViewAttribute *)suggestedBottom {
    return self.bottomView.mas_bottom;
}

- (NSArray *)titles {
    if (_titles == nil) {
        _titles = @[@"-------------",
                   @"啤酒厂推荐 0.35(艾尔，必须为鲜酵母)",
                   @"啤酒厂推荐 0.5(艾尔，必须为鲜酵母)",
                   @"专业酿造者 0.75(艾尔)",
                   @"啤酒厂推荐 1.0(艾尔，或高比重艾尔)",
                   @"啤酒厂推荐 1.25(艾尔，或高比重艾尔)",
                   @"啤酒厂推荐 1.5(拉格)",
                   @"啤酒厂推荐 1.75(拉格)",
                   @"啤酒厂推荐 2.0(高比重拉格)"];
    }
    return _titles;
}

- (NSArray *)titleValues {
    if (_titleValues == nil) {
        _titleValues = @[@"0",
                         @"0.35",
                         @"0.5",
                         @"0.75",
                         @"1.0",
                         @"1.25",
                         @"1.5",
                         @"1.75",
                         @"2.0"
                         ];
    }
    return _titleValues;
}

@end
