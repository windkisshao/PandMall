//
//  MineVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "MineVC.h"
#import "LoginVC.h"
#import "EditInfoVC.h"
#import "OrderListVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *topBgView;
@property(nonatomic,strong)UIImageView *headerImgView;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UIButton *editBtn;

@property(nonatomic,strong)UILabel *cellPhoneLabel;
@property(nonatomic,strong)UILabel *myorderLabel;
@property(nonatomic,strong)UILabel *addressInfoLabel;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavLeftBtnWithImageName:@""];
    [self setNavTitle:@"我的"];
    
    self.dataArray = @[@"我的订单",@"手机号",@"收货地址"];
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNickName) name:@"refreshNickName" object:nil];

}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - actions
-(void)refreshNickName {
    NSString *nameStr = @"游客";
    if ([DataManager shareInstance].userModel) {
        nameStr = [DataManager shareInstance].userModel.userNickname;
    }
    _nickNameLabel.text = nameStr;
}

-(void)editNickNameAction {
    if (![DataManager shareInstance].userModel) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        [self popLoginVCAction];
    } else {
        EditInfoVC *vc = [[EditInfoVC alloc] init];
        vc.editType = EditTypeNickName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)popLoginVCAction {
    LoginVC *vc = [[LoginVC alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - view getters
-(UIImageView *)headerImgView {
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScale(20), 0, kScale(64), kScale(64))];
        _headerImgView.image = IMG(@"icon_header");
        _headerImgView.jk_centerY = self.topBgView.jk_height / 2.0;
    }
    return _headerImgView;
}

-(UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        NSString *nameStr = @"游客";
        if ([DataManager shareInstance].userModel) {
            nameStr = [DataManager shareInstance].userModel.userNickname;
        }
        _nickNameLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(18)) frame:CGRectMake(self.headerImgView.jk_right + kScale(20), 0, kScale(200), kScale(20))];
        _nickNameLabel.jk_centerY = self.headerImgView.jk_centerY;
    }
    return _nickNameLabel;
}

-(UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScale(44), kScale(44))];
        _editBtn.jk_right = SCREENWIDTH - kScale(20);
        _editBtn.jk_centerY = self.nickNameLabel.jk_centerY;
        [_editBtn setImage:IMG(@"icon_edit") forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editNickNameAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

-(UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, kScale(100))];
        _topBgView.backgroundColor = kWhiteColor;
        
        [_topBgView addSubview:self.headerImgView];
        [_topBgView addSubview:self.nickNameLabel];
        [_topBgView addSubview:self.editBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
        lineView.backgroundColor = kGrayColor;
        lineView.jk_bottom = _topBgView.jk_height;
        [_topBgView addSubview:lineView];
    }
    return _topBgView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScale(80);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: //订单
        {
            if (![DataManager shareInstance].userModel) {
                [SVProgressHUD showErrorWithStatus:@"请先登录"];
                [self popLoginVCAction];
            } else {
                OrderListVC *listVC = [[OrderListVC alloc] init];
                [self.navigationController pushViewController:listVC animated:YES];
            }
        }
            break;
            
        case 1: //手机号
        {
            if (![DataManager shareInstance].userModel) {
                [SVProgressHUD showErrorWithStatus:@"请先登录"];
                [self popLoginVCAction];
            } else {
                EditInfoVC *vc = [[EditInfoVC alloc] init];
                vc.editType = EditTypeCellPhone;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
            
        case 2: //收货地址
        {
            if (![DataManager shareInstance].userModel) {
                [SVProgressHUD showErrorWithStatus:@"请先登录"];
                [self popLoginVCAction];
            } else {
                EditInfoVC *vc = [[EditInfoVC alloc] init];
                vc.editType = EditTypeAddressInfo;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
    }
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, ScreenHeight - mcNavBarAndStatusBarHeight - mcTabBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kClearColor;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.topBgView;
    }
    return _tableView;
}

@end
