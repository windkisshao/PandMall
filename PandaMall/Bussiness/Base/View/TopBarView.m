//
//  TopBarView.m
//  yuwellCGM
//
//  Created by yuwell on 2021/4/28.
//

#import "TopBarView.h"

@implementation TopBarView

-(instancetype)initWithTitle:(NSString *)title
{
    self = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 96)];
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
    
    
    [self addSubview:self.titleLab];
//    self.titleLab.text  = title;
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.offset(0);
//        make.centerY.offset(StatusBarHeight/2);
//    }];
//    
//    [self addSubview:self.goBackBtn];
//    [self.goBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.titleLab.mas_centerY).offset(0);
//        make.left.offset(17);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
//    [self addSubview:self.rightBtn];
//    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.titleLab.mas_centerY).offset(0);
//        make.right.offset(-20);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
    return self;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:20];
        _titleLab.textColor = ColorWithRGB(51, 51, 51, 1);
    }
    return _titleLab;
}

- (UIButton *)goBackBtn
{
    if (!_goBackBtn) {
        _goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackBtn setImage:[UIImage imageNamed:@"arrows_left"] forState:UIControlStateNormal];
        [_goBackBtn addTarget:self action:@selector(goBackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBackBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.hidden = YES;
    }
    return _rightBtn;
}

- (void)goBackClick
{
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    [nav popViewControllerAnimated:YES];
}
@end
