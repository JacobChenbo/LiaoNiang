//
//  Calculate10ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 16/9/18.
//  Copyright © 2016年 Jacob. All rights reserved.
//

#import "Calculate10ViewController.h"

#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"
#import "Calculate4HeaderView.h"
#import "LabelCellView.h"
#import "CalcButtonView.h"
#import "ThreeRadioButtonsView.h"
#import "RadioButton.h"
#import "CheckBoxCellView.h"
#import "TitleAndLabelView.h"


typedef NS_ENUM(NSUInteger, Calculate10ViewControllerUnit) {
    Calculate10ViewControllerUnitUSA,
    Calculate10ViewControllerUnitMetric
};

typedef NS_ENUM(NSUInteger, Calculate10ViewControllerGravity) {
    Calculate10ViewControllerGravitySG,
    Calculate10ViewControllerGravityPlato
};

typedef NS_ENUM(NSUInteger, Calculate10ViewControllerCO2Unit) {
    Calculate10ViewControllerCO2UnitVolume,
    Calculate10ViewControllerCO2UnitGL,
};

typedef NS_ENUM(NSUInteger, Calculate10ViewControllerPrimingMethod) {
    Calculate10ViewControllerPrimingMethodGyle,
    Calculate10ViewControllerPrimingMethodGylew,
    Calculate10ViewControllerPrimingMethodKrausening
};


@interface Calculate10ViewController ()

@property (nonatomic, assign) Calculate10ViewControllerUnit unit;
@property (nonatomic, assign) Calculate10ViewControllerGravity gravity;
@property (nonatomic, assign) Calculate10ViewControllerCO2Unit co2Unit;
@property (nonatomic, assign) Calculate10ViewControllerPrimingMethod method;

@end

@implementation Calculate10ViewController

- (void)viewDidLoad {
    self.navTitle = @"碳化体积计算工具";
    
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    
    @weakify(self);

    TwoRadioItemView *unitRedioView = [[TwoRadioItemView alloc] initWithTitle:@"单位：" itemOne:@"美制-F" itemTwo:@"公制-C"];
    [self.tableView addCellView:unitRedioView cellHeight:38];
    self.unit = Calculate10ViewControllerUnitUSA;
    
    TwoRadioItemView *gravityRedioView = [[TwoRadioItemView alloc] initWithTitle:@"比重单位：" itemOne:@"SG(1.xxx)" itemTwo:@"Plato°P"];
    [self.tableView addCellView:gravityRedioView cellHeight:38];
    self.gravity = Calculate10ViewControllerGravitySG;
    
    TwoRadioItemView *co2RedioView = [[TwoRadioItemView alloc] initWithTitle:@"CO2单位：" itemOne:@"Volumes" itemTwo:@"g/l CO2"];
    [self.tableView addCellView:co2RedioView cellHeight:38];
    self.co2Unit = Calculate10ViewControllerCO2UnitVolume;


    TitleAndTextFieldView *txtWortVolumeTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"目标包装重量(Gallons)"];
    [self.tableView addCellView:txtWortVolumeTextFieldView cellHeight:60];
    txtWortVolumeTextFieldView.textField.text = @"5.0";

    TitleAndTextFieldView *txtVolumesTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"目标CO2量(volumes)"];
    [self.tableView addCellView:txtVolumesTextFieldView cellHeight:60];
    txtVolumesTextFieldView.textField.text = @"2.0";

    TitleAndTextFieldView *txtBeerTempTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"瓶装温度(F)"];
    [self.tableView addCellView:txtBeerTempTextFieldView cellHeight:60];
    txtBeerTempTextFieldView.textField.text = @"68";

    TitleAndTextFieldView *txtBeerOGTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"啤酒起始比重(1.xxx)"];
    [self.tableView addCellView:txtBeerOGTextFieldView cellHeight:60];
    txtBeerOGTextFieldView.textField.text = @"1.048";

    TitleAndTextFieldView *txtBeerFGTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"目标终止比重(1.xxx)"];
    [self.tableView addCellView:txtBeerFGTextFieldView cellHeight:60];
    txtBeerFGTextFieldView.textField.text = @"1.010";
    
    CheckBoxCellView *beerNotAtFGCheckBoxView = [CheckBoxCellView new];
    beerNotAtFGCheckBoxView.radioButton.textLabel.text = @"Beer gravity not at FG yet";
    [self.tableView addCellView:beerNotAtFGCheckBoxView cellHeight:40];
    
    TitleAndTextFieldView *txtBeerGravityTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"Beer's Current Gravity:(1.xxx)"];
    txtBeerGravityTextFieldView.textField.text = @"1.010";
    [self.tableView addCellView:txtBeerGravityTextFieldView cellHeight:0];

    
    {
        Calculate4HeaderView *headerView1 = [[Calculate4HeaderView alloc] initWithTitle:@"Priming Method"];
        [self.tableView addCellView:headerView1 cellHeight:45];
    }
    
    
    
    
    //三个按钮
    ThreeRadioButtonsView *methodThreeView = [ThreeRadioButtonsView new];
    [self.tableView addCellView:methodThreeView cellHeight:40];
    self.method = Calculate10ViewControllerPrimingMethodGyle;
    
    //文本
    Calculate4HeaderView *gyleTextView1 = [[Calculate4HeaderView alloc] initWithTitle:@"Gyle is expected to be unfermented and have the same OG/FG as the beer being packaged"];
    [self.tableView addCellView:gyleTextView1 cellHeight:120];
    
    //GyleOG
    TitleAndTextFieldView *txtGyleDiffOGTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"Gyle OG:(1.xxx)"];
    [self.tableView addCellView:txtGyleDiffOGTextFieldView cellHeight:0];
    txtGyleDiffOGTextFieldView.textField.text = @"1.048";

    //GyleFG
    TitleAndTextFieldView *txtGyleDiffFGtextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"Gyle FG:(1.xxx)"];
        [self.tableView addCellView:txtGyleDiffFGtextFieldView cellHeight:0];
        txtGyleDiffFGtextFieldView.textField.text = @"1.010";

    //KG
    TitleAndTextFieldView *txtkrausen_current_gravityTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"Krausen Gravity:(1.xxx)"];
    [self.tableView addCellView:txtkrausen_current_gravityTextFieldView cellHeight:0];
    txtkrausen_current_gravityTextFieldView.textField.text = @"1.048";

    //KEFG
    TitleAndTextFieldView *txtkrausen_fgTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"Krausen Expected FG:(1.xxx)"];
    [self.tableView addCellView:txtkrausen_fgTextFieldView cellHeight:0];
    txtkrausen_fgTextFieldView.textField.text = @"1.010";
    
    

    
    CheckBoxCellView *limitGyleCheckBoxView = [CheckBoxCellView new];
    limitGyleCheckBoxView.radioButton.textLabel.text = @"Limit Gyle on hand";
    [self.tableView addCellView:limitGyleCheckBoxView cellHeight:40];
    
    TitleAndTextFieldView *txtGyleAmountTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"Gyle Available:(Liters)"];
    txtGyleAmountTextFieldView.textField.text = @"1";
    [self.tableView addCellView:txtGyleAmountTextFieldView cellHeight:0];
    
    CalcButtonView *buttonView = [CalcButtonView new];
    [self.tableView addCellView:buttonView cellHeight:40];
    
    
    Calculate4HeaderView *co2UnitHeaderView1 = [[Calculate4HeaderView alloc] initWithTitle:@"CO2 contributions (volumes)"];
    [self.tableView addCellView:co2UnitHeaderView1 cellHeight:45];
    

    
    TitleAndLabelView *divCO2inBeerLabel = [[TitleAndLabelView alloc] initWithTitle:@"Beer: "];
    divCO2inBeerLabel.value.text = @"0.86";
    [self.tableView addCellView:divCO2inBeerLabel cellHeight:30];
    
    TitleAndLabelView *divCO2InWort = [[TitleAndLabelView alloc] initWithTitle:@"Unfermented Wort: "];
    divCO2InWort.value.text = @"";
    [self.tableView addCellView:divCO2InWort cellHeight:0];

    TitleAndLabelView *divCO2InGyleLabel = [[TitleAndLabelView alloc] initWithTitle:@"Gyle: "];
    divCO2InGyleLabel.value.text = @"1.14";
    [self.tableView addCellView:divCO2InGyleLabel cellHeight:30];

    TitleAndLabelView *divCO2FromPriming = [[TitleAndLabelView alloc] initWithTitle:@"Priming Sugar: "];
    divCO2FromPriming.value.text = @"0.26";
    [self.tableView addCellView:divCO2FromPriming cellHeight:0];
    
    TitleAndLabelView *divResultingCO2Label = [[TitleAndLabelView alloc] initWithTitle:@"Total: "];
    divResultingCO2Label.value.text = @"2.00";
    [self.tableView addCellView:divResultingCO2Label cellHeight:30];

    TitleAndLabelView *divVolumLabel = [[TitleAndLabelView alloc] initWithTitle:@"Gyle Needed: "];
    divVolumLabel.value.text = @"1.20L";
    [self.tableView addCellView:divVolumLabel cellHeight:30];
    
    
    TitleAndLabelView *divSugarRequiredLabel = [[TitleAndLabelView alloc] initWithTitle:@"Priming Sugar Needed:\r\n(Use one of the options)\r\n"];
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        divSugarRequiredLabel.titleLable.font = [UIFont systemFontOfSize:12];
    }
    divSugarRequiredLabel.value.text = @"";
    [self.tableView addCellView:divSugarRequiredLabel cellHeight:0];
    


    void (^recalculate)(id sender) = ^void (id sender){
        @strongify(self);
        
        //setVars start
        Calculate10ViewControllerUnit units = self.unit;
        Calculate10ViewControllerGravity sugarscale = self.gravity;
        Calculate10ViewControllerCO2Unit co2unit = self.co2Unit;
        
        var beervolume = txtWortVolumeTextFieldView.textField.text.doubleValue; //Volume Being Packaged:
        var targetVolumes = txtVolumesTextFieldView.textField.text.doubleValue; //Target CO2 Level:
        var beertemp = txtBeerTempTextFieldView.textField.text.doubleValue; //Temperature at Bottling
        var beerOG = txtBeerOGTextFieldView.textField.text.doubleValue; //Beer OG:
        var beerFG = txtBeerFGTextFieldView.textField.text.doubleValue; //Beer FG:
        var useBeerGravity = beerNotAtFGCheckBoxView.checked;
        var beerGravity = txtBeerGravityTextFieldView.textField.text.doubleValue;
        Calculate10ViewControllerPrimingMethod primingmethod = self.method;
        var gylediff_og = txtGyleDiffOGTextFieldView.textField.text.doubleValue;
        var gylediff_fg = txtGyleDiffFGtextFieldView.textField.text.doubleValue;
        var krausen_current_gravity = txtkrausen_current_gravityTextFieldView.textField.text.doubleValue;
        var krausen_fg = txtkrausen_fgTextFieldView.textField.text.doubleValue;
        BOOL limitGyle = limitGyleCheckBoxView.checked;
        var gyleAmount = txtGyleAmountTextFieldView.textField.text.doubleValue;
        //setVars end
        
        //checkInput start
        if (units == Calculate10ViewControllerUnitUSA) {
            if (beertemp <=32) {
                [[JCGlobay sharedInstance] showErrorMessage:@"温度必须大于32度"];
                return;
            }
            if (beertemp >=150) {
                [[JCGlobay sharedInstance] showErrorMessage:@"温度必须小于150度"];
                return;
            }
        }
        else{
            if (beertemp <=0) {
                [[JCGlobay sharedInstance] showErrorMessage:@"温度必须大于0度"];
                return;
            }
            if (beertemp >=66) {
                [[JCGlobay sharedInstance] showErrorMessage:@"温度必须小于66度"];
                return;
            }
        }
        //checkInput end
        
        var beerCO2_gl = 0;
        var unfermentedWortCO2_gl = 0;
        var gyleCO2_gl = 0;
        var primingSugarCO2_gl = 0;
        var totalCO2_gl = 0;
//        var gyleVolume_liters = 0;
        
        var targetCO2_gl = targetVolumes;
        if (co2unit == Calculate10ViewControllerCO2UnitVolume) {
            targetCO2_gl = targetCO2_gl * 2;
        }
        var gyleLimitLiters = gyleAmount;
        if (units == Calculate10ViewControllerUnitUSA) {
            gyleLimitLiters = [self quartsToLiters:gyleLimitLiters];
        }
        var temp = beertemp;
        if (units == Calculate10ViewControllerUnitMetric) {
            temp = [self celsiusToFahrenheit:temp];
        }
        var beerVolumesCO2 = 3.0378 - (0.050062 * temp) + (0.00026555 * temp * temp);
        beerCO2_gl = beerVolumesCO2 * 2;
        var og_p = beerOG;
        var fg_p = beerFG;
        var beer_p = beerGravity;
        var volume_l = beervolume;
        if (units == Calculate10ViewControllerUnitUSA) {
            volume_l = [self gallonsToLiters:volume_l];
        }
        if (sugarscale == Calculate10ViewControllerGravitySG) {
            og_p = [self convertGravityToPlato:og_p n:1];// convertGravityToPlato(og_p);
            fg_p = [self convertGravityToPlato:fg_p n:1];//convertGravityToPlato(fg_p);
            beer_p = [self convertGravityToPlato:beer_p n:1];// convertGravityToPlato(beer_p);
        }
        if (useBeerGravity && beer_p > fg_p) {
            var apparentAttenuation = (og_p - fg_p) / og_p * 100;
            var currentAttenuation = (og_p - beer_p) / og_p * 100;
            var desiredRealAttenuation = 0.82 * apparentAttenuation;
            var currentRealAttenuation = 0.82 * currentAttenuation;
            var difference = desiredRealAttenuation - currentRealAttenuation;
            var sugarsUnfermentedWort = volume_l * og_p * 10 * (difference / 100);
            var sugarsAvailForPriming = sugarsUnfermentedWort / volume_l;
            unfermentedWortCO2_gl = sugarsAvailForPriming / 2;
        }
        var gyle_og_p = og_p;
        var gyle_fg_p = fg_p;
        if (primingmethod == Calculate10ViewControllerPrimingMethodGylew || primingmethod == Calculate10ViewControllerPrimingMethodGyle) {
            gyle_og_p = gylediff_og;
            gyle_fg_p = gylediff_fg;
            if (sugarscale == Calculate10ViewControllerGravitySG) {
                gyle_og_p = [self convertGravityToPlato:gyle_og_p n:1];// convertGravityToPlato(gyle_og_p);
                gyle_fg_p = [self convertGravityToPlato:gyle_fg_p n:1];// convertGravityToPlato(gyle_fg_p);
            }
        }
        if (primingmethod == Calculate10ViewControllerPrimingMethodKrausening) {
            gyle_og_p = krausen_current_gravity;
            gyle_fg_p = krausen_fg;
            if (sugarscale == Calculate10ViewControllerGravitySG) {
                gyle_og_p = [self convertGravityToPlato:gyle_og_p n:1];// convertGravityToPlato(gyle_og_p);
                gyle_fg_p = [self convertGravityToPlato:gyle_fg_p n:1];// convertGravityToPlato(gyle_fg_p);
            }
        }
        if (targetCO2_gl <= (beerCO2_gl + unfermentedWortCO2_gl)) {
            divVolumLabel.value.text = @"None,Wort contributes too much CO2!";
            totalCO2_gl = (beerCO2_gl + unfermentedWortCO2_gl);
        }
        else{
            var c_k = 5 * 0.82 * (gyle_og_p - gyle_fg_p) * [self convertPlatoToGravity:gyle_og_p];// convertPlatoToGravity(gyle_og_p);
            var c_b = (beerCO2_gl + unfermentedWortCO2_gl);
            var V_gyle = volume_l * (targetCO2_gl - c_b) / (c_k - targetCO2_gl);
            if (limitGyle && gyleLimitLiters < V_gyle) {
                var gyle_appAttenuation = (gyle_og_p - gyle_fg_p) / gyle_og_p * 100;
                var gyle_RealAttenuation = 0.82 * gyle_appAttenuation;
                var sugar_grams_PerLiterOfGyle = gyle_og_p * 10 * (gyle_RealAttenuation / 100);
                var sugarsAvailFromGyle = sugar_grams_PerLiterOfGyle * gyleLimitLiters;
                var gyleSugarPerVolume = sugarsAvailFromGyle / (gyleLimitLiters + volume_l);
                gyleCO2_gl = gyleSugarPerVolume / 2;
                primingSugarCO2_gl = targetCO2_gl - (beerCO2_gl + unfermentedWortCO2_gl) - gyleCO2_gl;
                totalCO2_gl = targetCO2_gl;
                var sucrose_grams = primingSugarCO2_gl * (gyleLimitLiters + volume_l) * 2;
                var dextrose_grams = sucrose_grams / 0.91;
                var dme_grams = sucrose_grams / 0.68;
                NSString *weight_unit = @"g";
                if (units == Calculate10ViewControllerUnitUSA) {
                    sucrose_grams = [self gramToOunce:sucrose_grams];// gramsToOunces(sucrose_grams);
                    dextrose_grams = [self gramToOunce:dextrose_grams];// gramsToOunces(dextrose_grams);
                    dme_grams = [self gramToOunce:dme_grams];// gramsToOunces(dme_grams);
                    weight_unit = @"oz.";
                }
                if (IS_IPHONE_4 || IS_IPHONE_5) {
                    divSugarRequiredLabel.value.font = [UIFont systemFontOfSize:13];
                }
                divSugarRequiredLabel.value.text = [NSString stringWithFormat:@"Table Sugar: %.2f %@ \r\nCorn Sugar: %.2f %@ \r\nDME: %.2f %@",[self roundDecimal:sucrose_grams number:1],weight_unit,[self roundDecimal:dextrose_grams number:1],weight_unit,[self roundDecimal:dme_grams number:1],weight_unit];
                
//                NSString *volumeTitle = self.method == Calculate10ViewControllerPrimingMethodKrausening?@"Krausen Needed:":@"Gyle Needed:";
                divVolumLabel.title = self.method == Calculate10ViewControllerPrimingMethodKrausening?@"Krausen Needed:":@"Gyle Needed:";
                if (units == Calculate10ViewControllerUnitUSA) {
                    divVolumLabel.value.text = [NSString stringWithFormat:@"%.2f qt", [self roundDecimal:[self litersToQuarts:gyleLimitLiters] number:2]];//rounddecimal(litersToQuarts(gyleLimitLiters), 2) + " qt"
                } else {
                    divVolumLabel.value.text = [NSString stringWithFormat:@"%.2f L", [self roundDecimal:gyleLimitLiters number:2]];
                    //divVolume.innerHTML = rounddecimal(gyleLimitLiters, 2) + " L"
                }
            }
            else{
                gyleCO2_gl = targetCO2_gl - (beerCO2_gl + unfermentedWortCO2_gl);
                totalCO2_gl = targetCO2_gl;
//                NSString *volumeTitle = self.method == Calculate10ViewControllerPrimingMethodKrausening?@"Krausen Needed:":@"Gyle Needed:";
                divVolumLabel.title = self.method == Calculate10ViewControllerPrimingMethodKrausening?@"Krausen Needed:":@"Gyle Needed:";
                if (units == Calculate10ViewControllerUnitUSA) {
                    divVolumLabel.value.text = [NSString stringWithFormat:@"%.2f qt", [self roundDecimal:[self litersToQuarts:V_gyle] number:2]];//divVolume.innerHTML = rounddecimal(litersToQuarts(V_gyle), 2) + " qt"
                    
                } else {
                    divVolumLabel.value.text = [NSString stringWithFormat:@"%.2f L", [self roundDecimal:V_gyle number:2]];
                    //divVolume.innerHTML = rounddecimal(V_gyle, 2) + " L"
                }
            }
        }
        if (co2unit == Calculate10ViewControllerCO2UnitVolume) {
            beerCO2_gl = beerCO2_gl / 2;
            unfermentedWortCO2_gl = unfermentedWortCO2_gl / 2;
            gyleCO2_gl = gyleCO2_gl / 2;
            primingSugarCO2_gl = primingSugarCO2_gl / 2;
            totalCO2_gl = totalCO2_gl / 2;
        }
        divCO2inBeerLabel.value.text = [NSString stringWithFormat:@"%.2f",[self roundDecimal:beerCO2_gl number:2]] ;// rounddecimal(beerCO2_gl, 2);
        if (unfermentedWortCO2_gl > 0) {
            divCO2InWort.value.text = [NSString stringWithFormat:@"%.2f",[self roundDecimal:unfermentedWortCO2_gl number:2]];//rounddecimal(unfermentedWortCO2_gl, 2)
        }
//        NSString *gyleTitle = self.method == Calculate10ViewControllerPrimingMethodKrausening?@"Krausen:":@"Gyle:";
        divCO2InGyleLabel.title = self.method == Calculate10ViewControllerPrimingMethodKrausening?@"Krausen:":@"Gyle:";
        divCO2InGyleLabel.value.text = [NSString stringWithFormat:@"%.2f",[self roundDecimal:gyleCO2_gl number:2]];//rounddecimal(gyleCO2_gl, 2);
        if (primingSugarCO2_gl > 0) {
            divCO2FromPriming.value.text = [NSString stringWithFormat:@"%.2f",[self roundDecimal:primingSugarCO2_gl number:2]];// rounddecimal(primingSugarCO2_gl, 2)
        }
        divResultingCO2Label.value.text = [NSString stringWithFormat:@"%.2f",[self roundDecimal:totalCO2_gl number:2]];// rounddecimal(totalCO2_gl, 2)
        
    };
    
    
    
    
    //切换制式
    [unitRedioView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.unit = Calculate10ViewControllerUnitUSA;
            
            txtWortVolumeTextFieldView.title = @"目标包装重量(Gallons)";
            txtWortVolumeTextFieldView.textField.text = @"5.0";
            
            txtBeerTempTextFieldView.title = @"瓶装温度(F)";
            txtBeerTempTextFieldView.textField.text = @"68";
            
            
            if (self.method == Calculate10ViewControllerPrimingMethodKrausening) {
                txtGyleAmountTextFieldView.title = @"Krausen Available:(qt)";
            }
            else{
                txtGyleAmountTextFieldView.title = @"Gyle Available:(qt)";
            }
            
            
        }
        if (index == 2) {
            self.unit = Calculate10ViewControllerUnitMetric;
            
            txtWortVolumeTextFieldView.title = @"目标包装重量(Liters)";
            txtWortVolumeTextFieldView.textField.text = @"19";
            
            txtBeerTempTextFieldView.title = @"瓶装温度(C)";
            txtBeerTempTextFieldView.textField.text = @"20";
            
            if (self.method == Calculate10ViewControllerPrimingMethodKrausening) {
                txtGyleAmountTextFieldView.title = @"Krausen Available:(Liters)";
            }
            else{
                txtGyleAmountTextFieldView.title = @"Gyle Available:(Liters)";
            }
        }
        recalculate(nil);
    }];
    
    //切换比重
    [gravityRedioView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.gravity = Calculate10ViewControllerGravitySG;
            
            txtBeerOGTextFieldView.title = @"啤酒起始比重(1.xxx)";
            txtBeerOGTextFieldView.textField.text = @"1.048";
            
            txtBeerFGTextFieldView.title = @"目标终止比重(1.xxx)";
            txtBeerFGTextFieldView.textField.text = @"1.010";
            
            txtBeerGravityTextFieldView.title = @"Beer's Current Gravity:(1.xxx)";
            txtBeerGravityTextFieldView.textField.text = @"1.010";// txtbeerGravity.value = "1.010";
            
            txtGyleDiffOGTextFieldView.title = @"Gyle OG:(1.xxx)";
            txtGyleDiffOGTextFieldView.textField.text = @"1.048";// txtgylediff_og.value = "1.048";
            
            txtGyleDiffFGtextFieldView.title = @"Gyle FG:(1.xxx)";
            txtGyleDiffFGtextFieldView.textField.text = @"1.010";// txtgylediff_fg.value = "1.010";
            
            txtkrausen_current_gravityTextFieldView.title = @"Krausen Gravity:(1.xxx)";
            txtkrausen_current_gravityTextFieldView.textField.text = @"1.048";// txtkrausen_current_gravity.value = "1.048";
            
            txtkrausen_fgTextFieldView.title = @"Krausen Expected FG:(1.xxx)";
            txtkrausen_fgTextFieldView.textField.text = @"1.010";// txtkrausen_fg.value = "1.010";
            
        }
        if (index == 2) {
            self.gravity = Calculate10ViewControllerGravityPlato;
            
            txtBeerOGTextFieldView.title = @"啤酒起始比重(°P)";
            txtBeerOGTextFieldView.textField.text = @"12";
            
            txtBeerFGTextFieldView.title = @"目标终止比重(°P)";
            txtBeerFGTextFieldView.textField.text = @"3";
            
            txtBeerGravityTextFieldView.title = @"Beer's Current Gravity:(°P)";
            txtBeerGravityTextFieldView.textField.text = @"3";// txtbeerGravity.value = "1.010";
            
            txtGyleDiffOGTextFieldView.title = @"Gyle OG:(°P)";
            txtGyleDiffOGTextFieldView.textField.text = @"12";// txtgylediff_og.value = "1.048";
            
            txtGyleDiffFGtextFieldView.title = @"Gyle FG:(°P)";
            txtGyleDiffFGtextFieldView.textField.text = @"3";// txtgylediff_fg.value = "1.010";
            
            txtkrausen_current_gravityTextFieldView.title = @"Krausen Gravity:(°P)";
            txtkrausen_current_gravityTextFieldView.textField.text = @"12";// txtkrausen_current_gravity.value = "1.048";
            
            txtkrausen_fgTextFieldView.title = @"Krausen Expected FG:(°P)";
            txtkrausen_fgTextFieldView.textField.text = @"3";// txtkrausen_fg.value = "1.010";
        }
        recalculate(nil);
    }];
    
    //切换CO2单位
    [co2RedioView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.co2Unit = Calculate10ViewControllerCO2UnitVolume;
            
            co2UnitHeaderView1.titleLabel.text = @"CO2 contributions (volumes)";
            
            txtVolumesTextFieldView.title = @"目标CO2量(volumes)";
            txtVolumesTextFieldView.textField.text = @"2.0";
        }
        if (index == 2) {
            self.co2Unit = Calculate10ViewControllerCO2UnitGL;
            
            co2UnitHeaderView1.titleLabel.text = @"CO2 contributions g/l";

            txtVolumesTextFieldView.title = @"目标CO2量(g/l)";
            txtVolumesTextFieldView.textField.text = @"4.0";
        }
        recalculate(nil);
    }];

    [beerNotAtFGCheckBoxView setCheckedDidChangeBlock:^(BOOL checked) {
        [self.tableView resetHeightOfCellView:txtBeerGravityTextFieldView withHeight:checked?60:0 animated:0];
        [self.tableView resetHeightOfCellView:divCO2InWort withHeight:checked?30:0 animated:0];
        recalculate(nil);
    }];
    
    
    [limitGyleCheckBoxView setCheckedDidChangeBlock:^(BOOL checked) {
        [self.tableView resetHeightOfCellView:divSugarRequiredLabel withHeight:checked?80:0 animated:0];
        [self.tableView resetHeightOfCellView:divCO2FromPriming withHeight:checked?30:0 animated:0];
        [self.tableView resetHeightOfCellView:txtGyleAmountTextFieldView withHeight:checked?60:0 animated:0];
        recalculate(nil);
    }];

    //3方法切换
    [methodThreeView setSelectedIndexDidChangeBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 0) {
            self.method = Calculate10ViewControllerPrimingMethodGyle;
            
            [self.tableView resetHeightOfCellView:gyleTextView1 withHeight:120 animated:0];
            [self.tableView resetHeightOfCellView:txtGyleDiffOGTextFieldView withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtGyleDiffFGtextFieldView withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtkrausen_current_gravityTextFieldView withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtkrausen_fgTextFieldView withHeight:0 animated:0];
            
            limitGyleCheckBoxView.radioButton.textLabel.text = @"Limit Gyle on hand";
            
            if (self.unit == Calculate10ViewControllerUnitUSA) {
                txtGyleAmountTextFieldView.title = @"Gyle Available:(qt)";
            }
            else{
                txtGyleAmountTextFieldView.title = @"Gyle Available:(Liters)";
            }
            
        }
        if (index == 1) {
            self.method = Calculate10ViewControllerPrimingMethodGylew;

            [self.tableView resetHeightOfCellView:gyleTextView1 withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtGyleDiffOGTextFieldView withHeight:60 animated:0];
            [self.tableView resetHeightOfCellView:txtGyleDiffFGtextFieldView withHeight:60 animated:0];
            [self.tableView resetHeightOfCellView:txtkrausen_current_gravityTextFieldView withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtkrausen_fgTextFieldView withHeight:0 animated:0];
            
            limitGyleCheckBoxView.radioButton.textLabel.text = @"Limit Gyle on hand";
            if (self.unit == Calculate10ViewControllerUnitUSA) {
                txtGyleAmountTextFieldView.title = @"Gyle Available:(qt)";
            }
            else{
                txtGyleAmountTextFieldView.title = @"Gyle Available:(Liters)";
            }
        }
        if (index == 2) {
            self.method = Calculate10ViewControllerPrimingMethodKrausening;

            [self.tableView resetHeightOfCellView:gyleTextView1 withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtGyleDiffOGTextFieldView withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtGyleDiffFGtextFieldView withHeight:0 animated:0];
            [self.tableView resetHeightOfCellView:txtkrausen_current_gravityTextFieldView withHeight:60 animated:0];
            [self.tableView resetHeightOfCellView:txtkrausen_fgTextFieldView withHeight:60 animated:0];
            
            limitGyleCheckBoxView.radioButton.textLabel.text = @"Limit Krausen on hand";
            if (self.unit == Calculate10ViewControllerUnitUSA) {
                txtGyleAmountTextFieldView.title = @"Krausen Available:(qt)";
            }
            else{
                txtGyleAmountTextFieldView.title = @"Krausen Available:(Liters)";
            }
            
        }
        recalculate(nil);
    }];
    
    [buttonView.button bk_addEventHandler:recalculate  forControlEvents:UIControlEventTouchUpInside];
    
    {
        {
            Calculate4HeaderView *headerView1 = [[Calculate4HeaderView alloc] initWithTitle:@"Carbonation Guidelines by Style"];
            [self.tableView addCellView:headerView1 cellHeight:45];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"英式艾尔 1.5～2.0";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"比式艾尔 1.9-2.4";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"美式艾尔和拉格 2.2 - 2.7";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"水果兰比克 3.0～4.5";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"波特，世涛 1.7～2.3";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"欧洲拉格 2.2 - 2.7";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"兰比克 2.4～2.8";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }{
            LabelCellView *jiujingdu = [LabelCellView new];
            jiujingdu.textLabel.text = @"德国小麦啤酒 3.3～4.5";
            [self.tableView addCellView:jiujingdu cellHeight:30];
        }
        
        [self.tableView addCellView:[UIView new] cellHeight:30];
    
    }
    
}

@end
