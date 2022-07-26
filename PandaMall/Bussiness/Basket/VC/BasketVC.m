//
//  BasketVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "BasketVC.h"
#import "BaseKetListCell.h"
#import "LoginVC.h"
#import "OrderConfirmVC.h"

@interface BasketVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *choosedArray;

@property(nonatomic,strong)UIView *bottomBgView;
@property(nonatomic,strong)UIButton *allCheckBtn;
@property(nonatomic,strong)UIButton *cashierBtn;
@property(nonatomic,strong)UILabel *totalLabel;

@property(nonatomic,assign)CGFloat sum;

@end

@implementation BasketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavLeftBtnWithImageName:@""];
    [self setNavTitle:@"购物篮"];
    
    self.dataArray = [[[DataManager shareInstance] findAllbasketObjects] mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBasketView) name:@"updateBasketView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderSubmitSuccess) name:@"OrderSubmitSuccess" object:nil];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBgView];
    
    [self.bottomBgView addSubview:self.allCheckBtn];
    [self.bottomBgView addSubview:self.cashierBtn];
    [self.bottomBgView addSubview:self.totalLabel];
}

//刷新购物篮界面
-(void)orderSubmitSuccess {
    //删除所有的chooseArray
    for (BasketProductModel *model in self.choosedArray) {
        [[DataManager shareInstance] deleteDateModel:model];
    }
    [self.choosedArray removeAllObjects];
    [CommonUtil doTaskInMainQueue:^{
        self.dataArray = [[[DataManager shareInstance] findAllbasketObjects] mutableCopy];
        [self.tableView reloadData];
        [self refreshBottomView];
    }];
}

//结算购物篮
-(void)payTheBasketAction {
    if (self.choosedArray.count <= 0) {
        [SVProgressHUD showErrorWithStatus:@"您还未选中任何商品"];
        return;
    }
    
    if ([DataManager shareInstance].userModel) {
        OrderConfirmVC *vc = [[OrderConfirmVC alloc] init];
        vc.chosedArray = self.choosedArray;
        [self.navigationController pushViewController:vc animated:YES];

    } else {
        //弹出登录界面
        LoginVC *vc = [[LoginVC alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}

//更新购物篮页面
-(void)updateBasketView {
    [CommonUtil doTaskInMainQueue:^{
        self.dataArray = [[[DataManager shareInstance] findAllbasketObjects] mutableCopy];
        [self.tableView reloadData];
    }];
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshBottomView {
    if ((self.dataArray.count > 0) && (self.dataArray.count == self.choosedArray.count)) {
        [self.allCheckBtn setSelected:YES];
    } else {
        [self.allCheckBtn setSelected:NO];
    }
    
    self.sum = 0;
    for (BasketProductModel *model in self.choosedArray) {
        self.sum = self.sum + [model.price floatValue] * model.count;
    }
    self.totalLabel.text = [NSString stringWithFormat:@"总计: ￥%.2lf",self.sum];
}

-(void)chooseAllBtnClickAction:(UIButton *)btn {
    BOOL isSelected = !btn.selected;
    if (isSelected) {
        //将所有的值加入
        [self.allCheckBtn setSelected:YES];
        [self.choosedArray removeAllObjects];
        [self.choosedArray addObjectsFromArray:self.dataArray];
        [self.tableView reloadData];
        
        [self refreshBottomView];
        
    } else {
        //移除所有的值
        [self.allCheckBtn setSelected:NO];
        [self.choosedArray removeAllObjects];
        [self.tableView reloadData];

        [self refreshBottomView];

    }
}

-(UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel labelWithTitle:@"总价: ￥0.00" textColor:kRedColor textAlignment:NSTextAlignmentRight font:FontWithSize(kScale(14)) frame:CGRectMake(0, 0, kScale(150), kScale(16))];
        _totalLabel.jk_centerY = self.cashierBtn.jk_centerY;
        _totalLabel.jk_right = self.cashierBtn.jk_left - kScale(10);
    }
    return _totalLabel;
}

-(UIButton *)cashierBtn {
    if (!_cashierBtn) {
        _cashierBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScale(150), kScale(34))];
        [_cashierBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_cashierBtn setBackgroundColor:kOrangeColor];
        [_cashierBtn jk_cornerRadius:kScale(17) strokeSize:0 color:kWhiteColor];
        _cashierBtn.jk_right = SCREENWIDTH - kScale(10);
        _cashierBtn.jk_centerY = kScale(22);
        [_cashierBtn addTarget:self action:@selector(payTheBasketAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cashierBtn;
}

-(UIButton *)allCheckBtn {
    if (!_allCheckBtn) {
        _allCheckBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScale(10), kScale(6), kScale(32), kScale(32))];
        [_allCheckBtn setImage:IMG(@"icon_btn_choosed") forState:UIControlStateSelected];
        [_allCheckBtn setImage:IMG(@"icon_btn_notchoosed") forState:UIControlStateNormal];
        [_allCheckBtn addTarget:self action:@selector(chooseAllBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allCheckBtn;
}

-(UIView *)bottomBgView {
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kScale(44))];
        _bottomBgView.backgroundColor = kWhiteColor;
        _bottomBgView.jk_bottom = SCREEN_HEIGHT - mcTabBarHeight;
    }
    return _bottomBgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseKetListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[BaseKetListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    BasketProductModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];
    if ([self.choosedArray containsObject:model]) {
        [cell setIsSelected:YES];
    } else {
        [cell setIsSelected:NO];
    }
    
    WEAKSELF
    cell.clickChooseBlock = ^(BOOL isSelected, BasketProductModel * _Nonnull model) {
        if (!isSelected) {
            BasketProductModel *tempModel = nil;
            for (int i = 0; i < weakSelf.choosedArray.count; i++) {
                BasketProductModel *modelTemp = weakSelf.choosedArray[i];
                if ([modelTemp.name isEqualToString:model.name]) {
                    tempModel = modelTemp;
                    break;;
                }
            }
            if (tempModel) {
                [weakSelf.choosedArray removeObject:tempModel];
            }
        } else {
            [weakSelf.choosedArray addObject:model];
        }
        
        [weakSelf refreshBottomView];
    };
    
    cell.clickAddOrMinusBlock = ^(BOOL isAdd, BasketProductModel * _Nonnull model) {
        [weakSelf refreshBottomView];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScale(80);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BasketProductModel *model = self.dataArray[indexPath.row];
        if ([self.choosedArray containsObject:model]) {
            [self.choosedArray removeObject:model];
        }
        [self.dataArray removeObject:model];
        [[DataManager shareInstance] deleteDateModel:model];
        
        [self.tableView reloadData];
        [self refreshBottomView];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, ScreenHeight - mcNavBarAndStatusBarHeight - mcTabBarHeight - kScale(50)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kClearColor;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(NSMutableArray *)choosedArray {
    if (!_choosedArray) {
        _choosedArray = [NSMutableArray new];
    }
    return _choosedArray;
}

@end
