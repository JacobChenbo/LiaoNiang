//
//  HomeViewController.m
//  LiaoNiang
//
//  Created by Jacob on 8/23/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeItemView.h"
#import "UIView+JWMasonryConstraint.h"
#import "BaseCalculateViewController.h"
#import "CalculateContentViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"

#import "Calculate6ViewController.h"
#import "Calculate7ViewController.h"
#import "Calculate8ViewController.h"
#import "Calculate9ViewController.h"
#import "Calculate10ViewController.h"

#import "FloatingSelectorView.h"



@interface HomeViewController ()<HomeItemViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle = @"聊  酿";
    [self setupViews];
    
//    [self makeTestButton];
}

- (void)setupViews {
    self.view.backgroundColor = UIColorFromRGB(0x464646);
    
    UIView *topView = [UIView new];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView.superview);
        make.top.equalTo(topView.superview).offset(64);
        make.height.equalTo(@30);
    }];
    topView.backgroundColor = UIColor_RGB(90, 90, 90);
    
    UILabel *label = [UILabel new];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.superview).offset(30);
        make.top.bottom.equalTo(label.superview);
    }];
    label.text = @"计算工具";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    
    UIView *contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview).insets(UIEdgeInsetsMake(64 + 30, 0, 49, 0));
    }];
    
    NSArray *calculateTools = [[JCGlobay sharedInstance].calculateTools mutableCopy];
    HomeItemView *itemView1 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:0]];
    HomeItemView *itemView2 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:1]];
    HomeItemView *itemView3 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:2]];
    HomeItemView *itemView4 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:3]];
    HomeItemView *itemView5 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:4]];
    HomeItemView *itemView6 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:5]];
    HomeItemView *itemView7 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:6]];
    HomeItemView *itemView8 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:7]];
    HomeItemView *itemView9 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:8]];
    HomeItemView *itemView10 = [[HomeItemView alloc] initWithCalculateToolModel:[calculateTools objectAtIndex:9]];
    itemView1.delegate = self;
    itemView2.delegate = self;
    itemView3.delegate = self;
    itemView4.delegate = self;
    itemView5.delegate = self;
    itemView6.delegate = self;
    itemView7.delegate = self;
    itemView8.delegate = self;
    itemView9.delegate = self;
    itemView10.delegate = self;
    
    [contentView makeEqualWidthHeightViews:@[itemView1, itemView2, itemView3, itemView4, itemView5, itemView6, itemView7, itemView8, itemView9, itemView10] numberOfRows:4];
    
    UIView *vLine1 = [UIView new];
    [contentView addSubview:vLine1];
    [vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vLine1.superview).offset(0);
        make.right.equalTo(vLine1.superview).offset(0);
        make.bottom.equalTo(itemView1.mas_bottom);
        make.height.equalTo(@1);
    }];
    vLine1.backgroundColor = UIColorFromRGB(0x2A2725);
    
    UIView *vLine2 = [UIView new];
    [contentView addSubview:vLine2];
    [vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vLine2.superview).offset(0);
        make.right.equalTo(vLine2.superview).offset(0);
        make.bottom.equalTo(itemView4.mas_bottom);
        make.height.equalTo(@1);
    }];
    vLine2.backgroundColor = UIColorFromRGB(0x2A2725);
    
    UIView *vLine3 = [UIView new];
    [contentView addSubview:vLine3];
    [vLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vLine3.superview).offset(0);
        make.right.equalTo(vLine3.superview).offset(0);
        make.bottom.equalTo(itemView7.mas_bottom);
        make.height.equalTo(@1);
    }];
    vLine3.backgroundColor = UIColorFromRGB(0x2A2725);
    
    UIView *hLine1 = [UIView new];
    [contentView addSubview:hLine1];
    [hLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(itemView1.mas_right);
        make.top.equalTo(hLine1.superview).offset(0);
        make.bottom.equalTo(hLine1.superview).offset(0);
        make.width.equalTo(@1);
    }];
    hLine1.backgroundColor = UIColorFromRGB(0x2A2725);
    
    UIView *hLine2 = [UIView new];
    [contentView addSubview:hLine2];
    [hLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(itemView2.mas_right);
        make.top.equalTo(hLine2.superview).offset(0);
        make.bottom.equalTo(itemView8.mas_bottom);
        make.width.equalTo(@1);
    }];
    hLine2.backgroundColor = UIColorFromRGB(0x2A2725);
}

- (void)buttonActionWithTag:(NSInteger)tag {
    NSLog(@"%ld", (long)tag);
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([[userDefaults objectForKey:@"userName"] length] > 0) {
        CalculateContentViewController *vc = [[CalculateContentViewController alloc] initWithIndex:tag];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
//    } else {
//        // 登录
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
//        
//        [self presentViewController:navController animated:YES completion:nil];
//    }
}

//传送门
- (void)makeTestButton{
    CGFloat Y = 100;
    NSMutableArray <UIView *> *buttons = [NSMutableArray new];
    @weakify(self);
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [buttons addObject:button];
        [button setTitle:@"酒精度数-比重" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, Y, 150, 30);
        button.backgroundColor = [UIColor randomColor];
        [self.view addSubview:button];
        [button bk_addEventHandler:^(id sender) {
            @strongify(self);
            Calculate6ViewController *vc = [Calculate6ViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        Y += 30;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [buttons addObject:button];
        [button setTitle:@"色度计算" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, Y, 150, 30);
        button.backgroundColor = [UIColor randomColor];
        [self.view addSubview:button];
        [button bk_addEventHandler:^(id sender) {
            @strongify(self);
            Calculate7ViewController *vc = [Calculate7ViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        Y += 30;
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [buttons addObject:button];
        [button setTitle:@"碳化体积" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, Y, 150, 30);
        button.backgroundColor = [UIColor randomColor];
        [self.view addSubview:button];
        [button bk_addEventHandler:^(id sender) {
            @strongify(self);
            Calculate10ViewController *vc = [Calculate10ViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        Y += 30;
    }
    
    {
        //屏幕上部
        FloatingSelectorView *view = [[FloatingSelectorView alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
        view.titles = @[@"标题0", @"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6", @"标题7"];
        [view setSelectionDidChangeBlock:^(NSString *title, NSInteger index) {
            NSLog(@"选择了%@ %@",title,@(index));;
        }];
        
        [self.view addSubview:view];
        [buttons addObject:view];
    }
    {
        //很多条目
        FloatingSelectorView *view = [[FloatingSelectorView alloc] initWithFrame:CGRectMake(100, 200, 200, 40)];
        
        NSMutableArray *titles = [NSMutableArray new];
        for (NSInteger index = 0; index < 100; index++) {
            [titles addObject:[NSString stringWithFormat:@"标题%@",@(index)]];
        }
        
        view.titles = titles;
        [view setSelectionDidChangeBlock:^(NSString *title, NSInteger index) {
            NSLog(@"选择了%@ %@",title,@(index));;
        }];
        
        [self.view addSubview:view];
        [buttons addObject:view];
    }
    {
        //屏幕下部
        FloatingSelectorView *view = [[FloatingSelectorView alloc] initWithFrame:CGRectMake(100, kScreenHeight - 100, 200, 40)];
        view.titles = @[@"标题0", @"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6", @"标题7"];
        [view setSelectionDidChangeBlock:^(NSString *title, NSInteger index) {
            NSLog(@"选择了%@ %@",title,@(index));;
        }];
        
        [self.view addSubview:view];
        [buttons addObject:view];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [buttons enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.view bringSubviewToFront:obj];
            
        }];
    });
}
@end
