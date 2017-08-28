//
//  BaseViewController.h
//  LiaoNiang
//
//  Created by Jacob on 8/22/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNoneReuseAutoHeightTabelView.h"

@interface BaseCalculateViewController : UIViewController

@property (nonatomic, strong) HXNoneReuseAutoHeightTabelView *tableView;
@property (nonatomic, strong) NSString *navTitle;

- (double)roundDecimal:(double)plato number:(NSInteger)places;

- (double)convertPlatoToGravity:(double)plato;

- (double)convertGravityToPlato:(double)sg n:(double)n;

//摄氏转华氏
- (double)celsiusToFahrenheit:(double)celsius;

//升转加仑
- (double)litersToGallons:(double)liters;

//加仑转升
- (double)gallonsToLiters:(double)gallons;

//千克转磅
- (double)kilogramsToPounds:(double)kg;

//克转盎司
- (double)gramToOunce:(double)gram;

//夸脱转升
- (double)quartsToLiters:(double)quarts;

//升转夸脱
- (double)litersToQuarts:(double)liters;
//盎司转克
- (double)ouncesToGrams:(double)ounces;

//糖度转密度
- (double)covertPlatoToGravity:(double)plato;

//密度转糖度
- (double)covertGravityToPlato:(double)sg number:(NSInteger)n;

@end
