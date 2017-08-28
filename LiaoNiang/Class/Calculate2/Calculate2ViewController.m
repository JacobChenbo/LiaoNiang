//
//  Calculate2ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate2ViewController.h"
#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"
#import "Calculate2ResultView.h"

@interface Calculate2ViewController ()

@property (nonatomic, strong) TitleAndTextFieldView *biZhongView;
@property (nonatomic, strong) TitleAndTextFieldView *wenDuView;
@property (nonatomic, strong) TitleAndTextFieldView *jiaoZhengView;
@property (nonatomic, strong) Calculate2ResultView *resultView;

@property (nonatomic, strong) NSString *tempUnit;
@property (nonatomic, assign) double hydro; // 比重计度数
@property (nonatomic, assign) double temp; // 温度
@property (nonatomic, assign) double calibration; // 校准

@end

@implementation Calculate2ViewController

- (void)viewDidLoad {
    self.navTitle = @"比重温度校准";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    TwoRadioItemView *miduView = [[TwoRadioItemView alloc] initWithTitle:@"单位：" itemOne:@"美制 - °F" itemTwo:@"公制 - °C" defaultSelectedIndex:2];
    [self.tableView addCellView:miduView cellHeight:38];
    @weakify(self);
    [miduView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            [self switchUnitsToMetric];
        } else {
            [self switchUnitsToUs];
        }
    }];
    
    TitleAndTextFieldView *biZhongView = [[TitleAndTextFieldView alloc] initWithTitle:@"比重计度数(1.xxx)："];
    biZhongView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    biZhongView.textField.text = @"1.020";
    self.biZhongView = biZhongView;
    [self.tableView addCellView:biZhongView cellHeight:60];
    
    TitleAndTextFieldView *wenDuView = [[TitleAndTextFieldView alloc] initWithTitle:@"温度(C)(范围:0-71(C))"];
    wenDuView.textField.keyboardType = UIKeyboardTypeNumberPad;
    wenDuView.textField.text = @"27";
    self.wenDuView = wenDuView;
    [self.tableView addCellView:wenDuView cellHeight:60];
    
    TitleAndTextFieldView *jiaoZhengView = [[TitleAndTextFieldView alloc] initWithTitle:@"校正(C)(范围:10-24(C))"];
    jiaoZhengView.textField.keyboardType = UIKeyboardTypeNumberPad;
    jiaoZhengView.textField.text = @"20";
    self.jiaoZhengView = jiaoZhengView;
    [self.tableView addCellView:jiaoZhengView cellHeight:60];
    
    Calculate2ResultView *resultView = [[Calculate2ResultView alloc] init];
    self.resultView = resultView;
    [self.tableView addCellView:resultView cellHeight:80];
    [resultView setOnClickButtonBlock:^{
        @strongify(self);
        [self updateAll];
    }];
    
    [self switchUnitsToUs];
}

- (void)switchUnitsToMetric {
    self.tempUnit = @"F";
    self.biZhongView.textField.text = @"1.020";
    self.wenDuView.textField.text = @"80";
    self.jiaoZhengView.textField.text = @"68";
    self.wenDuView.title = @"温度(C)(范围:32-159(F))";
    self.jiaoZhengView.title = @"校正(C)(范围:50-75(F))";
    [self updateAll];
}

- (void)switchUnitsToUs {
    self.tempUnit = @"C";
    self.biZhongView.textField.text = @"1.020";
    self.wenDuView.textField.text = @"27";
    self.jiaoZhengView.textField.text = @"20";
    self.wenDuView.title = @"温度(C)(范围:0-71(C))";
    self.jiaoZhengView.title = @"校正(C)(范围:10-24(C))";
    [self updateAll];
}

- (BOOL)checkInput {
    self.hydro = [self.biZhongView.textField.text doubleValue];
    self.temp = [self.wenDuView.textField.text doubleValue];
    self.calibration = [self.jiaoZhengView.textField.text doubleValue];
    
    if ([self.tempUnit isEqualToString:@"F"]) {
        if (self.temp < 32 || self.temp > 159) {
            [[JCGlobay sharedInstance] showErrorMessage:@"请输入正确的温度范围."];
            return NO;
        }
        if (self.calibration < 50 || self.calibration > 75) {
            [[JCGlobay sharedInstance] showErrorMessage:@"请输入正确的温度范围."];
            return NO;
        }
    } else {
        if (self.temp < 0 || self.temp > 71) {
            [[JCGlobay sharedInstance] showErrorMessage:@"请输入正确的温度范围."];
            return NO;
        }
        if (self.calibration < 10 || self.calibration > 24) {
            [[JCGlobay sharedInstance] showErrorMessage:@"请输入正确的温度范围."];
            return NO;
        }
    }
    
    return YES;
}

- (void)updateAll {
    if ([self checkInput]) {
        [self recalculate];
    }
}

- (void)recalculate {
    if ([self.tempUnit isEqualToString:@"F"]) {
        self.temp = [self fahrenheitToCelsius:self.temp];
        self.calibration = [self fahrenheitToCelsius:self.calibration];
    }
    
    double difference = [self calculateHydrometerCorrection:self.temp calibration:self.calibration];
    double result = [[JCGlobay sharedInstance] roundDecimal:difference + self.hydro number:3];
    self.resultView.jiaoZhengZhiValue.text = [NSString stringWithFormat:@"%.3f", result];
}

- (double)calculateHydrometerCorrection:(double)temp calibration:(double)calibration {
    if (temp < 0 || temp > 71) {
        return 0;
    }
    if (calibration < 10 || calibration > 24) {
        return 0;
    }
    
    NSMutableArray *c = [[NSMutableArray alloc] init];
    NSMutableArray *delta = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= 71; i++) {
        [c addObject:[NSNumber numberWithDouble:i]];
    }
    
    NSInteger calibrationOffset = 15 - round(calibration);
    double difference = 0;
    
    delta[0] = [NSNumber numberWithDouble:-0.0009];
    delta[1] = [NSNumber numberWithDouble:-0.0009];
    delta[2] = [NSNumber numberWithDouble:-0.0009];
    delta[3] = [NSNumber numberWithDouble:-0.0009];
    delta[4] = [NSNumber numberWithDouble:-0.0009];
    delta[5] = [NSNumber numberWithDouble:-0.0009];
    delta[6] = [NSNumber numberWithDouble:-0.0008];
    delta[7] = [NSNumber numberWithDouble:-0.0008];
    delta[8] = [NSNumber numberWithDouble:-0.0007];
    delta[9] = [NSNumber numberWithDouble:-0.0007];
    delta[10] = [NSNumber numberWithDouble:-0.0006];
    delta[11] = [NSNumber numberWithDouble:-0.0005];
    delta[12] = [NSNumber numberWithDouble:-0.0004];
    delta[13] = [NSNumber numberWithDouble:-0.0003];
    delta[14] = [NSNumber numberWithDouble:-0.0001];
    delta[15] = [NSNumber numberWithDouble:0];
    delta[16] = [NSNumber numberWithDouble:0.0002];
    delta[17] = [NSNumber numberWithDouble:0.0003];
    delta[18] = [NSNumber numberWithDouble:0.0005];
    delta[19] = [NSNumber numberWithDouble:0.0007];
    delta[20] = [NSNumber numberWithDouble:0.0009];
    delta[21] = [NSNumber numberWithDouble:0.0011];
    delta[22] = [NSNumber numberWithDouble:0.0013];
    delta[23] = [NSNumber numberWithDouble:0.0016];
    delta[24] = [NSNumber numberWithDouble:0.0018];
    delta[25] = [NSNumber numberWithDouble:0.0021];
    delta[26] = [NSNumber numberWithDouble:0.0023];
    delta[27] = [NSNumber numberWithDouble:0.0026];
    delta[28] = [NSNumber numberWithDouble:0.0029];
    delta[29] = [NSNumber numberWithDouble:0.0032];
    delta[30] = [NSNumber numberWithDouble:0.0035];
    delta[31] = [NSNumber numberWithDouble:0.0038];
    delta[32] = [NSNumber numberWithDouble:0.0041];
    delta[33] = [NSNumber numberWithDouble:0.0044];
    delta[34] = [NSNumber numberWithDouble:0.0047];
    delta[35] = [NSNumber numberWithDouble:0.0051];
    delta[36] = [NSNumber numberWithDouble:0.0054];
    delta[37] = [NSNumber numberWithDouble:0.0058];
    delta[38] = [NSNumber numberWithDouble:0.0061];
    delta[39] = [NSNumber numberWithDouble:0.0065];
    delta[40] = [NSNumber numberWithDouble:0.0069];
    delta[41] = [NSNumber numberWithDouble:0.0073];
    delta[42] = [NSNumber numberWithDouble:0.0077];
    delta[43] = [NSNumber numberWithDouble:0.0081];
    delta[44] = [NSNumber numberWithDouble:0.0085];
    delta[45] = [NSNumber numberWithDouble:0.0089];
    delta[46] = [NSNumber numberWithDouble:0.0093];
    delta[47] = [NSNumber numberWithDouble:0.0097];
    delta[48] = [NSNumber numberWithDouble:0.0102];
    delta[49] = [NSNumber numberWithDouble:0.0106];
    delta[50] = [NSNumber numberWithDouble:0.0110];
    delta[51] = [NSNumber numberWithDouble:0.0114];
    delta[52] = [NSNumber numberWithDouble:0.0118];
    delta[53] = [NSNumber numberWithDouble:0.0122];
    delta[54] = [NSNumber numberWithDouble:0.0126];
    delta[55] = [NSNumber numberWithDouble:0.0130];
    delta[56] = [NSNumber numberWithDouble:0.0135];
    delta[57] = [NSNumber numberWithDouble:0.0140];
    delta[58] = [NSNumber numberWithDouble:0.0145];
    delta[59] = [NSNumber numberWithDouble:0.0150];
    delta[60] = [NSNumber numberWithDouble:0.0155];
    delta[61] = [NSNumber numberWithDouble:0.0160];
    delta[62] = [NSNumber numberWithDouble:0.0165];
    delta[63] = [NSNumber numberWithDouble:0.0171];
    delta[64] = [NSNumber numberWithDouble:0.0177];
    delta[65] = [NSNumber numberWithDouble:0.0183];
    delta[66] = [NSNumber numberWithDouble:0.0189];
    delta[67] = [NSNumber numberWithDouble:0.0195];
    delta[68] = [NSNumber numberWithDouble:0.0201];
    delta[69] = [NSNumber numberWithDouble:0.0207];
    delta[70] = [NSNumber numberWithDouble:0.0213];
    delta[71] = [NSNumber numberWithDouble:0.0219];
    delta[72] = [NSNumber numberWithDouble:0.0225];
    delta[73] = [NSNumber numberWithDouble:0.0231];
    delta[74] = [NSNumber numberWithDouble:0.0237];
    delta[75] = [NSNumber numberWithDouble:0.0243];
    delta[76] = [NSNumber numberWithDouble:0.0249];
    delta[77] = [NSNumber numberWithDouble:0.0255];
    delta[78] = [NSNumber numberWithDouble:0.0261];
    delta[79] = [NSNumber numberWithDouble:0.0267];
    delta[80] = [NSNumber numberWithDouble:0.0273];
    
    for (int i = 0; i < c.count; i++) {
        if ([c[i] integerValue] == (NSInteger)temp) {
            NSInteger calibrationOffsetBounded = calibrationOffset;
            if (i + calibrationOffsetBounded < 0) {
                calibrationOffsetBounded = 0;
            }
            
            difference = [[delta objectAtIndex:i + calibrationOffsetBounded] doubleValue];
            break;
        }
        if (temp >= [c[i] integerValue] && temp < [c[i + 1] integerValue]) {
            NSInteger calibrationOffsetBounded = calibrationOffset;
            if (i + calibrationOffsetBounded < 0) {
                calibrationOffsetBounded = 0;
            }
            difference = ([delta[i + calibrationOffsetBounded] doubleValue] + [delta[i + calibrationOffsetBounded + 1] doubleValue]) / 2.0;
            break;
        }
    }
    
    return difference;
}

- (double)fahrenheitToCelsius:(double)fahrenheit {
    return (5.0 / 9.0) * (fahrenheit - 32);
}

@end
