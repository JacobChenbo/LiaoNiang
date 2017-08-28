//
//  Calculate4ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate4ViewController.h"
#import "Calculate4HeaderView.h"
#import "TitleAndTextFieldView.h"
#import "Calculate4Result1View.h"
#import "Calculate4Result2View.h"

@interface Calculate4ViewController ()

@property (nonatomic, strong) TitleAndTextFieldView *tiJi1View;
@property (nonatomic, strong) TitleAndTextFieldView *currentBiZhong1View;
@property (nonatomic, strong) TitleAndTextFieldView *needBiZhong1View;
@property (nonatomic, strong) Calculate4Result1View *result1View;

@property (nonatomic, strong) TitleAndTextFieldView *tiJi2View;
@property (nonatomic, strong) TitleAndTextFieldView *currentBiZhong2View;
@property (nonatomic, strong) TitleAndTextFieldView *targetTiJi2View;
@property (nonatomic, strong) Calculate4Result2View *result2View;

@property (nonatomic, assign) double currentVolume1;
@property (nonatomic, assign) double currentGravity1;
@property (nonatomic, assign) double desiredGravity1;

@property (nonatomic, assign) double currentVolume2;
@property (nonatomic, assign) double currentGravity2;
@property (nonatomic, assign) double targetVolume2;

@end

@implementation Calculate4ViewController

- (void)viewDidLoad {
    self.navTitle = @"麦汁比重调整";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    Calculate4HeaderView *headerView1 = [[Calculate4HeaderView alloc] initWithTitle:@"计算新体积"];
    [self.tableView addCellView:headerView1 cellHeight:45];
    
    TitleAndTextFieldView *tiJi1View = [[TitleAndTextFieldView alloc] initWithTitle:@"麦汁体积(gal/L/qt)："];
    [self.tableView addCellView:tiJi1View cellHeight:60];
    tiJi1View.textField.text = @"3.5";
    tiJi1View.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.tiJi1View = tiJi1View;
    
    TitleAndTextFieldView *currentBiZhong1View = [[TitleAndTextFieldView alloc] initWithTitle:@"目前比重："];
    [self.tableView addCellView:currentBiZhong1View cellHeight:60];
    currentBiZhong1View.textField.text = @"1.075";
    currentBiZhong1View.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.currentBiZhong1View = currentBiZhong1View;
    
    TitleAndTextFieldView *needBiZhong1View = [[TitleAndTextFieldView alloc] initWithTitle:@"所需比重："];
    [self.tableView addCellView:needBiZhong1View cellHeight:60];
    needBiZhong1View.textField.text = @"1.05";
    needBiZhong1View.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.needBiZhong1View = needBiZhong1View;
    
    Calculate4Result1View *result1View = [[Calculate4Result1View alloc] init];
    [self.tableView addCellView:result1View cellHeight:120];
    self.result1View = result1View;
    @weakify(self);
    [result1View setOnClickButtonBlock:^{
        @strongify(self);
        [self updateAll1];
    }];
    
    // ========================
    
    Calculate4HeaderView *headerView2 = [[Calculate4HeaderView alloc] initWithTitle:@"计算新比重"];
    [self.tableView addCellView:headerView2 cellHeight:45];
    
    TitleAndTextFieldView *tiJi2View = [[TitleAndTextFieldView alloc] initWithTitle:@"麦汁体积(gal/L/qt)："];
    [self.tableView addCellView:tiJi2View cellHeight:60];
    tiJi2View.textField.text = @"7.5";
    tiJi2View.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.tiJi2View = tiJi2View;
    
    TitleAndTextFieldView *currentBiZhong2View = [[TitleAndTextFieldView alloc] initWithTitle:@"目前比重："];
    [self.tableView addCellView:currentBiZhong2View cellHeight:60];
    currentBiZhong2View.textField.text = @"1.035";
    currentBiZhong2View.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.currentBiZhong2View = currentBiZhong2View;
    
    TitleAndTextFieldView *targetTiJi2View = [[TitleAndTextFieldView alloc] initWithTitle:@"目标体积："];
    [self.tableView addCellView:targetTiJi2View cellHeight:60];
    targetTiJi2View.textField.text = @"5.5";
    targetTiJi2View.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.targetTiJi2View = targetTiJi2View;
    
    Calculate4Result2View *result2View = [[Calculate4Result2View alloc] init];
    [self.tableView addCellView:result2View cellHeight:120];
    self.result2View = result2View;
    [result2View setOnClickButtonBlock:^{
        @strongify(self);
        [self updateAll2];
    }];
    
    [self updateAll1];
    [self updateAll2];
}

- (void)updateAll1 {
    self.currentVolume1 = [self.tiJi1View.textField.text doubleValue];
    self.currentGravity1 = [self.currentBiZhong1View.textField.text doubleValue];
    self.desiredGravity1 = [self.needBiZhong1View.textField.text doubleValue];
    
    if ([self checkInput1]) {
        [self recalculate1];
    }
}

- (BOOL)checkInput1 {
    if (self.tiJi1View.textField.text.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"Wort Volume must be a number."];
        return NO;
    }
    
    if (self.currentGravity1 <= 1) {
        [[JCGlobay sharedInstance] showErrorMessage:@"目标比重必须大于1.00."];
        return NO;
    }
    
    if (self.desiredGravity1 <= 1) {
        [[JCGlobay sharedInstance] showErrorMessage:@"所需比重必须大于1.00."];
        return NO;
    }
    
    return YES;
}

- (void)recalculate1 {
    double newVolume = ((self.currentGravity1 - 1) / (self.desiredGravity1 - 1)) * self.currentVolume1;
    newVolume = [[JCGlobay sharedInstance] roundDecimal:newVolume number:2];
    self.result1View.tiJiValue.text = [NSString stringWithFormat:@"%.2f", newVolume];
    
    double difference = [[JCGlobay sharedInstance] roundDecimal:(newVolume - self.currentVolume1) number:2];
    self.result1View.differenceValue.text  =[NSString stringWithFormat:@"%.2f", difference];
    if (difference >= 0) {
//        self.result1View.differenceValue.textColor = [UIColor greenColor];
    } else {
//        self.result1View.differenceValue.textColor = [UIColor redColor];
    }
}

// =============

- (void)updateAll2 {
    self.currentVolume2 = [self.tiJi2View.textField.text doubleValue];
    self.currentGravity2 = [self.currentBiZhong2View.textField.text doubleValue];
    self.targetVolume2 = [self.targetTiJi2View.textField.text doubleValue];
    
    if ([self checkInput2]) {
        [self recalculate2];
    }
}

- (BOOL)checkInput2 {
    if (self.currentVolume2 <= 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"Current Volume must be greater than zero."];
        return NO;
    }
    if (self.currentGravity2 <= 1) {
        [[JCGlobay sharedInstance] showErrorMessage:@"目标比重必须大于1.00."];
        return NO;
    }
    if (self.targetVolume2 <= 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"目标体积必须大于0."];
        return NO;
    }
    return YES;
}

- (void)recalculate2 {
    double newGravity = (_currentGravity2 - 1) * (_currentVolume2 / _targetVolume2);
    newGravity = newGravity + 1;
    newGravity = [[JCGlobay sharedInstance] roundDecimal:newGravity number:3];
    self.result2View.biZhongValue.text = [NSString stringWithFormat:@"%.3f", newGravity];
    
    double difference = [[JCGlobay sharedInstance] roundDecimal:newGravity - _currentGravity2 number:3];
    self.result2View.differenceValue.text = [NSString stringWithFormat:@"%.3f", difference];
    if (difference >= 0) {
//        self.result2View.differenceValue.textColor = [UIColor greenColor];
    } else {
//        self.result2View.differenceValue.textColor = [UIColor redColor];
    }
}

@end
