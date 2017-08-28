//
//  BaseViewController.m
//  LiaoNiang
//
//  Created by Jacob on 9/19/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+SWImage.h"

@interface BaseViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *navView;

@property (nonatomic, strong) UIView *loadingCoverView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBar];
}

- (void)setupNavBar {
    UIView *navView = [UIView new];
    [self.view addSubview:navView];
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(navView.superview);
        make.height.equalTo(@64);
    }];
    navView.backgroundColor = UIColorFromRGB(0x2A2725);
    self.navView = navView;
    
    UILabel *titleLabel = [UILabel new];
    [navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(titleLabel.superview);
        make.height.equalTo(@44);
    }];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel = titleLabel;
    
    UIView *line = [UIView new];
    [navView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(line.superview);
        make.height.equalTo(@1);
    }];
    line.backgroundColor = CommonMainFontColor;
    
    if ([self needBackButton]) {
        [self addBackBarItem];
    }
}

- (BOOL)needBackButton {
    return NO;
}

- (void)onClickBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Bar item

- (void)addBackBarItem {
    UIView *backView = [UIView new];
    [self.navView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(backView.superview);
        make.height.equalTo(@44);
    }];
    
    UIButton *backButton = [UIButton new];
    [backView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backButton.superview).offset(0);
        make.centerY.equalTo(backButton.superview);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [backButton addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"MenubarBack"] forState:UIControlStateNormal];
    [backButton setImage:[[UIImage imageNamed:@"MenubarBack"] imageByApplyingAlpha:0.2] forState:UIControlStateHighlighted];
}

- (void)addLeftBarTitle:(NSString *)title target:(id)target sel:(SEL)sel {
    CGSize size = multilineTextSize(title, [UIFont systemFontOfSize:16], CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    UIButton *leftButton = [UIButton new];
    [self.navView addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(leftButton.superview);
        make.height.equalTo(@44);
        make.width.equalTo(@(size.width + 32));
    }];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightBarTitle:(NSString *)title target:(id)target sel:(SEL)sel {
    CGSize size = multilineTextSize(title, [UIFont systemFontOfSize:16], CGSizeMake(MAXFLOAT, MAXFLOAT));
    
    UIButton *rightButton = [UIButton new];
    [self.navView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(rightButton.superview);
        make.height.equalTo(@44);
        make.width.equalTo(@(size.width + 32));
    }];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Loading ...

- (void)showLoadingViewWithTitle:(NSString *)title {
    UIView *coverView = [UIView new];
    [self.view addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(coverView.superview).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    self.loadingCoverView = coverView;
    
    UIView *loadingView = [UIView new];
    [coverView addSubview:loadingView];
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loadingView.superview);
        make.height.equalTo(@40);
    }];
    loadingView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    loadingView.layer.cornerRadius = 5.0;
    loadingView.layer.masksToBounds = YES;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView addSubview:activityIndicator];
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(activityIndicator.superview);
        make.left.equalTo(activityIndicator.superview).offset(kPadding);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator = activityIndicator;
    
    UILabel *loadingTitle = [UILabel new];
    [loadingView addSubview:loadingTitle];
    [loadingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loadingTitle.superview);
        make.left.equalTo(activityIndicator.mas_right).offset(kPadding);
        make.right.equalTo(loadingTitle.superview).offset(-kPadding);
    }];
    loadingTitle.text = title;
    loadingTitle.textColor = [UIColor blackColor];
    loadingTitle.font = [UIFont systemFontOfSize:14];
    
    [activityIndicator startAnimating];
}

- (void)hideLoadingView {
    [self performSelectorOnMainThread:@selector(removeLoadingView) withObject:nil waitUntilDone:NO];
}

- (void)removeLoadingView {
    [self.activityIndicator stopAnimating];
    [self.loadingCoverView removeFromSuperview];
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    
    self.titleLabel.text = _navTitle;
}

@end
