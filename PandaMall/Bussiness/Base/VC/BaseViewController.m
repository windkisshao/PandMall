//
//  WEBaseViewController.m
//  Fitness
//
//  Created by liuguangren on 2018/7/31.
//  Copyright © 2018年 Sherlock. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIImageView      *centerImageView;

@end

@implementation BaseViewController

- (UIView *)navView
{
    if (!_navView)
    {
        _navView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, mcNavBarAndStatusBarHeight)];
    }
    return _navView;
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [UILabel labelWithTitle:@"" textColor:[UIColor jk_colorWithHexString:@"#F7F2FC"] textAlignment:NSTextAlignmentCenter font:FontWithSize(18) frame:CGRectZero];
        _titleLab.font = FontWithSize(kScale(21));
    }
    return _titleLab;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.backgroundColor = kClearColor;
        _leftBtn.titleLabel.font = FontWithSize(14);
        [_leftBtn setAdjustsImageWhenHighlighted:NO];
        [_leftBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftBtn;
}

- (UIImageView *)centerImageView
{
    if (!_centerImageView)
    {
        _centerImageView = [[UIImageView alloc] init];
    }
    return _centerImageView;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = kClearColor;
        _rightBtn.titleLabel.font = FontWithSize(14);
        [_rightBtn setAdjustsImageWhenHighlighted:NO];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightBtn;
}

- (void)dealloc
{
    NSString *str = [NSString stringWithFormat:@"%@ dealloc",[NSString stringWithUTF8String:object_getClassName(self)]];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = kBlackColor;
    self.navigationController.navigationBar.hidden = YES;
    self.fd_prefersNavigationBarHidden = YES;

    [self setNavLeftBtnWithImageName:@"back"];

}

- (void)setNavTitle:(NSString *)navTitle
{
    [self.view addSubview:self.navView];
    [self.navView  addSubview:self.titleLab];
    self.titleLab.text = navTitle;
    
    WEAKSELF
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.centerX.equalTo(weakSelf.navView);
        make.bottom.equalTo(weakSelf.navView);
    }];
}

- (void)setNavLeftBtnWithImageName:(NSString *)imageName
{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.leftBtn];
    [self.leftBtn setImage:[NSString safeStr:imageName].length>0?[UIImage imageNamed:imageName]:nil forState:UIControlStateNormal];
    WEAKSELF
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(weakSelf.navView);
        make.width.height.mas_equalTo(44);
    }];
}

- (void)setNavLeftBtnWithText:(NSString *)btnText
{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.leftBtn];
    [self.leftBtn setTitle:btnText forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    WEAKSELF
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.navView);
        make.left.equalTo(weakSelf.navView).offset(12);
        make.height.width.mas_equalTo(44);
    }];
}

- (void)setNavRightBtnWithImageName:(NSString *)imageName
{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.rightBtn];
    [self.rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    WEAKSELF
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(weakSelf.navView);
        make.width.height.mas_equalTo(44);
    }];
}

- (void)setNavRightBtnWithBtnText:(NSString *)btnText
{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.rightBtn];
    [self.rightBtn setTitle:btnText forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    WEAKSELF
    [self.rightBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.navView);
        make.right.equalTo(weakSelf.navView).offset(-12);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(50);
    }];
}

- (void)setNavCenterImageView:(NSString *)imageName
{
    [self.view addSubview:self.navView];
    [self.navView insertSubview:self.centerImageView atIndex:0];
    UIImage *image = [UIImage imageNamed:imageName];
    self.centerImageView.image = image;
    WEAKSELF
    [self.centerImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.navView);
        make.centerX.equalTo(weakSelf.navView);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
