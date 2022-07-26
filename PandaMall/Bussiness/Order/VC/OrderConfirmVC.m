//
//  OrderConfirmVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "OrderConfirmVC.h"
#import "OrderProdcutItemView.h"
#import "OrderModel.h"

@interface OrderConfirmVC ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *userNickNameLabel;
@property(nonatomic,strong)UILabel *cellPhoneLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *productInfoLabel;

@property(nonatomic,strong)UIView *productsView;

@property(nonatomic,strong)UIView *bottomBgView;
@property(nonatomic,strong)UIButton *cashierBtn;
@property(nonatomic,strong)UILabel *totalLabel;
@property(nonatomic,assign)CGFloat sum;


@end

@implementation OrderConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavTitle:@"确认订单"];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.userNickNameLabel];
    [self.scrollView addSubview:self.cellPhoneLabel];
    [self.scrollView addSubview:self.addressLabel];
    [self.scrollView addSubview:self.productInfoLabel];

    [self.scrollView addSubview:self.productsView];
    [self.scrollView setContentSize:CGSizeMake(SCREENWIDTH, self.productsView.jk_bottom + kScale(20))];

    [self.view addSubview:self.bottomBgView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
    lineView.backgroundColor = kGrayColor;
    [self.bottomBgView addSubview:lineView];
    [self.bottomBgView addSubview:self.cashierBtn];
    [self.bottomBgView addSubview:self.totalLabel];
}

#pragma mark - actions
-(void)payTheBasketAction {
    //保存订单信息，清除购物篮里面被选中的
    OrderModel *orderModel = [[OrderModel alloc] init];
    orderModel.tradeNo = [DateUtil getLocalTimestamp];
    orderModel.tradeTime = [DateUtil getDateDFromNumber:[DateUtil getLocalTimestamp]];
    orderModel.totalPrice = [NSString stringWithFormat:@"%.2lf",_sum];
    orderModel.userNickName = [DataManager shareInstance].userModel.userNickname;
    orderModel.cellPhone = [DataManager shareInstance].userModel.cellPhone;
    orderModel.addressInfo = [DataManager shareInstance].userModel.addressInfo;
    
    for (BasketProductModel *baskModel in self.chosedArray) {
        OrderConfirmModel *confirmModel = [[OrderConfirmModel alloc] init];
        confirmModel.name = baskModel.name;
        confirmModel.price = baskModel.price;
        confirmModel.firstImgName = baskModel.firstImgName;
        confirmModel.count = baskModel.count;
        [orderModel.products addObject:confirmModel];
    }
    
    [[DataManager shareInstance] saveDataModels:@[orderModel]];
    
    [SVProgressHUD showWithStatus:@"提交中..."];
    [CommonUtil doTaskAfter:1.5 withBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderSubmitSuccess" object:nil];
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        [self popVC];
    }];
}

#pragma mark - view getters
-(UIView *)bottomBgView {
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kScale(44) + mcBottomSafeHeight)];
        _bottomBgView.backgroundColor = kWhiteColor;
        _bottomBgView.jk_bottom = SCREEN_HEIGHT;
    }
    return _bottomBgView;
}

-(UIButton *)cashierBtn {
    if (!_cashierBtn) {
        _cashierBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScale(150), kScale(34))];
        [_cashierBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_cashierBtn setBackgroundColor:kOrangeColor];
        [_cashierBtn jk_cornerRadius:kScale(17) strokeSize:0 color:kWhiteColor];
        _cashierBtn.jk_right = SCREENWIDTH - kScale(40);
        _cashierBtn.jk_centerY = kScale(22) + mcBottomSafeHeight / 2.0;
        [_cashierBtn addTarget:self action:@selector(payTheBasketAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cashierBtn;
}

-(UILabel *)totalLabel {
    if (!_totalLabel) {
        self.sum = 0;
        for (BasketProductModel *model in self.chosedArray) {
            self.sum = self.sum + [model.price floatValue] * model.count;
        }
        
        _totalLabel = [UILabel labelWithTitle:@"" textColor:kRedColor textAlignment:NSTextAlignmentRight font:FontWithSize(kScale(14)) frame:CGRectMake(0, 0, kScale(150), kScale(16))];
        _totalLabel.jk_centerY = self.cashierBtn.jk_centerY;
        _totalLabel.jk_right = self.cashierBtn.jk_left - kScale(30);
        _totalLabel.text = [NSString stringWithFormat:@"总计: ￥%.2lf",self.sum];
    }
    return _totalLabel;
}

-(UIView *)productsView {
    if (!_productsView) {
        _productsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.productInfoLabel.jk_bottom + kScale(10), SCREENWIDTH, self.chosedArray.count * kScale(80))];
        for (int i = 0; i < self.chosedArray.count; i++) {
            OrderProdcutItemView *itemView = [[OrderProdcutItemView alloc] initWithFrame:CGRectMake(0, i * kScale(80), SCREENWIDTH, kScale(80))];
            BasketProductModel *model = self.chosedArray[i];
            [itemView setModel:model];
            [_productsView addSubview:itemView];
        }
    }
    return _productsView;
}

-(UILabel *)productInfoLabel {
    if (!_productInfoLabel) {
        _productInfoLabel = [UILabel labelWithTitle:@"商品信息：" textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(20)) frame:CGRectMake(kScale(20), self.addressLabel.jk_bottom + kScale(30), SCREENWIDTH, kScale(22))];
    }
    return _productInfoLabel;
}

-(UILabel *)addressLabel {
    if (!_addressLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"收件人地址：%@",[DataManager shareInstance].userModel.addressInfo];
        _addressLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.cellPhoneLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _addressLabel;
}

-(UILabel *)cellPhoneLabel {
    if (!_cellPhoneLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"收件人电话：%@",[DataManager shareInstance].userModel.cellPhone];
        _cellPhoneLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.userNickNameLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];

    }
    return _cellPhoneLabel;
}

-(UILabel *)userNickNameLabel {
    if (!_userNickNameLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"收件人：%@",[DataManager shareInstance].userModel.userNickname];
        _userNickNameLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _userNickNameLabel;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, ScreenHeight - mcNavBarAndStatusBarHeight - mcBottomSafeHeight - kScale(44))];
        _scrollView.backgroundColor = kWhiteColor;
    }
    return _scrollView;
}

@end
