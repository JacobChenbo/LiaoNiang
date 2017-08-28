//
//  PersonalViewController.m
//  LiaoNiang
//
//  Created by Jacob on 9/20/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "PersonalViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "ChangePasswordViewController.h"

@interface PersonalViewController ()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) CalcButtonView *logoutButton;
@property (nonatomic, strong) CalcButtonView *changeButton;

@end

@implementation PersonalViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle = @"聊  酿";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserName) name:@"refreshUserName" object:nil];
    [self setupViews];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserName" object:nil];
}

- (void)setupViews {
    self.view.backgroundColor = UIColorFromRGB(0xFAFAFA);
    
    UIView *contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView.superview).insets(UIEdgeInsetsMake(64, 0, 44, 0));
    }];
    
    UILabel *userLabel = [UILabel new];
    [contentView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(userLabel.superview);
        make.height.equalTo(@50);
    }];
    userLabel.textColor = CommonMainFontColor;
    userLabel.font = [UIFont systemFontOfSize:16];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.text = @"用户名：";
    self.userNameLabel = userLabel;
    
    CalcButtonView *logoutButton = [[CalcButtonView alloc] initWithTitle:@"注    销"];
    [contentView addSubview:logoutButton];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoutButton.superview).offset(kPadding);
        make.right.equalTo(logoutButton.superview).offset(-kPadding);
        make.top.equalTo(userLabel.mas_bottom).offset(2);
        make.height.equalTo(@40);
    }];
    [logoutButton.button addTarget:self action:@selector(onClickLogout) forControlEvents:UIControlEventTouchUpInside];
    self.logoutButton = logoutButton;
    
    CalcButtonView *changeButton = [[CalcButtonView alloc] initWithTitle:@"修改密码"];
    [contentView addSubview:changeButton];
    [changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(logoutButton);
        make.top.equalTo(logoutButton.mas_bottom).offset(20);
    }];
    [changeButton.button addTarget:self action:@selector(onClickChange) forControlEvents:UIControlEventTouchUpInside];
    self.changeButton = changeButton;
}

- (void)onClickLogout {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)onClickChange {
    ChangePasswordViewController *changePassword = [[ChangePasswordViewController alloc] init];
    changePassword.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changePassword animated:YES];
}

- (void)refreshUserName {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"userName"];
    if (userName.length > 0) {
        self.userNameLabel.text = [NSString stringWithFormat:@"用户名：%@", userName];
        [self.logoutButton.button setTitle:@"注    销" forState:UIControlStateNormal];
        self.changeButton.hidden = NO;
    } else {
        self.userNameLabel.text = [NSString stringWithFormat:@"用户名：未登录"];
        [self.logoutButton.button setTitle:@"登    录" forState:UIControlStateNormal];
        self.changeButton.hidden = YES;
    }
}

@end
