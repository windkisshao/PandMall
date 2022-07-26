//
//  EditInfoVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "EditInfoVC.h"

@interface EditInfoVC ()

@property(nonatomic,strong)UITextField *textField;

@end

@implementation EditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    
    [self setNavRightBtnWithBtnText:@"保存"];
    
    switch (self.editType) {
        case EditTypeNickName:
        {
            [self setNavTitle:@"昵称"];
            self.textField.text = [DataManager shareInstance].userModel.userNickname;
        }
            break;
            
        case EditTypeCellPhone:
        {
            [self setNavTitle:@"手机号"];
            self.textField.text = [DataManager shareInstance].userModel.cellPhone;
        }
            break;
            
        case EditTypeAddressInfo:
        {
            [self setNavTitle:@"收货地址"];
            self.textField.text = [DataManager shareInstance].userModel.addressInfo;
        }
            break;
    }
    
    [self.view addSubview:self.textField];
}

-(UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, kScale(50))];
        _textField.backgroundColor = kWhiteColor;
        _textField.placeholder = @"请输入内容";
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScale(10), kScale(30))];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (void)rightBtnAction
{
    if (self.textField.text.length <= 0 ) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
        return;
    }
    switch (self.editType) {
        case EditTypeNickName:
        {
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [DataManager shareInstance].userModel.userNickname = self.textField.text;
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNickName" object:nil];
        }
            break;
            
        case EditTypeCellPhone:
        {
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [DataManager shareInstance].userModel.cellPhone = self.textField.text;

            }];
        }
            break;
            
        case EditTypeAddressInfo:
        {
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [DataManager shareInstance].userModel.addressInfo = self.textField.text;
            }];
        }
            break;
    }
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
