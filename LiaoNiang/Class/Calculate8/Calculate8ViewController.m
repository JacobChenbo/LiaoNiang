//
//  Calculate8ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate8ViewController.h"
#import "RadioButtonsView.h"

#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"

#import "LabelCellView.h"
#import "CalcButtonView.h"


typedef NS_ENUM(NSUInteger, Calculate8ViewControllerUnit) {
    Calculate8ViewControllerUnitDan,//美制 - 石/磅/F
    Calculate8ViewControllerUnitGallon,//美制 - 加仑/磅/F
    Calculate8ViewControllerUnitMetric,//公制 - 升/千克/C
};

typedef NS_ENUM(NSUInteger, Calculate8ViewControllerWater) {
    Calculate8ViewControllerWaterRate,//水/料比
    Calculate8ViewControllerWaterFinal,//最终用水量
};


@interface Calculate8ViewController ()

@property (nonatomic, assign) Calculate8ViewControllerUnit unit;
@property (nonatomic, assign) Calculate8ViewControllerWater water;
@property (nonatomic, readonly) double MASH_EQUATION_CONSTANT;

@end

@implementation Calculate8ViewController

- (void)viewDidLoad {
    
    self.navTitle = @"糖化用水计算";
    
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    NSArray *titles = @[@"美制 - 石/磅/F", @"美制 - 加仑/磅/F", @"公制 - 升/千克/C", ];
    self.unit = Calculate8ViewControllerUnitGallon;
    self.water = Calculate8ViewControllerWaterRate;
    RadioButtonsView *radioButtonsView = [[RadioButtonsView alloc] initWithTitle:@"单位:" titles:titles defaultSelectedIndex:1];
    [self.tableView addCellView:radioButtonsView cellHeight:40*titles.count];

    TitleAndTextFieldView *grainweightTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"麦粒重量(lb)"];
    [self.tableView addCellView:grainweightTextFieldView cellHeight:60];
    grainweightTextFieldView.textField.text = @"10";
    
    TwoRadioItemView *miduView = [[TwoRadioItemView alloc] initWithTitle:@"用水计量方式：" itemOne:@"水/料比" itemTwo:@"最终用水量"];
    [self.tableView addCellView:miduView cellHeight:38];

    TitleAndTextFieldView *mashratioTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"水/料比(加仑/磅)"];
    [self.tableView addCellView:mashratioTextFieldView cellHeight:60];
    mashratioTextFieldView.textField.text = @"0.31";
    
    TitleAndTextFieldView *mashVolumeTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"最终用水量(加仑)"];
    [self.tableView addCellView:mashVolumeTextFieldView cellHeight:0];
    mashVolumeTextFieldView.textField.text = @"3.1";

    TitleAndTextFieldView *targettempTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"一步出糖温度(F)"];
    [self.tableView addCellView:targettempTextFieldView cellHeight:60];
    targettempTextFieldView.textField.text = @"155";

    TitleAndTextFieldView *graintempTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"麦粒温度(F)(范围:32-150(F))"];
    [self.tableView addCellView:graintempTextFieldView cellHeight:60];
    graintempTextFieldView.textField.text = @"65";

    TitleAndTextFieldView *boilingtempTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"煮沸温度(F)(范围:180-215(F))"];
    [self.tableView addCellView:boilingtempTextFieldView cellHeight:60];
    boilingtempTextFieldView.textField.text = @"212";


    LabelCellView *volumeLabelCell = [LabelCellView new];
    volumeLabelCell.textLabel.text = @"最终用水量:3.1(Gallons)";
    [self.tableView addCellView:volumeLabelCell cellHeight:30];

    LabelCellView *tempratureLabelCell = [LabelCellView new];
    tempratureLabelCell.textLabel.text = @"最终用水温度:169.5(F)";
    [self.tableView addCellView:tempratureLabelCell cellHeight:30];

    
    CalcButtonView *buttonView = [CalcButtonView new];
    [self.tableView addCellView:buttonView cellHeight:40];
    
    [self.tableView addCellView:[UIView new] cellHeight:49];
    
    @weakify(self);
    [miduView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.water = Calculate8ViewControllerWaterRate;
            [self.tableView resetHeightOfCellView:mashratioTextFieldView withHeight:60 animated:NO];
            [self.tableView resetHeightOfCellView:mashVolumeTextFieldView withHeight:0 animated:NO];
        } else {
            self.water = Calculate8ViewControllerWaterFinal;
            [self.tableView resetHeightOfCellView:mashratioTextFieldView withHeight:0 animated:NO];
            [self.tableView resetHeightOfCellView:mashVolumeTextFieldView withHeight:60 animated:NO];
        }
    }];
    
    
    void (^calcBlock)(id sendet) = ^(id sender){
        
        @strongify(self)
        //麦粒重量
        double grainweight = grainweightTextFieldView.textField.text.doubleValue;
        
        //水料比
        double mashratio = mashratioTextFieldView.textField.text.doubleValue;
        //用水量
        double mashvolume = mashVolumeTextFieldView.textField.text.doubleValue;
        //出糖温度
        double targettemp = targettempTextFieldView.textField.text.doubleValue;
        //麦粒温度
        double graintemp = graintempTextFieldView.textField.text.doubleValue;
        //煮沸温度
        double boilingtemp = boilingtempTextFieldView.textField.text.doubleValue;
        
        //取值范围校验
        switch (self.unit) {
            case Calculate8ViewControllerUnitDan:
            case Calculate8ViewControllerUnitGallon: {
                if (boilingtemp>215 || boilingtemp<180 || graintemp<32 || graintemp>150) {
                    [[JCGlobay sharedInstance] showErrorMessage:@"请在输入框中输入正确的温度范围"];
                    return ;
                }
                
                break;
            }
            case Calculate8ViewControllerUnitMetric: {
                if (boilingtemp>102 || boilingtemp<80 || graintemp<0 || graintemp>100) {
                    [[JCGlobay sharedInstance] showErrorMessage:@"请在输入框中输入正确的温度范围"];
                    return ;
                }
                break;
            }
        }
        //
        double strikevolume;// = mashVolumeTextFieldView.textField.text.doubleValue;
        
        double striketemp = ((self.MASH_EQUATION_CONSTANT / mashratio) * (targettemp - graintemp)) + targettemp;
        
        switch (self.water) {
            case Calculate8ViewControllerWaterRate: {
                
                strikevolume = mashratio * grainweight;
                mashvolume = strikevolume;
                
                break;
            }
            case Calculate8ViewControllerWaterFinal: {
                strikevolume = mashvolume;
                if (grainweight > 0) {
                    mashratio = mashvolume / grainweight;
                }
                break;
            }
        }
        mashratioTextFieldView.textField.text = [NSString stringWithFormat:@"%.2f",mashratio];
        mashVolumeTextFieldView.textField.text = [NSString stringWithFormat:@"%.2f",mashvolume];
        tempratureLabelCell.textLabel.text = [NSString stringWithFormat:@"最终用水温度:%.1f(%@)",[self roundDecimal:striketemp number:1],[self tempUnitString]];
        volumeLabelCell.textLabel.text = [NSString stringWithFormat:@"最终用水量%.2f(%@)",[self roundDecimal:strikevolume number:2],[self volumeUnitString]];
    };
    
    
    
    [radioButtonsView setSelectedIndexDidChangeBlock:^(RadioButtonsView *view) {
        if (view.selectedIndex == 0) {
            self.unit = Calculate8ViewControllerUnitDan;
            
            mashVolumeTextFieldView.title = @"最终用水量(石)";
            mashratioTextFieldView.title = @"水/料比(石/磅)";
            graintempTextFieldView.title = @"麦粒温度(F)(范围:32-150(F))";
            boilingtempTextFieldView.title = @"煮沸温度(F)(范围:180-215(F))";
            
            grainweightTextFieldView.textField.text = @"10";
            graintempTextFieldView.textField.text = @"65";
            mashratioTextFieldView.textField.text = @"1.25";
            mashVolumeTextFieldView.textField.text = @"12.5";
            targettempTextFieldView.textField.text = @"155";
            boilingtempTextFieldView.textField.text = @"212";
            
        }
        else if (view.selectedIndex == 1) {
            self.unit = Calculate8ViewControllerUnitGallon;
            
            mashVolumeTextFieldView.title = @"最终用水量(加仑)";
            mashratioTextFieldView.title = @"水/料比(加仑/磅)";
            graintempTextFieldView.title = @"麦粒温度(F)(范围:32-150(F))";
            boilingtempTextFieldView.title = @"煮沸温度(F)(范围:180-215(F))";
            
            grainweightTextFieldView.textField.text = @"10";
            graintempTextFieldView.textField.text = @"65";
            mashratioTextFieldView.textField.text = @"0.3125";
            mashVolumeTextFieldView.textField.text = @"3.125";
            targettempTextFieldView.textField.text = @"155";
            boilingtempTextFieldView.textField.text = @"212";
        }
        else if (view.selectedIndex == 2) {
            self.unit = Calculate8ViewControllerUnitMetric;
            
            mashVolumeTextFieldView.title = @"最终用水量(升)";
            mashratioTextFieldView.title = @"水/料比(升/千克)";
            graintempTextFieldView.title = @"麦粒温度(C)(范围:0-100(C))";
            boilingtempTextFieldView.title = @"煮沸温度(C)(范围:80-102(C))";
            
            grainweightTextFieldView.textField.text = @"4.5";
            graintempTextFieldView.textField.text = @"18";
            mashratioTextFieldView.textField.text = @"2.5";
            mashVolumeTextFieldView.textField.text = @"11.25";
            targettempTextFieldView.textField.text = @"68";
            boilingtempTextFieldView.textField.text = @"100";
        }
        
        calcBlock(nil);
    }];

    
    

    
    
    [buttonView.button bk_addEventHandler:calcBlock  forControlEvents:UIControlEventTouchUpInside];
}

- (NSString *)volumeUnitString{
    switch (self.unit) {
        case Calculate8ViewControllerUnitDan: {
            return @"Quarts";
            break;
        }
        case Calculate8ViewControllerUnitGallon: {
            return @"Gallons";
            break;
        }
        case Calculate8ViewControllerUnitMetric: {
            return @"Liters";
            break;
        }
    }
}

- (NSString *)tempUnitString{
    switch (self.unit) {
        case Calculate8ViewControllerUnitDan: {
            return @"F";
            break;
        }
        case Calculate8ViewControllerUnitGallon: {
            return @"F";
            break;
        }
        case Calculate8ViewControllerUnitMetric: {
            return @"C";
            break;
        }
    }
}

- (double)MASH_EQUATION_CONSTANT{
    switch (self.unit) {
        case Calculate8ViewControllerUnitDan: {
            return 0.2;
            break;
        }
        case Calculate8ViewControllerUnitGallon: {
            return 0.05;
            break;
        }
        case Calculate8ViewControllerUnitMetric: {
            return 0.41;
            break;
        }
    }
}

@end
