//
//  Calculate1ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate1ViewController.h"
#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"
#import "Calculate1ResultView.h"
#import <math.h>

@interface Calculate1ViewController ()

@property (nonatomic, strong) NSString *ogIn;   // 填写的初始糖度
@property (nonatomic, strong) NSString *fgIn;   // 填写的终点糖度
@property (nonatomic, strong) NSString *gravityunit; //sg是密度，plato是糖度
@property (nonatomic, strong) NSString *equation; //basic是标准，advanced是最大

@property (nonatomic, strong) TitleAndTextFieldView *OGView;
@property (nonatomic, strong) TitleAndTextFieldView *FGView;
@property (nonatomic, strong) Calculate1ResultView *resultView;

@end

@implementation Calculate1ViewController

- (void)viewDidLoad {
    self.navTitle = @"酒精度预测";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    TwoRadioItemView *miduView = [[TwoRadioItemView alloc] initWithTitle:@"密度单位：" itemOne:@"糖度°P" itemTwo:@"密度(1.xxx)" defaultSelectedIndex:2];
    [self.tableView addCellView:miduView cellHeight:38];
    @weakify(self);
    self.gravityunit = @"sg";
    [miduView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.gravityunit = @"plato";
            self.OGView.textField.text = @"12";
            self.FGView.textField.text = @"2.5";
        } else {
            self.gravityunit = @"sg";
            self.OGView.textField.text = @"1.048";
            self.FGView.textField.text = @"1.010";
        }
        [self updateAll];
    }];
    
    TitleAndTextFieldView *OGView = [[TitleAndTextFieldView alloc] initWithTitle:@"初始比重/糖度(OG)："];
    OGView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    OGView.textField.text = @"1.048";
    self.OGView = OGView;
    [self.tableView addCellView:OGView cellHeight:60];
    
    TitleAndTextFieldView *FGView = [[TitleAndTextFieldView alloc] initWithTitle:@"终点比重/糖度(FG)："];
    FGView.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    FGView.textField.text = @"1.01";
    self.FGView = FGView;
    [self.tableView addCellView:FGView cellHeight:60];
    
    TwoRadioItemView *gongsiView = [[TwoRadioItemView alloc] initWithTitle:@"公式：" itemOne:@"标准" itemTwo:@"最大"];
    [self.tableView addCellView:gongsiView cellHeight:38];
    self.equation = @"basic";
    [gongsiView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.equation = @"basic";
        } else {
            self.equation = @"advanced";
        }
        [self updateAll];
    }];
    
    Calculate1ResultView *resultView = [[Calculate1ResultView alloc] init];
    self.resultView = resultView;
    [self.tableView addCellView:resultView cellHeight:200];
    [resultView setOnClickButtonBlock:^{
        @strongify(self);
        [self updateAll];
    }];
}

- (void)updateAll {
    if ([self checkInput]) {
        [self recalculate];
    }
}

- (BOOL)checkInput {
    if (self.OGView.textField.text.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入初始比重/糖度(OG)"];
        return NO;
    }
    if (self.FGView.textField.text.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入终点比重/糖度(FG)"];
        return NO;
    }
    return YES;
}

- (void)recalculate {
    double ogInSg = [self.OGView.textField.text doubleValue];
    double fgInSg = [self.FGView.textField.text doubleValue];
    double ogInPlato = [self.OGView.textField.text doubleValue];
    double fgInPlato = [self.FGView.textField.text doubleValue];
    
    if ([self.gravityunit isEqualToString:@"plato"]) {
        ogInSg = [self covertPlatoToGravity:[self.OGView.textField.text doubleValue]];
        fgInSg = [self covertPlatoToGravity:[self.FGView.textField.text doubleValue]];
    }
    
    if ([self.gravityunit isEqualToString:@"sg"]) {
        ogInPlato = [self covertGravityToPlato:[self.OGView.textField.text doubleValue] number:10];
        fgInPlato = [self covertGravityToPlato:[self.FGView.textField.text doubleValue] number:10];
    }
    
    if ([self.equation isEqualToString:@"basic"]) {
        double abv_basic = (ogInSg - fgInSg) * 131.25;
        self.resultView.jiuJingDuValue.text = [NSString stringWithFormat:@"%.2f%@", [self roundDecimal:abv_basic number:2], @"%"];
    } else {
        double abw = 76.08 * (ogInSg - fgInSg) / (1.775 - ogInSg);
        double abv = abw * (fgInSg / 0.794);
        self.resultView.jiuJingDuValue.text = [NSString stringWithFormat:@"%.2f%@", [self roundDecimal:abv number:2], @"%"];
    }
    
    if (ogInPlato == 0) {
        ogInPlato = 0.0001;
    }
    
    double attenuation = (1 - (fgInPlato / ogInPlato)) * 100;
    double calories = [self computeCaloriesEvery330mlWithOgPlato:ogInPlato fgPlato:fgInPlato];
    self.resultView.OGValue.text = [NSString stringWithFormat:@"%.2f °P, %.3f", [self roundDecimal:ogInPlato number:2], [self roundDecimal:ogInSg number:3]];
    self.resultView.FGValue.text = [NSString stringWithFormat:@"%.2f °P, %.3f", [self roundDecimal:fgInPlato number:2], [self roundDecimal:fgInSg number:3]];
    self.resultView.faJiaoDuValue.text = [NSString stringWithFormat:@"%.1f%@", [self roundDecimal:attenuation number:1], @"%"];
    self.resultView.kaLuLiValue.text = [NSString stringWithFormat:@"%.1f 每 330ml bottle", [self roundDecimal:calories number:1]];
}

//- (double)covertPlatoToGravity:(double)plato {
//    return (plato / (258.6 - ((plato / 258.2) * 227.1))) + 1;
//}
//
//- (double)covertGravityToPlato:(double)sg number:(NSInteger)n {
//    if (n <= 0) {
//        n = 1;
//    }
//
//    double plato = (-1 * 616.868) + (1111.14 * sg) - (630.272 * pow(sg, 2)) + (135.997 * pow(sg, 3));
//    return [self roundDecimal:plato number:n];
//}

- (double)computeCaloriesEvery330mlWithOgPlato:(double)ogPlato fgPlato:(double)fgPlato {
    if (ogPlato <= 0) {
        return 0;
    }
    if (fgPlato <= -12) {
        return 0;
    }
    
    double realExtract = (0.1808 * ogPlato) + (0.8192 * fgPlato);
    double abw = (ogPlato - realExtract) / (2.0665 - (0.010665 * ogPlato));
    double fgInSg = [self covertPlatoToGravity:fgPlato];
    double calories = ((6.9 * abw) + 4.0 * (realExtract - 0.1)) * fgInSg * 3.55;
    return calories;
}

@end
