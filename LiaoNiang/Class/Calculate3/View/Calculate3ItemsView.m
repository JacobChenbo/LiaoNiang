//
//  Calculate3ItemsView.m
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate3ItemsView.h"

@implementation Calculate3ItemsView

- (id)init {
    if (self = [super init]) {
        self.oz = [[NSMutableArray alloc] initWithCapacity:6];
        self.aa = [[NSMutableArray alloc] initWithCapacity:6];
        self.time = [[NSMutableArray alloc] initWithCapacity:6];
        self.hoptype = [[NSMutableArray alloc] initWithCapacity:6];
        self.divutil = [[NSMutableArray alloc] initWithCapacity:6];
        self.divIBU = [[NSMutableArray alloc] initWithCapacity:6];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    Calculate3ItemView *item1 = [[Calculate3ItemView alloc] initWithBackgroundColor:UIColorFromRGB(0xEEEEEE)];
    [self addSubview:item1];
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(item1.superview);
        make.height.equalTo(@90);
    }];
    
    Calculate3ItemView *item2 = [[Calculate3ItemView alloc] initWithBackgroundColor:[UIColor whiteColor]];
    [self addSubview:item2];
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item2.superview);
        make.top.equalTo(item1.mas_bottom);
        make.height.equalTo(@90);
    }];
    
    Calculate3ItemView *item3 = [[Calculate3ItemView alloc] initWithBackgroundColor:UIColorFromRGB(0xEEEEEE)];
    [self addSubview:item3];
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item1.superview);
        make.top.equalTo(item2.mas_bottom);
        make.height.equalTo(@90);
    }];
    
    Calculate3ItemView *item4 = [[Calculate3ItemView alloc] initWithBackgroundColor:[UIColor whiteColor]];
    [self addSubview:item4];
    [item4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item1.superview);
        make.top.equalTo(item3.mas_bottom);
        make.height.equalTo(@90);
    }];
    
    Calculate3ItemView *item5 = [[Calculate3ItemView alloc] initWithBackgroundColor:UIColorFromRGB(0xEEEEEE)];
    [self addSubview:item5];
    [item5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item1.superview);
        make.top.equalTo(item4.mas_bottom);
        make.height.equalTo(@90);
    }];
    
    Calculate3ItemView *item6 = [[Calculate3ItemView alloc] initWithBackgroundColor:[UIColor whiteColor]];
    [self addSubview:item6];
    [item6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(item1.superview);
        make.top.equalTo(item5.mas_bottom);
        make.height.equalTo(@90);
    }];
    
    [self.oz addObject:item1.keView.textField];
    [self.oz addObject:item2.keView.textField];
    [self.oz addObject:item3.keView.textField];
    [self.oz addObject:item4.keView.textField];
    [self.oz addObject:item5.keView.textField];
    [self.oz addObject:item6.keView.textField];
    
    [self.aa addObject:item1.secView.textField];
    [self.aa addObject:item2.secView.textField];
    [self.aa addObject:item3.secView.textField];
    [self.aa addObject:item4.secView.textField];
    [self.aa addObject:item5.secView.textField];
    [self.aa addObject:item6.secView.textField];
    
    [self.time addObject:item1.thView.textField];
    [self.time addObject:item2.thView.textField];
    [self.time addObject:item3.thView.textField];
    [self.time addObject:item4.thView.textField];
    [self.time addObject:item5.thView.textField];
    [self.time addObject:item6.thView.textField];
    
    [self.hoptype addObject:item1.floatView];
    [self.hoptype addObject:item2.floatView];
    [self.hoptype addObject:item3.floatView];
    [self.hoptype addObject:item4.floatView];
    [self.hoptype addObject:item5.floatView];
    [self.hoptype addObject:item6.floatView];
    
    [self.divutil addObject:item1.liYongValue];
    [self.divutil addObject:item2.liYongValue];
    [self.divutil addObject:item3.liYongValue];
    [self.divutil addObject:item4.liYongValue];
    [self.divutil addObject:item5.liYongValue];
    [self.divutil addObject:item6.liYongValue];
    
    [self.divIBU addObject:item1.kuDuZhiValue];
    [self.divIBU addObject:item2.kuDuZhiValue];
    [self.divIBU addObject:item3.kuDuZhiValue];
    [self.divIBU addObject:item4.kuDuZhiValue];
    [self.divIBU addObject:item5.kuDuZhiValue];
    [self.divIBU addObject:item6.kuDuZhiValue];
}

@end
