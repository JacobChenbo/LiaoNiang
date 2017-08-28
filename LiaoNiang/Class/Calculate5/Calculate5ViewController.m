//
//  Calculate5ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate5ViewController.h"
#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"
#import "PitchRateSelectionView.h"
#import "YeastTypeView.h"
#import "Calculate5ResultView.h"
#import "SecondStepView.h"
#import "SecondStepItemView.h"

@interface Calculate5ViewController ()

@property (nonatomic, strong) YeastTypeView *yeastTypeView;
@property (nonatomic, strong) TitleAndTextFieldView *wortGravityView;
@property (nonatomic, strong) TitleAndTextFieldView *wortVolumeView;
@property (nonatomic, strong) PitchRateSelectionView *pitchRateView;
@property (nonatomic, strong) Calculate5ResultView *resultView;
@property (nonatomic, strong) SecondStepView *secondStepView;

@property (nonatomic, assign) double yeastCount;
@property (nonatomic, assign) double starterYeastCount;
@property (nonatomic, strong) NSString *volumeunit;     // 单位
@property (nonatomic, strong) NSString *gravityunit;    // 糖度单位： sg密度，plato糖度
@property (nonatomic, assign) double pitchRate;
@property (nonatomic, strong) NSString *yeastType;      // 酵母类型
@property (nonatomic, assign) double yeast_dry_grams;   // 干酵母量
@property (nonatomic, assign) double yeast_dry_cells_per_gram; // 细胞浓度
@property (nonatomic, assign) double yeast_liquid_packs;
@property (nonatomic, strong) NSString *yeast_liquid_mfg_date;
@property (nonatomic, assign) double yeast_slurry_amount;
@property (nonatomic, assign) double yeast_slurry_denisty;
@property (nonatomic, assign) double wortGravity;       // 麦汁比重（OG）
@property (nonatomic, assign) double wortVolume;        // 麦汁体积
@property (nonatomic, strong) NSArray *starterVolume;   // 扩培量（升）
@property (nonatomic, strong) NSArray *starterGravity;  // 比重（°P）

@end

@implementation Calculate5ViewController

- (void)viewDidLoad {
    self.navTitle = @"酵母扩培计算";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.volumeunit = @"升";
    self.gravityunit = @"plato";
    self.yeastType = @"干酵母";
    [self setupViews];
}

- (void)setupViews {
    @weakify(self);
    TwoRadioItemView *danWeiView = [[TwoRadioItemView alloc] initWithTitle:@"单位：" itemOne:@"美制 - 加仑/盎司" itemTwo:@"公制 - 升/克" defaultSelectedIndex:2];
    [self.tableView addCellView:danWeiView cellHeight:38];
    [danWeiView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.volumeunit = @"加仑";
            self.wortVolumeView.title = @"麦汁体积(加仑):";
            self.wortVolumeView.textField.text = @"5.5";
        } else {
            self.volumeunit = @"升";
            self.wortVolumeView.title = @"麦汁体积(升):";
            self.wortVolumeView.textField.text = @"21";
        }
    }];
    
    TwoRadioItemView *tangLiangView = [[TwoRadioItemView alloc] initWithTitle:@"糖量单位：" itemOne:@"密度比重(1.xxx)" itemTwo:@"糖度°P" defaultSelectedIndex:2];
    [self.tableView addCellView:tangLiangView cellHeight:38];
    [tangLiangView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.gravityunit = @"sg";
            self.wortGravityView.title = @"麦汁比重(OG)(1.xxx):";
            self.wortGravityView.textField.text = @"1.050";
            [(SecondStepItemView *)[self.secondStepView.secondStepData objectAtIndex:0] biZhongView].textValue = @"1.036";
            [(SecondStepItemView *)[self.secondStepView.secondStepData objectAtIndex:1] biZhongView].textValue = @"1.036";
            [(SecondStepItemView *)[self.secondStepView.secondStepData objectAtIndex:2] biZhongView].textValue = @"1.036";
        } else {
            self.gravityunit = @"plato";
            self.wortGravityView.title = @"麦汁比重(OG)(°P):";
            self.wortGravityView.textField.text = @"12.5";
            [(SecondStepItemView *)[self.secondStepView.secondStepData objectAtIndex:0] biZhongView].textValue = @"9";
            [(SecondStepItemView *)[self.secondStepView.secondStepData objectAtIndex:1] biZhongView].textValue = @"9";
            [(SecondStepItemView *)[self.secondStepView.secondStepData objectAtIndex:2] biZhongView].textValue = @"9";
        }
    }];
    
    TitleAndTextFieldView *wortGravityView = [[TitleAndTextFieldView alloc] initWithTitle:@"麦汁比重(OG)(°P):"];
    [self.tableView addCellView:wortGravityView cellHeight:60];
    wortGravityView.textField.text = @"12.5";
    self.wortGravityView = wortGravityView;
    
    TitleAndTextFieldView *wortVolumeView = [[TitleAndTextFieldView alloc] initWithTitle:@"麦汁体积(升):"];
    [self.tableView addCellView:wortVolumeView cellHeight:60];
    wortVolumeView.textField.text = @"21";
    self.wortVolumeView = wortVolumeView;
    
    PitchRateSelectionView *pitchRateView = [[PitchRateSelectionView alloc] init];
    [self.tableView addAutoHeightCellView:pitchRateView];
    self.pitchRateView = pitchRateView;
    
    YeastTypeView *yeastTypeView = [[YeastTypeView alloc] init];
    [self.tableView addCellView:yeastTypeView cellHeight:145];
    [yeastTypeView setYeastTypeChangedBlock:^(NSString *type, CGFloat height) {
        @strongify(self);
        [self.tableView resetHeightOfCellView:self.yeastTypeView withHeight:height animated:YES];
        [self updateAll];
    }];
    self.yeastTypeView = yeastTypeView;
    
    Calculate5ResultView *resultView = [[Calculate5ResultView alloc] init];
    [self.tableView addCellView:resultView cellHeight:170];
    self.resultView = resultView;
    [resultView setCalButtonClickBlock:^{
        @strongify(self);
        [self updateAll];
    }];
    
    SecondStepView *secondStepView = [[SecondStepView alloc] init];
    [self.tableView addAutoHeightCellView:secondStepView];
    self.secondStepView = secondStepView;
    [secondStepView setDataFromAboveBlock:^{
        @strongify(self);
        self.secondStepView.startYeast.textValue = [NSString stringWithFormat:@"%.f", self.yeastCount];
    }];
    [secondStepView setCalButtonClickBlock:^{
        @strongify(self);
        [self updateAll];
    }];
}

- (void)updateAll {
    self.yeastType = self.yeastTypeView.yeastType;
    self.wortGravity = [self.wortGravityView.textField.text doubleValue];
    self.wortVolume = [self.wortVolumeView.textField.text doubleValue];
    self.pitchRate = self.pitchRateView.pitchRate;
    self.yeast_dry_grams = [self.yeastTypeView.textField1.textField.text doubleValue];
    self.yeast_dry_cells_per_gram = [self.yeastTypeView.textField2.textField.text doubleValue];
    self.yeast_liquid_packs = [self.yeastTypeView.textField1.textField.text doubleValue];
    self.yeast_liquid_mfg_date = self.yeastTypeView.textField2.textField.text;
    self.yeast_slurry_amount = [self.yeastTypeView.textField1.textField.text doubleValue];
    self.yeast_slurry_denisty = [self.yeastTypeView.textField2.textField.text doubleValue];
    self.starterYeastCount = [self.secondStepView.startYeast.textValue doubleValue];
    
    if ([self checkInput]) {
        [self recalculate];
    }
}

- (void)recalculate {
    double millilitersOfWort = self.wortVolume * 1000;
    if ([self.volumeunit isEqualToString:@"加仑"]) {
        millilitersOfWort = [self gallonsToLiters:self.wortVolume] * 1000;
    }
    
    double wortPlato = self.wortGravity;
    if ([self.gravityunit isEqualToString:@"sg"]) {
        wortPlato = [self covertGravityToPlato:self.wortGravity number:10]; // 密度转糖度
    }
    
    double yeastNeeded = self.pitchRate * millilitersOfWort * wortPlato;
    yeastNeeded = yeastNeeded / 1000.0;
    yeastNeeded = [self roundDecimal:yeastNeeded number:0];
    self.resultView.label3.value.text = [NSString stringWithFormat:@"%.f × 10亿 细胞", yeastNeeded];
   
    self.yeastCount = 0;
    if ([self.yeastType isEqualToString:@"干酵母"]) {
        self.yeastCount = self.yeast_dry_grams * self.yeast_dry_cells_per_gram;
    }
    if ([self.yeastType isEqualToString:@"液体酵母"]) {
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy/MM/dd";
        NSString *dateString = self.yeastTypeView.textField2.textValue;
        NSDate *date = [fmt dateFromString:dateString];
        if (date == nil) {
            return;
        }
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [cal components:NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
        NSInteger daysOld = dateComponents.day;
        if (daysOld < 0) {
            daysOld = 0;
        }
        NSString *dayString = @"days";
        if (daysOld == 1) {
            dayString = @"day";
        }
        double viability = 100 - (daysOld * 0.7);
        if (viability < 0) {
            viability = 0;
        }
        viability = [self roundDecimal:viability number:0];
        self.yeastTypeView.viabilityValue.text = [NSString stringWithFormat:@"Yeast 已经 %ld %@ old, the viability 已经 estimated at %.f%@", (long)daysOld, dayString, viability, @"%"];
        self.yeastCount = 100 * (viability / 100.0) * self.yeast_liquid_packs;
    }
    if ([self.yeastType isEqualToString:@"酵母泥"]) {
        self.yeastCount = self.yeast_slurry_denisty * self.yeast_slurry_amount * 1000;
    }
    self.yeastCount = [self roundDecimal:self.yeastCount number:0];
    self.resultView.label1.value.text = [NSString stringWithFormat:@"%.f × 10亿 细胞", self.yeastCount];
    
    double yeastDifference = self.yeastCount - yeastNeeded;
    if (yeastDifference < 0) {
        self.resultView.label4.value.textColor = [UIColor redColor];
    } else {
        self.resultView.label4.value.textColor = [UIColor greenColor];
    }
    self.resultView.label4.value.text = [NSString stringWithFormat:@"%.f × 10亿 细胞", yeastDifference];
    
    if (wortPlato <= 0 || millilitersOfWort <= 0) {
        self.resultView.label2.value.text = @"-";
    } else {
        double actualPitchRate = ((self.yeastCount * 1000) / wortPlato) / millilitersOfWort;
        actualPitchRate = [self roundDecimal:actualPitchRate number:2];
        self.resultView.label2.value.text = [NSString stringWithFormat:@"%.2fM 细胞 / 毫升 / °P", actualPitchRate];
    }
    
    // 第二步
    if (self.starterYeastCount > 0) {
        double currentYeastCount = self.starterYeastCount;
        for (int i = 0; i < 3; i++) {
            double endingCount = 0;
            if ([(SecondStepItemView *)self.secondStepView.secondStepData[i] biZhongView].textValue.length == 0 ||
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] kuoPeiLiangView].textValue.length == 0) {
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label1].value.text = @"-";
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label2].value.text = @"-";
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label3].value.text = @"-";
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label4].value.text = @"-";
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label5].value.text = @"-";
                continue;
            }
            
            double gravityLevel = [[(SecondStepItemView *)self.secondStepView.secondStepData[i] biZhongView].textValue doubleValue];
            if ([self.gravityunit isEqualToString:@"plato"]) {
                gravityLevel = [self covertPlatoToGravity:gravityLevel];
            }
            gravityLevel = (gravityLevel - 1) * 1000;
            
            double volumeLevel = [[(SecondStepItemView *)self.secondStepView.secondStepData[i] kuoPeiLiangView].textValue doubleValue];
            volumeLevel = [self litersToGallons:volumeLevel];
            double pointsNeeded = volumeLevel * gravityLevel;
            double poundsDME = pointsNeeded / 42.0;
            double ouncesDME = poundsDME * 16;
            double gramsDME = [self ouncesToGrams:ouncesDME];
            ouncesDME = [self roundDecimal:ouncesDME number:1];
            gramsDME = [self roundDecimal:gramsDME number:1];
            [(SecondStepItemView *)self.secondStepView.secondStepData[i] label1].value.text = [NSString stringWithFormat:@"%.1f 盎司，%.1f 克", ouncesDME, gramsDME];
            
            double growthRate = 0;
            NSString *growthMethodSelected = [(SecondStepItemView *)self.secondStepView.secondStepData[i] growthMethodSelected];
            if ([growthMethodSelected isEqualToString:@"Braukaiser-Stirplate"]) {
                double cellsToGramsRatio = currentYeastCount / gramsDME;
                growthRate = [self growthRateCurveBraukaiserStir:cellsToGramsRatio];
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label2].value.text = [NSString stringWithFormat:@"%.1f, Intial Cells Per Extract (B/g): %.2f", [self roundDecimal:growthRate number:1], [self roundDecimal:cellsToGramsRatio number:2]];
                endingCount = (gramsDME * growthRate) + currentYeastCount;
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label3].value.text = [NSString stringWithFormat:@"%.f × 10亿 细胞", [self roundDecimal:endingCount number:0]];
            } else {
                double inoculationRate = currentYeastCount / [[(SecondStepItemView *)self.secondStepView.secondStepData[i] kuoPeiLiangView].textValue doubleValue];
                inoculationRate = [self roundDecimal:inoculationRate number:1];
                growthRate = [self growthRateCurveWhite:inoculationRate];
                if ([growthMethodSelected isEqualToString:@"搅拌"]) {
                    growthRate = growthRate + 0.5;
                }
                if ([growthMethodSelected isEqualToString:@"磁力搅拌器"]) {
                    growthRate = growthRate + 1.0;
                }
                if (growthRate > 6) {
                    growthRate = 6;
                }
                double growthRateForUser = growthRate;
                growthRateForUser = [self roundDecimal:growthRateForUser number:1];
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label2].value.text = [NSString stringWithFormat:@"%.1f, 接种率：%.1fM 细胞/毫升", growthRateForUser, inoculationRate];
                if (growthRate >= 6 || inoculationRate >= 200) {
                    // 饱和
                }
                endingCount = (1 + growthRate) * currentYeastCount;
                endingCount = [self roundDecimal:endingCount number:0];
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label3].value.text = [NSString stringWithFormat:@"%.f × 10亿 细胞", endingCount];
            }
            
            if (wortPlato <= 0 || millilitersOfWort <= 0) {
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label4].value.text = @"-";
            } else {
                double starterPitchRate = (endingCount * 1000) / wortPlato / millilitersOfWort;
                starterPitchRate = [self roundDecimal:starterPitchRate number:2];
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label4].value.text = [NSString stringWithFormat:@"%.2fM 细胞 / 毫升 / °P", starterPitchRate];
            }
            
            if (endingCount > yeastNeeded) {
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label5].value.textColor = [UIColor greenColor];
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label5].value.text = @"扩培达到渴望的扩赔率！";
            } else {
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label5].value.textColor = [UIColor redColor];
                [(SecondStepItemView *)self.secondStepView.secondStepData[i] label5].value.text = @"扩陪没有产生足够的酵母细胞. 需增加扩陪麦汁量, 改变aeration technique, 或者做再次扩陪.";
            }
            
            currentYeastCount = endingCount;
        }
    }
}

- (BOOL)checkInput {
    if ([self.gravityunit isEqualToString:@"sg"]) {
        if (self.wortGravity < 1 || self.wortGravity > 1.5) {
            [[JCGlobay sharedInstance] showErrorMessage:@"麦汁比重必须在1 ~ 1.5之间."];
            return NO;
        }
    }
    if ([self.gravityunit isEqualToString:@"plato"]) {
        if (self.wortGravity < 0 || self.wortGravity > 100) {
            [[JCGlobay sharedInstance] showErrorMessage:@"麦汁比重必须在0 ~ 100之间."];
            return NO;
        }
    }
    if ([self.yeastType isEqualToString:@"酵母泥"]) {
        if (self.yeast_slurry_denisty < 0 || self.yeast_slurry_denisty > 10) {
            [[JCGlobay sharedInstance] showErrorMessage:@"细胞浓度必须在0 ~ 10之间."];
            return NO;
        }
    }
    
    return YES;
}

- (double)growthRateCurveBraukaiserStir:(double)cellsToGramsRatio {
    if (cellsToGramsRatio < 1.4) {
        return 1.4;
    } else if (cellsToGramsRatio >= 1.4 && cellsToGramsRatio <= 3.5) {
        double newGrowth = 2.33 - (0.67 * cellsToGramsRatio);
        if (newGrowth < 0) {
            newGrowth = 0;
        }
        return newGrowth;
    }
    return 0;
}

- (double)growthRateCurveWhite:(double)x {
    if (x >= 200) {
        return 0;
    }
    if (x <= 5) {
        return 6;
    }
    double growth = (12.54793776 * pow(x, -0.4594858324)) - 0.9994994906;
    if (growth > 6) {
        growth = 6;
    }
    if (growth < 0) {
        growth = 0;
    }
    return growth;
}

@end
