//
//  Calculate9ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate9ViewController.h"

#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"

#import "LabelCellView.h"
#import "CalcButtonView.h"

#import "WeightAndGrainView.h"
#import "LNIngredientsModel.h"


typedef NS_ENUM(NSUInteger, Calculate9ViewControllerUnit) {
    Calculate9ViewControllerUnitUSA,
    Calculate9ViewControllerUnitMetric,
};


@interface Calculate9ViewController ()

@property (nonatomic, assign) Calculate9ViewControllerUnit unit;
@property (nonatomic, strong) NSArray <LNIngredientsModel *> *ingredients;

@end

@implementation Calculate9ViewController

- (void)viewDidLoad {
    
    self.navTitle = @"糖化效率计算";
    
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    
    self.unit = Calculate9ViewControllerUnitMetric;
    
    TwoRadioItemView *miduView = [[TwoRadioItemView alloc] initWithTitle:@"单位：" itemOne:@"美制-加仑/磅" itemTwo:@"公制-升/千克" defaultSelectedIndex:2];
    [self.tableView addCellView:miduView cellHeight:38];
    @weakify(self);

    
    TitleAndTextFieldView *volumeTextFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"麦汁体积(升)"];
    [self.tableView addCellView:volumeTextFieldView cellHeight:60];
    volumeTextFieldView.textField.text = @"21";

    TitleAndTextFieldView *relativeDensityFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"麦汁比重(格式1.xxx)"];
    [self.tableView addCellView:relativeDensityFieldView cellHeight:60];
    relativeDensityFieldView.textField.text = @"1.050";
    
    
    //重量和谷物
    NSArray *titles = [self.ingredients bk_map:^id(LNIngredientsModel *obj) {
        return obj.name;
    }];
    NSMutableArray <WeightAndGrainView *> *weightAndGrainViews = [NSMutableArray new];
    for (NSInteger index = 0; index<6; index++) {
        WeightAndGrainView *view = [WeightAndGrainView new];
        view.floatingView.titles = titles;
        view.contentView.backgroundColor = index%2==0?UIColorFromRGB(0xeeeeee):[UIColor whiteColor];
        [self.tableView addCellView:view cellHeight:60];
        [weightAndGrainViews addObject:view];
    }
    

    LabelCellView *div100lLabelCell = [LabelCellView new];
    div100lLabelCell.textLabel.text = @"最大糖化效率比重:1.0 - max";
    [self.tableView addCellView:div100lLabelCell cellHeight:30];

    LabelCellView *div75LabelCell = [LabelCellView new];
    div75LabelCell.textLabel.text = @"75%糖化效率比重:--";
    [self.tableView addCellView:div75LabelCell cellHeight:30];

    LabelCellView *divacturelabelCell = [LabelCellView new];
    divacturelabelCell.textLabel.text = @"糖化效率:--";
    [self.tableView addCellView:divacturelabelCell cellHeight:30];

    LabelCellView *ppgLabelCell = [LabelCellView new];
    ppgLabelCell.textLabel.text = @"分/磅/加仑(ppg):No mashed grains";
    [self.tableView addCellView:ppgLabelCell cellHeight:30];

    CalcButtonView *buttonView = [CalcButtonView new];
    [self.tableView addCellView:buttonView cellHeight:40];
    
    [self.tableView addCellView:[UIView new] cellHeight:49];
    
    [miduView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 1) {
            self.unit = Calculate9ViewControllerUnitUSA;
            volumeTextFieldView.title = @"麦汁体积(加仑)";
            volumeTextFieldView.textField.text = @"5.5";
            for (WeightAndGrainView *view in weightAndGrainViews) {
                view.textFieldView.title = @"重量(磅)";
            }
        } else {
            //            self.gravityunit = @"sg";
            self.unit = Calculate9ViewControllerUnitMetric;
            volumeTextFieldView.title = @"麦汁体积(升)";
            volumeTextFieldView.textField.text = @"21";
            for (WeightAndGrainView *view in weightAndGrainViews) {
                view.textFieldView.title = @"重量(千克)";
            }
        }
    }];
    
    [buttonView.button bk_addEventHandler:^(id sender){
        
        @strongify(self)
        
        var gravity = 1.050; //Gravity Measurement
        
        var batchsize = 0;
        switch (self.unit) {
            case Calculate9ViewControllerUnitUSA: {
                batchsize = volumeTextFieldView.textField.text.doubleValue;
                break;
            }
            case Calculate9ViewControllerUnitMetric: {
                batchsize = [self litersToGallons:volumeTextFieldView.textField.text.doubleValue];
                break;
            }
        }
        var totalPointsNonMash = 0;
        var totalPointsMash = 0;
        var totalPounds = 0;
        BOOL bNoMashables = NO;
        for (WeightAndGrainView *view in weightAndGrainViews) {
            
            NSInteger selectedIndex = view.floatingView.index;

            var pound = view.textFieldView.textField.text.doubleValue;
            
            switch (self.unit) {
                case Calculate9ViewControllerUnitUSA: {
                    break;
                }
                case Calculate9ViewControllerUnitMetric: {
                    pound = [self kilogramsToPounds:view.textFieldView.textField.text.doubleValue];
                    break;
                }
            }
            var points = self.ingredients[selectedIndex].ppg * pound;
            
            if (!!self.ingredients[selectedIndex].mashable) {
                totalPointsMash = totalPointsMash + points;
            }
            else{
                totalPointsNonMash = totalPointsNonMash + points;
            }
            
            totalPounds = totalPounds + pound;
        }
        
        if (totalPointsNonMash > 0 || totalPointsMash > 0) {
            var potentialPointsTotal = (totalPointsNonMash + totalPointsMash) / batchsize; // 320/6.5
            var potentialPointsMash = totalPointsMash / batchsize; //  320/6.5
            var potentialPointsNonMash = totalPointsNonMash / batchsize;
            var measuredPoints = ((gravity - 1) * 1000); //Gravity Measurement  (6.5-1)*1000 = 5500
            var efficiency = ((measuredPoints - potentialPointsNonMash) / potentialPointsMash) * 100;
            if (potentialPointsMash == 0) {
                efficiency = 100;
                bNoMashables = true;
            }
            div100lLabelCell.textLabel.text = [NSString stringWithFormat:@"最大糖化效率比重:%.3f - max",[self roundDecimal:(potentialPointsTotal / 1000) + 1 number:3]];
            if (bNoMashables) {
                div75LabelCell.textLabel.text = @"75%糖化效率比重:--";
                divacturelabelCell.textLabel.text = @"糖化效率:--";
                ppgLabelCell.textLabel.text = @"分/磅/加仑(ppg):No mashed grains";
            }
            else{
                div75LabelCell.textLabel.text = [NSString stringWithFormat:@"75%%糖化效率比重:%.3f",[self roundDecimal:((potentialPointsNonMash / 1000) + (potentialPointsMash / 1000) * 0.75) + 1 number:3]];
                divacturelabelCell.textLabel.text = [NSString stringWithFormat:@"糖化效率:%.2f%%",[self roundDecimal:efficiency number:2]];
                ppgLabelCell.textLabel.text = [NSString stringWithFormat:@"分/磅/加仑(ppg):%.2f",[self roundDecimal:(measuredPoints * batchsize) / totalPounds number:1]];
            }
        }
        else{
            div100lLabelCell.textLabel.text = @"最大糖化效率比重:1.0 - max";
            div75LabelCell.textLabel.text = @"75%糖化效率比重:--";
            divacturelabelCell.textLabel.text = @"糖化效率:--";
            ppgLabelCell.textLabel.text = @"分/磅/加仑(ppg):No mashed grains";
        }
        
    } forControlEvents:UIControlEventTouchUpInside];

}

- (NSArray *)ingredients{
    if (!_ingredients) {
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"LNIngredients9" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:file];
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil] mutableCopy];
        
        _ingredients = [array bk_map:^LNIngredientsModel *(NSDictionary *dict) {
            return [LNIngredientsModel modelObjectWithDictionary:dict];
        }];
    }
    return _ingredients;
}

@end
