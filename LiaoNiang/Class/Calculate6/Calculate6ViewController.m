//
//  Calculate6ViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/25/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "Calculate6ViewController.h"

#import "Calculate4HeaderView.h"
#import "TitleAndTextFieldView.h"

#import "LabelCellView.h"
#import "CalcButtonView.h"


@interface Calculate6ViewController ()

@end

@implementation Calculate6ViewController

- (void)viewDidLoad {
    
    self.navTitle = @"酒精度数换算";

    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    
//    double brix = 21;
//    double sg = 1.0875;
    
    {
        Calculate4HeaderView *headerView1 = [[Calculate4HeaderView alloc] initWithTitle:@"白利糖度转比重计算"];
        [self.tableView addCellView:headerView1 cellHeight:45];
        
        TitleAndTextFieldView *tiJi1View = [[TitleAndTextFieldView alloc] initWithTitle:@"白利糖度"];
        [self.tableView addCellView:tiJi1View cellHeight:60];
        tiJi1View.textField.text = @"22";
        
        //比重
        LabelCellView *tangdubizhong = [LabelCellView new];
        tangdubizhong.textLabel.text = @"比重:1.092";
        [self.tableView addCellView:tangdubizhong cellHeight:30];
        //酒精度
        LabelCellView *jiujingdu = [LabelCellView new];
        jiujingdu.textLabel.text = @"酒精度:12.9%";
        [self.tableView addCellView:jiujingdu cellHeight:30];
        
        CalcButtonView *buttonView = [CalcButtonView new];
        [self.tableView addCellView:buttonView cellHeight:40];
        
        [buttonView.button bk_addEventHandler:^(id sender) {
            
            double brix = tiJi1View.textField.text.doubleValue;
            
            double calculated_sg = (brix / (258.6 - ((brix / 258.2) * 227.1))) + 1;
            {
                double result = [self roundDecimal:calculated_sg number:4];
                tangdubizhong.textLabel.text = [NSString stringWithFormat:@"比重:%@",@(result)];
            }
            {
                double og = calculated_sg;
                double fg = 1.000;
                double abw = 76.08 * (og - fg) / (1.775 - og);
                double abv = abw * (fg / 0.794);
                double result = [self roundDecimal:abv number:1];
                jiujingdu.textLabel.text = [NSString stringWithFormat:@"酒精度:%@%%",@(result)];
            }

            
        } forControlEvents:UIControlEventTouchUpInside];

    }
    {
        Calculate4HeaderView *headerView1 = [[Calculate4HeaderView alloc] initWithTitle:@"比重转白利糖度计算"];
        [self.tableView addCellView:headerView1 cellHeight:45];
        
        TitleAndTextFieldView *tiJi1View = [[TitleAndTextFieldView alloc] initWithTitle:@"比重"];
        [self.tableView addCellView:tiJi1View cellHeight:60];
        tiJi1View.textField.text = @"1.092";
        
        //比重
        LabelCellView *tangdubizhong = [LabelCellView new];
        tangdubizhong.textLabel.text = @"白利糖度:22.0";
        [self.tableView addCellView:tangdubizhong cellHeight:30];
        //酒精度
        LabelCellView *jiujingdu = [LabelCellView new];
        jiujingdu.textLabel.text = @"酒精度:12.9%";
        [self.tableView addCellView:jiujingdu cellHeight:30];
        
        CalcButtonView *buttonView = [CalcButtonView new];
        [self.tableView addCellView:buttonView cellHeight:40];
        
        [self.tableView addCellView:[UIView new] cellHeight:49];
        
        [buttonView.button bk_addEventHandler:^(id sender) {
            
            double sg = tiJi1View.textField.text.doubleValue;
            {
                double calculated_brix = (((182.4601 * sg - 775.6821) * sg + 1262.7794) * sg - 669.5622);
                double result = [self roundDecimal:calculated_brix number:1];
                tangdubizhong.textLabel.text = [NSString stringWithFormat:@"白利糖度:%@",@(result)];
            }
            {
                double og = sg;
                double fg = 1.000;
                double abw = 76.08 * (og - fg) / (1.775 - og);
                double abv = abw * (fg / 0.794);
                double result = [self roundDecimal:abv number:1];
                jiujingdu.textLabel.text = [NSString stringWithFormat:@"酒精度:%@%%",@(result)];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
    }

    
}

@end
