//
//  Calcualte3ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate3ViewController.h"
#import "TwoRadioItemView.h"
#import "Calculated3HeaderView.h"
#import "Calculate3ItemView.h"
#import "Calculate3ItemsView.h"
#import "Calculate3ResultView.h"
#import "FloatingSelectorView.h"

@interface Calculate3ViewController ()

@property (nonatomic, assign) double boilsize;   // 煮沸量
@property (nonatomic, assign) double batchsize;  // 批次量
@property (nonatomic, assign) double originalgravity;  // 目标原始比重
@property (nonatomic, strong) NSString *volumeunit;

@property (nonatomic, assign) double boilgravity;
@property (nonatomic, assign) double divtotalIBU; // 总苦度
@property (nonatomic, assign) double divBoilgravity; // 煮沸前比重

@property (nonatomic, strong) NSMutableArray *ozValue; // 重量值

//////

@property (nonatomic, strong) Calculated3HeaderView *headerView;
@property (nonatomic, strong) Calculate3ItemsView *itemsView;
@property (nonatomic, strong) TwoRadioItemView *danWeiView;
@property (nonatomic, strong) Calculate3ResultView *resultView;

@end

#define e       2.718281828459045235

@implementation Calculate3ViewController

- (void)viewDidLoad {
    self.navTitle = @"苦度计算";
    
    self.ozValue = [[NSMutableArray alloc] initWithCapacity:6];
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    TwoRadioItemView *danWeiView = [[TwoRadioItemView alloc] initWithTitle:@"单位：" itemOne:@"公制-升/克" itemTwo:@"美制-加仑/盎司"];
    [self.tableView addCellView:danWeiView cellHeight:38];
    self.danWeiView = danWeiView;
    @weakify(self);
    self.volumeunit = @"升";
    [danWeiView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.volumeunit = @"升";
            self.headerView.zhuFeiView.textField.text = @"27";
            self.headerView.piCiView.textField.text = @"21";
            self.headerView.targetOGView.textField.text = @"1.055";
        } else {
            self.volumeunit = @"加仑";
            self.headerView.zhuFeiView.textField.text = @"7";
            self.headerView.piCiView.textField.text = @"5.5";
            self.headerView.targetOGView.textField.text = @"1.055";
        }
        
        [self updateAll];
    }];
    
    Calculated3HeaderView *headerView = [[Calculated3HeaderView alloc] init];
    [self.tableView addCellView:headerView cellHeight:60];
    self.headerView = headerView;
    
    Calculate3ItemsView *items = [[Calculate3ItemsView alloc] init];
    [self.tableView addCellView:items cellHeight:90 * 6];
    self.itemsView = items;
    
    Calculate3ResultView *resultView = [[Calculate3ResultView alloc] init];
    [self.tableView addCellView:resultView cellHeight:110];
    self.resultView = resultView;
    [resultView setOnClickCalculateBlock:^{
        @strongify(self);
        [self updateAll];
    }];
    [resultView setOnClickResetBlock:^{
        @strongify(self);
        [self resetAllViews];
    }];
}

- (void)updateAll {
    if ([self checkInput]) {
        [self recalculate];
    }
}

- (void)resetAllViews {
    [self.danWeiView onClickButtonIndex:1];
    for (int i = 0; i < 6; i++) {
        ((UITextField *)self.itemsView.oz[i]).text = @"0";
        ((UITextField *)self.itemsView.aa[i]).text = @"0";
        ((UITextField *)self.itemsView.time[i]).text = @"0";
        [(FloatingSelectorView *)self.itemsView.hoptype[i] setTitles:@[@"颗粒", @"整花"]];
    }
    [self updateAll];
}

- (BOOL)checkInput {
    self.boilsize = [self.headerView.zhuFeiView.textField.text doubleValue];
    self.batchsize = [self.headerView.piCiView.textField.text doubleValue];
    self.originalgravity = [self.headerView.targetOGView.textField.text doubleValue];
    
    [self.ozValue removeAllObjects];
    [self.ozValue addObject:@([[(UITextField *)[self.itemsView.oz objectAtIndex:0] text] doubleValue])];
    [self.ozValue addObject:@([[(UITextField *)[self.itemsView.oz objectAtIndex:1] text] doubleValue])];
    [self.ozValue addObject:@([[(UITextField *)[self.itemsView.oz objectAtIndex:2] text] doubleValue])];
    [self.ozValue addObject:@([[(UITextField *)[self.itemsView.oz objectAtIndex:3] text] doubleValue])];
    [self.ozValue addObject:@([[(UITextField *)[self.itemsView.oz objectAtIndex:4] text] doubleValue])];
    [self.ozValue addObject:@([[(UITextField *)[self.itemsView.oz objectAtIndex:5] text] doubleValue])];
    
    return YES;
}

- (void)recalculate {
    if ([self.volumeunit isEqualToString:@"升"]) {
        self.batchsize = [self litersToGallons:self.batchsize];
        self.boilsize = [self litersToGallons:self.boilsize];
        
        [self.ozValue setObject:@([self gramToOunce:[self.ozValue[0] doubleValue]]) atIndexedSubscript:0];
        [self.ozValue setObject:@([self gramToOunce:[self.ozValue[1] doubleValue]]) atIndexedSubscript:1];
        [self.ozValue setObject:@([self gramToOunce:[self.ozValue[2] doubleValue]]) atIndexedSubscript:2];
        [self.ozValue setObject:@([self gramToOunce:[self.ozValue[3] doubleValue]]) atIndexedSubscript:3];
        [self.ozValue setObject:@([self gramToOunce:[self.ozValue[4] doubleValue]]) atIndexedSubscript:4];
        [self.ozValue setObject:@([self gramToOunce:[self.ozValue[5] doubleValue]]) atIndexedSubscript:5];
    }
    
    self.boilgravity = (self.batchsize / self.boilsize) * (self.originalgravity - 1);
    self.resultView.OGValue.text = [NSString stringWithFormat:@"%.3f", [self roundDecimal:self.boilgravity + 1 number:3]];
    
    double totalIBU = 0.0;
    for (int i = 0; i < 6; i++) {
        double IBU = 0;
        double util = 0;
        double bfactor = 1.65 * pow(0.000125, self.boilgravity);
        double tfactor = (1 - pow(e, (-0.04 * [[(UITextField *)self.itemsView.time[i] text] doubleValue]))) / 4.15;
        util = bfactor * tfactor;
        
        if ([[(FloatingSelectorView *)self.itemsView.hoptype[i] title] isEqualToString:@"颗粒"]) {
            util = util * 1.1;
        }
        IBU = util * ((([[(UITextField *)self.itemsView.aa[i] text] doubleValue] / 100.0) * [self.ozValue[i] doubleValue] * 7490) / self.batchsize);
        [(UILabel *)self.itemsView.divutil[i] setText:[NSString stringWithFormat:@"%.4f", [self roundDecimal:util number:4]]];
        [(UILabel *)self.itemsView.divIBU[i] setText:[NSString stringWithFormat:@"%.2f", [self roundDecimal:IBU number:2]]];
        totalIBU += IBU;
    }
    
    self.resultView.kuduValue.text = [NSString stringWithFormat:@"%.2f", [self roundDecimal:totalIBU number:2]];
}

@end
