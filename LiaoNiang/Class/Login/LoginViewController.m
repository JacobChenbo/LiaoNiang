//
//  LoginViewController.m
//  LiaoNiang
//
//  Created by Jacob on 9/20/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "LoginViewController.h"
#import "FloatLabelTextField.h"
#import "BaseRequest.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<NSXMLParserDelegate>

@property (nonatomic, strong) FloatLabelTextField *nameTextField;
@property (nonatomic, strong) FloatLabelTextField *passwordTextField;

@end

@implementation LoginViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle = @"登录";
   
    [self addLeftBarTitle:@"关闭" target:self sel:@selector(onClickClose)];
//    [self addRightBarTitle:@"注册" target:self sel:@selector(onClickRegist)];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"" forKey:@"userName"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserName" object:nil];
}

- (void)setupViews {
    self.view.backgroundColor = UIColorFromRGB(0xFAFAFA);
    
    FloatLabelTextField *nameTextField = [[FloatLabelTextField alloc] initWithTitle:@"账号"];
    [self.view addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameTextField.superview).offset(kPadding);
        make.right.equalTo(nameTextField.superview).offset(-kPadding);
        make.top.equalTo(nameTextField.superview).offset(64 + 15);
        make.height.equalTo(@60);
    }];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    nameTextField.textValue = [userDefaults objectForKey:@"LoginUser"];
    self.nameTextField = nameTextField;
    
    FloatLabelTextField *passwordTextField = [[FloatLabelTextField alloc] initWithTitle:@"密码"];
    [self.view addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(nameTextField);
        make.top.equalTo(nameTextField.mas_bottom).offset(0);
    }];
    passwordTextField.secureTextEntry = YES;
//    passwordTextField.textValue = @"123456";
    self.passwordTextField = passwordTextField;
    
    CalcButtonView *loginButton = [[CalcButtonView alloc] initWithTitle:@"登 录"];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(loginButton.superview);
        make.top.equalTo(passwordTextField.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [loginButton.button addTarget:self action:@selector(onClickLogin) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)onClickLogin {
    [self.view endEditing:YES];
    if (self.nameTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"账号名不能为空"];
        return;
    }
    if (self.passwordTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"密码不能为空"];
        return;
    }
    
    [self loginRequest];
}

- (void)loginRequest {
    [self showLoadingViewWithTitle:@"正在登录，请稍等..."];
    NSString *soapBody = [NSString stringWithFormat:@"<Login xmlns=\"http://www.beerln.com/\">\n"
                          "<UserId>%@</UserId>\n"
                          "<UserPassword>%@</UserPassword>\n"
                          "</Login>\n", self.nameTextField.textValue, self.passwordTextField.textValue];
    NSString *soapAction = @"http://www.beerln.com/Login";
    
    BaseRequest *request = [[BaseRequest alloc] initWithSoapBody:soapBody soapAction:soapAction];
    [request startWithPost];
    @weakify(self);
    [request setSuccessWithNetwork:^(NSDictionary *response) {
        @strongify(self);
        [self hideLoadingView];
        
        NSString *loginInfo = [response objectForKey:@"logininfo"];
        if ([loginInfo isEqualToString:@"success"]) {
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:self.nameTextField.textValue forKey:@"LoginUser"];
            [userDefaults setValue:[response objectForKey:@"username"] forKey:@"userName"];
//            [userDefaults setValue:[response objectForKey:@"md5"] forKey:@"md5"];
            [userDefaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [[JCGlobay sharedInstance] showErrorMessage:@"账号或密码错误，请重试"];
        }
    }];
    
    [request setFailedWithType:^(NSInteger type) {
        @strongify(self);
        [self hideLoadingView];
        [[JCGlobay sharedInstance] showErrorMessage:@"登录失败，请稍后重试"];
    }];
}

- (void)onClickClose {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onClickRegist {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
