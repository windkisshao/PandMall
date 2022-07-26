//
//  LoginVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "LoginVC.h"

@interface LoginVC ()

@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UITextField *userNameField;
@property(nonatomic,strong)UILabel *passwordLabel;
@property(nonatomic,strong)UITextField *passwordField;

@property(nonatomic,strong)UIButton *loginBtn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavLeftBtnWithImageName:@"close"];
    [self setNavTitle:@"登录"];
    
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.userNameField];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginBtn];
}

- (void)popVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginAction {
    if (self.userNameField.text.length <=0 ){
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    if (self.passwordField.text.length <=0 ){
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    if (![self.userNameField.text isEqualToString:[DataManager shareInstance].realUserModel.userName] || ![self.passwordField.text isEqualToString:[DataManager shareInstance].realUserModel.password]) {
        [SVProgressHUD showErrorWithStatus:@"用户名或密码有误"];
        return;
    }
    
    //赋值用户模型
    UserModel *userModel = [[UserModel alloc] init];
    userModel.userName = @"test";
    userModel.userNickname = @"test的昵称";
    userModel.password = @"1234";
    userModel.cellPhone = @"13232457853";
    userModel.addressInfo = @"江苏省南京市玄武区环园中路2号";
    
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [DataManager shareInstance].userModel = userModel;
    }];
    [[DataManager shareInstance] saveDataModels:@[userModel]];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNickName" object:nil];

    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    [self popVC];
}

#pragma mark - view getters
-(UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [UILabel labelWithTitle:@"用户名 : " textColor:kWhiteColor textAlignment:NSTextAlignmentCenter font:FontWithSize(kScale(18)) frame:CGRectMake(kScale(20), mcNavBarAndStatusBarHeight + kScale(80), kScale(100), kScale(22))];
    }
    return _userNameLabel;
}

-(UITextField *)userNameField {
    if (!_userNameField) {
        _userNameField = [[UITextField alloc] initWithFrame:CGRectMake(self.userNameLabel.jk_right, self.userNameLabel.jk_top, kScale(220), kScale(32))];
        _userNameField.placeholder = @"  请输入用户名(测试：test)";
        _userNameField.backgroundColor = kWhiteColor;
        _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameField.jk_centerY = self.userNameLabel.jk_centerY;
    }
    return _userNameField;
}

-(UILabel *)passwordLabel {
    if (!_passwordLabel) {
        _passwordLabel = [UILabel labelWithTitle:@"密码 : " textColor:kWhiteColor textAlignment:NSTextAlignmentCenter font:FontWithSize(kScale(18)) frame:CGRectMake(kScale(20), self.userNameLabel.jk_bottom + kScale(50), kScale(100), kScale(22))];
    }
    return _passwordLabel;
}

-(UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(self.passwordLabel.jk_right, self.passwordLabel.jk_top, kScale(220), kScale(32))];
        _passwordField.placeholder = @"  请输入密码(测试：1234)";
        _passwordField.backgroundColor = kWhiteColor;
        _passwordField.secureTextEntry = YES;
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordField.jk_centerY = self.passwordLabel.jk_centerY;
    }
    return _passwordField;
}

-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.passwordField.jk_bottom + kScale(30), kScale(200), kScale(50))];
        [_loginBtn setBackgroundColor:kWhiteColor];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _loginBtn.jk_centerX = SCREENWIDTH / 2.0;
        [_loginBtn jk_cornerRadius:kScale(25) strokeSize:0 color:kWhiteColor];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

@end
