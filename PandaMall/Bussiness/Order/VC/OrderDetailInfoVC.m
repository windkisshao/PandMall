//
//  OrderDetailInfoVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "OrderDetailInfoVC.h"
#import "OrderDetailItemView.h"

@interface OrderDetailInfoVC ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *userNickNameLabel;
@property(nonatomic,strong)UILabel *cellPhoneLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UILabel *tradeNoLabel;
@property(nonatomic,strong)UILabel *tradeTimeLabel;
@property(nonatomic,strong)UILabel *totalPriceLabel;

@property(nonatomic,strong)UILabel *productInfoLabel;
@property(nonatomic,strong)UIView *productsView;

@end

@implementation OrderDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavTitle:@"订单详情"];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.userNickNameLabel];
    [self.scrollView addSubview:self.cellPhoneLabel];
    [self.scrollView addSubview:self.addressLabel];
    [self.scrollView addSubview:self.tradeNoLabel];
    [self.scrollView addSubview:self.tradeTimeLabel];
    [self.scrollView addSubview:self.totalPriceLabel];

    [self.scrollView addSubview:self.productInfoLabel];
    
    [self.scrollView addSubview:self.productsView];
    [self.scrollView setContentSize:CGSizeMake(SCREENWIDTH, self.productsView.jk_bottom + kScale(20))];
}

-(UIView *)productsView {
    if (!_productsView) {
        _productsView = [[UIView alloc] initWithFrame:CGRectMake(0, self.productInfoLabel.jk_bottom + kScale(10), SCREENWIDTH, self.orderModel.products.count * kScale(80))];
        for (int i = 0; i < self.orderModel.products.count; i++) {
            OrderDetailItemView *itemView = [[OrderDetailItemView alloc] initWithFrame:CGRectMake(0, i * kScale(80), SCREENWIDTH, kScale(80))];
            OrderConfirmModel *model = self.orderModel.products[i];
            [itemView setModel:model];
            [_productsView addSubview:itemView];
        }
    }
    return _productsView;
}


-(UILabel *)productInfoLabel {
    if (!_productInfoLabel) {
        _productInfoLabel = [UILabel labelWithTitle:@"商品信息：" textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(20)) frame:CGRectMake(kScale(20), self.totalPriceLabel.jk_bottom + kScale(30), SCREENWIDTH, kScale(22))];
    }
    return _productInfoLabel;
}

-(UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"总价：￥%@",self.orderModel.totalPrice];
        _totalPriceLabel = [UILabel labelWithTitle:nameStr textColor:kRedColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.tradeTimeLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _totalPriceLabel;
}

-(UILabel *)tradeTimeLabel {
    if (!_tradeTimeLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"交易时间：%@",self.orderModel.tradeTime];
        _tradeTimeLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.tradeNoLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _tradeTimeLabel;
}

-(UILabel *)tradeNoLabel {
    if (!_tradeNoLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"交易编号：%@",self.orderModel.tradeNo];
        _tradeNoLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.addressLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _tradeNoLabel;
}

-(UILabel *)addressLabel {
    if (!_addressLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"收件人地址：%@",self.orderModel.addressInfo];
        _addressLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.cellPhoneLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _addressLabel;
}

-(UILabel *)cellPhoneLabel {
    if (!_cellPhoneLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"收件人电话：%@",self.orderModel.cellPhone];
        _cellPhoneLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), self.userNickNameLabel.jk_bottom + kScale(20), SCREENWIDTH, kScale(18))];

    }
    return _cellPhoneLabel;
}

-(UILabel *)userNickNameLabel {
    if (!_userNickNameLabel) {
        NSString *nameStr = [NSString stringWithFormat:@"收件人：%@",self.orderModel.userNickName];
        _userNickNameLabel = [UILabel labelWithTitle:nameStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(16)) frame:CGRectMake(kScale(20), kScale(20), SCREENWIDTH, kScale(18))];
    }
    return _userNickNameLabel;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, ScreenHeight - mcNavBarAndStatusBarHeight - mcBottomSafeHeight)];
        _scrollView.backgroundColor = kWhiteColor;
    }
    return _scrollView;
}


@end
