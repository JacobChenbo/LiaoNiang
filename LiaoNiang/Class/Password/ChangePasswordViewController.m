//
//  ChangePasswordViewController.m
//  LiaoNiang
//
//  Created by Jacob on 9/21/16.
//  Copyright © 2016 Jacob. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "FloatLabelTextField.h"
#import "BaseRequest.h"

@interface ChangePasswordViewController ()

@property (nonatomic, strong) FloatLabelTextField *orignalTextField;
@property (nonatomic, strong) FloatLabelTextField *passwordTextField;
@property (nonatomic, strong) FloatLabelTextField *confirmPasswordTextField;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle = @"修改密码";
    [self setupViews];
}

- (BOOL)needBackButton {
    return YES;
}

- (void)setupViews {
    self.view.backgroundColor = UIColorFromRGB(0xFAFAFA);
    
    FloatLabelTextField *origialTextField = [[FloatLabelTextField alloc] initWithTitle:@"原密码"];
    [self.view addSubview:origialTextField];
    [origialTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(origialTextField.superview).offset(kPadding);
        make.right.equalTo(origialTextField.superview).offset(-kPadding);
        make.top.equalTo(origialTextField.superview).offset(64 + 15);
        make.height.equalTo(@60);
    }];
    self.orignalTextField = origialTextField;
    
    FloatLabelTextField *newPasswordTextField = [[FloatLabelTextField alloc] initWithTitle:@"新密码"];
    [self.view addSubview:newPasswordTextField];
    [newPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(origialTextField);
        make.top.equalTo(origialTextField.mas_bottom).offset(0);
    }];
    newPasswordTextField.secureTextEntry = YES;
    self.passwordTextField = newPasswordTextField;
    
    FloatLabelTextField *confirmPasswordTextField = [[FloatLabelTextField alloc] initWithTitle:@"确认密码"];
    [self.view addSubview:confirmPasswordTextField];
    [confirmPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.right.equalTo(origialTextField);
        make.top.equalTo(newPasswordTextField.mas_bottom).offset(0);
    }];
    confirmPasswordTextField.secureTextEntry = YES;
    self.confirmPasswordTextField = confirmPasswordTextField;

    CalcButtonView *loginButton = [[CalcButtonView alloc] initWithTitle:@"修改密码"];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(loginButton.superview);
        make.top.equalTo(confirmPasswordTextField.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [loginButton.button addTarget:self action:@selector(onClickChange) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickChange {
    [self.view endEditing:YES];
    if (self.orignalTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入原密码"];
        return;
    }
    if (self.passwordTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入新密码"];
        return;
    }
    if (self.confirmPasswordTextField.textValue.length == 0) {
        [[JCGlobay sharedInstance] showErrorMessage:@"请输入确认密码"];
        return;
    }
    if (![self.passwordTextField.textValue isEqualToString:self.confirmPasswordTextField.textValue]) {
        [[JCGlobay sharedInstance] showErrorMessage:@"确认密码与新密码不相同"];
        return;
    }
    
    [self changePasswordRequest];
}

- (void)changePasswordRequest {
    [self showLoadingViewWithTitle:@"正在修改密码，请稍等..."];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@"LoginUser"];
    NSString *soapBody = [NSString stringWithFormat:@"<ChangePassword xmlns=\"http://www.beerln.com/\">\n"
                          "<UserId>%@</UserId>\n"
                          "<UserPassword>%@</UserPassword>\n"
                          "<NewPassword>%@</NewPassword>\n"
                          "</ChangePassword>\n", userId, self.orignalTextField.textValue, self.passwordTextField.textValue];
    NSString *soapAction = @"http://www.beerln.com/ChangePassword";
    
    BaseRequest *request = [[BaseRequest alloc] initWithSoapBody:soapBody soapAction:soapAction];
    [request startWithPost];
    @weakify(self);
    [request setSuccessWithNetwork:^(NSDictionary *response) {
        @strongify(self);
        [self hideLoadingView];
        
        NSString *loginInfo = [response objectForKey:@"changeinfo"];
        if ([loginInfo isEqualToString:@"success"]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[JCGlobay sharedInstance] showErrorMessage:@"修改密码失败"];
        }
    }];
    
    [request setFailedWithType:^(NSInteger type) {
        @strongify(self);
        [self hideLoadingView];
        [[JCGlobay sharedInstance] showErrorMessage:@"修改密码失败"];
    }];
}

@end
