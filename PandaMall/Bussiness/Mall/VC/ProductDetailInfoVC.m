//
//  ProductDetailInfoVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "ProductDetailInfoVC.h"

@interface ProductDetailInfoVC ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *bigImgView;
@property(nonatomic,strong)UILabel *detailInfoLabel;
@property(nonatomic,strong)UIView *bottomBgView;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *addToBasketBtn;

@end

@implementation ProductDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavTitle:self.model.name];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.bigImgView];
    [self.scrollView addSubview:self.detailInfoLabel];
    
    [self.scrollView setContentSize:CGSizeMake(SCREENWIDTH, self.detailInfoLabel.jk_bottom + kScale(30))];
    [self.view addSubview:self.bottomBgView];
    [self.bottomBgView addSubview:self.priceLabel];
    [self.bottomBgView addSubview:self.addToBasketBtn];

}

-(void)addToBasketArrayAction {
    [[DataManager shareInstance] addProductModelToBasket:self.model];
    [SVProgressHUD showSuccessWithStatus:@"添加至购物篮成功"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBasketView" object:nil];
}

-(UIButton *)addToBasketBtn {
    if (!_addToBasketBtn) {
        _addToBasketBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.priceLabel.jk_right, 0, (self.bottomBgView.jk_width - kScale(20)) / 2.0, kScale(44))];
        _addToBasketBtn.jk_centerY = self.bottomBgView.jk_height / 2.0;
        [_addToBasketBtn setTitle:@"加入购物篮" forState:UIControlStateNormal];
        [_addToBasketBtn setBackgroundColor:kOrangeColor];
        [_addToBasketBtn jk_cornerRadius:kScale(22) strokeSize:0 color:kWhiteColor];
        [_addToBasketBtn addTarget:self action:@selector(addToBasketArrayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToBasketBtn;
}

-(UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel labelWithTitle:[NSString stringWithFormat:@"￥ %@/kg",self.model.price] textColor:kRedColor textAlignment:NSTextAlignmentCenter font:FontWithSize(kScale(20)) frame:CGRectMake(0, 0, self.bottomBgView.jk_width / 2.0, self.bottomBgView.jk_height)];
    }
    return _priceLabel;
}

-(UIView *)bottomBgView {
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kScale(44) + mcBottomSafeHeight)];
        _bottomBgView.jk_bottom = ScreenHeight;
        _bottomBgView.backgroundColor = kWhiteColor;
    }
    return _bottomBgView;
}

-(UILabel *)detailInfoLabel {
    if (!_detailInfoLabel) {
        CGFloat height = [CommonUtil heightAdjustWidth:SCREENWIDTH - kScale(20) font:FontWithSize(kScale(18)) forString:self.model.detailInfo];
        _detailInfoLabel = [UILabel labelWithTitle:self.model.detailInfo textColor:kWhiteColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(18)) frame:CGRectMake(kScale(10), self.bigImgView.jk_bottom + kScale(10), SCREENWIDTH - kScale(20), height)];
        _detailInfoLabel.numberOfLines = 0;
    }
    return _detailInfoLabel;
}

-(UIImageView *)bigImgView {
    if (!_bigImgView) {
        _bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH)];
        _bigImgView.contentMode = UIViewContentModeScaleAspectFill;
        _bigImgView.clipsToBounds = YES;
        _bigImgView.image = IMG(self.model.firstImgName);
    }
    return _bigImgView;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, ScreenHeight - mcNavBarAndStatusBarHeight - mcBottomSafeHeight - kScale(44))];
    }
    return _scrollView;
}

@end
