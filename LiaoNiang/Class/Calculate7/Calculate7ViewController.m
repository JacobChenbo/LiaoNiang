//
//  Calculate7ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate7ViewController.h"

#import "TwoRadioItemView.h"
#import "TitleAndTextFieldView.h"
#import "Calculate7ColorCellView.h"

#import "LabelCellView.h"
#import "CalcButtonView.h"

#import "WeightAndGrainView.h"
#import "LNIngredientsModel.h"

#import "UIColor+HexColor.h"


typedef NS_ENUM(NSUInteger, Calculate7ViewControllerSelectedUnit) {
    Calculate7ViewControllerSelectedUnitAmerican,//美制
    Calculate7ViewControllerSelectedUnitMetric,//公制
};


@interface Calculate7ViewController ()

@property (nonatomic, assign) Calculate7ViewControllerSelectedUnit unit;
@property (nonatomic, strong) NSArray <LNIngredientsModel *> *ingredients;
@property (nonatomic, strong) NSArray *srm;

@end

@implementation Calculate7ViewController

- (void)viewDidLoad {
    
    self.navTitle = @"色度计算";
    
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    
    TwoRadioItemView *miduView = [[TwoRadioItemView alloc] initWithTitle:@"单位：" itemOne:@"美制-加仑/磅" itemTwo:@"公制-升/千克" defaultSelectedIndex:2];
    self.unit = Calculate7ViewControllerSelectedUnitMetric;
    [self.tableView addCellView:miduView cellHeight:38];
    @weakify(self);

    
    TitleAndTextFieldView *textFieldView = [[TitleAndTextFieldView alloc] initWithTitle:@"批次量(升)"];
    [self.tableView addCellView:textFieldView cellHeight:60];
    textFieldView.textField.text = @"21";
    
    
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
    

    LabelCellView *srmLabelCell = [LabelCellView new];
    srmLabelCell.textLabel.text = @"SRM:0.0";
    [self.tableView addCellView:srmLabelCell cellHeight:30];

    LabelCellView *emcLabelCell = [LabelCellView new];
    emcLabelCell.textLabel.text = @"EMC:0.0";
    [self.tableView addCellView:emcLabelCell cellHeight:30];

    Calculate7ColorCellView *colorCell = [Calculate7ColorCellView new];
    [self.tableView addCellView:colorCell cellHeight:50];

    
    CalcButtonView *buttonView = [CalcButtonView new];
    [self.tableView addCellView:buttonView cellHeight:40];
    
    [self.tableView addCellView:[UIView new] cellHeight:49];
    
    
    [buttonView.button bk_addEventHandler:^(id sender) {
        //取容量
        @strongify(self);
        double batchsize = 0;
        switch (self.unit) {
            case Calculate7ViewControllerSelectedUnitAmerican: {
                batchsize = textFieldView.textField.text.doubleValue;
                break;
            }
            case Calculate7ViewControllerSelectedUnitMetric: {
                batchsize = [self litersToGallons:textFieldView.textField.text.doubleValue];
                break;
            }
        }
        
        double totalMCU = 0;
        for (WeightAndGrainView *view in weightAndGrainViews) {
            
            NSInteger selectedIndex = view.floatingView.index;
            
            double lovibond = self.ingredients[selectedIndex].lovibond;
            double volume = 0;
            switch (self.unit) {
                case Calculate7ViewControllerSelectedUnitAmerican: {
                    volume = view.textFieldView.textField.text.doubleValue;
                    break;
                }
                case Calculate7ViewControllerSelectedUnitMetric: {
                    volume = [self kilogramsToPounds:view.textFieldView.textField.text.doubleValue];
                    break;
                }
            }
            
            double MCU = lovibond * (volume/batchsize);
            totalMCU = totalMCU +MCU;
        }
        double newsrm = 1.4922 * pow(totalMCU, 0.6859);
        if (newsrm >= 40) {
            newsrm = 40;
        }
        
        srmLabelCell.textLabel.text = [NSString stringWithFormat:@"SRM:%.2f",[self roundDecimal:newsrm number:2]];
        emcLabelCell.textLabel.text = [NSString stringWithFormat:@"EMC:%.2f",[self roundDecimal:newsrm*1.97 number:2]];
        colorCell.colorView.backgroundColor = [UIColor colorWithHexString:self.srm[(NSInteger)[self roundDecimal:newsrm number:2]]];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [miduView setItemSelectedIndexBlock:^(NSInteger index) {
        @strongify(self);
        if (index == 2) {
            //            self.gravityunit = @"plato";
            self.unit = Calculate7ViewControllerSelectedUnitMetric;
            textFieldView.title = @"批次量(升)";
            textFieldView.textField.text = @"21";
            for (WeightAndGrainView *view in weightAndGrainViews) {
                view.textFieldView.title = @"重量(千克)";
            }
            
        } else {
            self.unit = Calculate7ViewControllerSelectedUnitAmerican;
            textFieldView.title = @"批次量(加仑)";
            textFieldView.textField.text = @"5.5";
            for (WeightAndGrainView *view in weightAndGrainViews) {
                view.textFieldView.title = @"重量(磅)";
            }
        }
    }];
    
}


- (NSArray *)ingredients{
    if (!_ingredients) {
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"LNIngredients7" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:file];
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil] mutableCopy];
        
        _ingredients = [array bk_map:^LNIngredientsModel *(NSDictionary *dict) {
            return [LNIngredientsModel modelObjectWithDictionary:dict];
        }];
    }
    return _ingredients;
}

- (NSArray *)srm{
    if (!_srm) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"LNsrm7" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:file];
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil] mutableCopy];
        _srm = array;
    }
    return _srm;
}

@end
