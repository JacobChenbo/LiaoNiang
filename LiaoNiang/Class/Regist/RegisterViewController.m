//
//  RegisterViewController.m
//  LiaoNiang
//
//  Created by Jacob on 10/11/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "RegisterViewController.h"
#import "FloatLabelTextField.h"
#import "BaseRequest.h"

@interface RegisterViewController ()

@property (nonatomic, strong) FloatLabelTextField *userNameTextField;
@property (nonatomic, strong) FloatLabelTextField *userIDTextField;
@property (nonatomic, strong) FloatLabelTextField *passwordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"注册";
    [self setupViews];
}

- (BOOL)needBackButton {
    return YES;
}

- (void)setupViews {
    self.view.backgroundColor = UIColorFromRGB(0xFAFAFA);
    
    FloatLabelTextField *userNameTextField = [[FloatLabelTextField alloc] initWithTitle:@"用户名"];
    [self.view addSubview:userNameTextField];
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameTextField.superview).offset(kPadding);
        make.right.equalTo(userNameTextField.superview).offset(-kPadding);
        make.top.equalTo(userNameTextField.superview).offset(64 + 15);
        make.height.equalTo(@60);
    }];
    self.userNameTextField = userNameTextField;
    
    FloatLabelTextField *userIDTextField = [[FloatLabelTextField alloc] initWithTitle:@"账号"];
    [self.view addSubview:userIDTextField];
    [userIDTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(userNameTextField);
        make.top.equalTo(userNameTextField.mas_bottom).offset(0);
    }];
    self.userIDTextField = userIDTextField;
    
    FloatLabelTextField *passwordTextField = [[FloatLabelTextField alloc] initWithTitle:@"密码"];
    [self.view addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(userIDTextField);
        make.top.equalTo(userIDTextField.mas_bottom).offset(0);
    }];
    passwordTextField.secureTextEntry = YES;
    self.passwordTextField = passwordTextField;
    
    CalcButtonView *registButton = [[CalcButtonView alloc] initWithTitle:@"注册"];
    [self.view addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(registButton.superview);
        make.top.equalTo(passwordTextField.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [registButton.button addTarget:self action:@selector(onClickRegist) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickRegist {
    [self.view endEditing:YES];
    if (self.userNameTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入用户名"];
        return;
    }
    if (self.userIDTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入账号"];
        return;
    }
    if (self.passwordTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入密码"];
        return;
    }
    
    [self registerRequest];
}

- (void)registerRequest {
    [self showLoadingViewWithTitle:@"正在注册，请稍等..."];
    NSString *soapBody = [NSString stringWithFormat:@"<Register xmlns=\"http://www.beerln.com/\">\n"
                          "<UserId>%@</UserId>\n"
                          "<UserPassword>%@</UserPassword>\n"
                          "<UserName>%@</UserName>\n"
                          "</Register>\n", self.userIDTextField.textValue, self.passwordTextField.textValue, self.userNameTextField.textValue];
    NSString *soapAction = @"http://www.beerln.com/Register";
    
    BaseRequest *request = [[BaseRequest alloc] initWithSoapBody:soapBody soapAction:soapAction];
    [request startWithPost];
    @weakify(self);
    [request setSuccessWithNetwork:^(NSDictionary *response) {
        @strongify(self);
        [self hideLoadingView];
        
        NSString *loginInfo = [response objectForKey:@"registerinfo"];
        if ([loginInfo isEqualToString:@"success"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[JCGlobay sharedInstance] showErrorMessage:@"注册失败"];
        }
    }];
    
    [request setFailedWithType:^(NSInteger type) {
        @strongify(self);
        [self hideLoadingView];
        [[JCGlobay sharedInstance] showErrorMessage:@"注册网络失败"];
    }];
}

@end
