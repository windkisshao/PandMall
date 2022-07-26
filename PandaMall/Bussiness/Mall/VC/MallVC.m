//
//  MallVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "MallVC.h"
#import "SearchResultVC.h"
#import "EachCateListVC.h"
#import "SDCycleScrollView.h"
#import "ProductDetailInfoVC.h"

@interface MallVC ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)UITextField *searchTextField;
@property(nonatomic,strong)UIButton *searchBtn;

@property(nonatomic,strong)UILabel *hotGoodsLabel;
@property(nonatomic,strong)SDCycleScrollView *hotGoodsView;

@property(nonatomic,strong)UILabel *cateLabel;
@property(nonatomic,strong)UIView *meatCateBgView;
@property(nonatomic,strong)UIView *seafoodBgView;
@property(nonatomic,strong)UIView *vegetBgView;

@end

@implementation MallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavLeftBtnWithImageName:@""];
    [self setNavTitle:@"商城"];
    
    [self.view addSubview:self.searchTextField];
    [self.view addSubview:self.searchBtn];
    [self.view addSubview:self.hotGoodsLabel];
    [self.view addSubview:self.hotGoodsView];
    [self.view addSubview:self.cateLabel];
    
    [self.view addSubview:self.meatCateBgView];
    [self.view addSubview:self.seafoodBgView];
    [self.view addSubview:self.vegetBgView];

}

#pragma mark - delegates
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ProductModel *model = [DataManager shareInstance].hotGoodsArray[index];
    ProductDetailInfoVC *vc = [[ProductDetailInfoVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - actions
-(void)searchAction {
    if (self.searchTextField.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    SearchResultVC *vc = [[SearchResultVC alloc] init];
    vc.contentStr = self.searchTextField.text;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - view getters
-(UIView *)vegetBgView {
    if (!_vegetBgView) {
        _vegetBgView = [self createCateViewWithTop:self.seafoodBgView.jk_bottom + kScale(10) imageName:@"icon_vege" title:@"果蔬类产品"];
        WEAKSELF
        [_vegetBgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            EachCateListVC *vc = [[EachCateListVC alloc] init];
            vc.type = ProductTypeVege;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];

    }
    return _vegetBgView;
}

-(UIView *)seafoodBgView {
    if (!_seafoodBgView) {
        _seafoodBgView = [self createCateViewWithTop:self.meatCateBgView.jk_bottom + kScale(10) imageName:@"icon_seafood" title:@"海鲜类产品"];
        WEAKSELF
        [_seafoodBgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            EachCateListVC *vc = [[EachCateListVC alloc] init];
            vc.type = ProductTypeSeafood;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _seafoodBgView;
}

-(UIView *)meatCateBgView {
    if (!_meatCateBgView) {
        _meatCateBgView = [self createCateViewWithTop:self.cateLabel.jk_bottom + kScale(10) imageName:@"icon_meat" title:@"鲜肉类产品"];
        WEAKSELF
        [_meatCateBgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            EachCateListVC *vc = [[EachCateListVC alloc] init];
            vc.type = ProductTypeMeat;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _meatCateBgView;
}

-(UIView *)createCateViewWithTop:(CGFloat)top imageName:(NSString *)imageName title:(NSString *)titleStr  {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kScale(10), top, SCREENWIDTH - kScale(20), kScale(80))];
    bgView.backgroundColor = kWhiteColor;
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScale(20), kScale(8), kScale(64), kScale(64))];
    iconImgView.image = IMG(imageName);
    [bgView addSubview:iconImgView];
    
    UILabel *label = [UILabel labelWithTitle:titleStr textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(30)) frame:CGRectMake(iconImgView.jk_right + kScale(30), 0, bgView.jk_width - iconImgView.jk_right - kScale(30), kScale(32))];
    label.jk_centerY = iconImgView.jk_centerY;
    [bgView addSubview:label];

    UILabel *arrowLabel = [UILabel labelWithTitle:@">" textColor:kGrayColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(30)) frame:CGRectMake(0, 0, kScale(20), kScale(30))];
    arrowLabel.jk_right = bgView.jk_width - kScale(30);
    arrowLabel.jk_centerY = iconImgView.jk_centerY;
    [bgView addSubview:arrowLabel];

    
    return  bgView;
}

-(UILabel *)cateLabel {
    if (!_cateLabel) {
        _cateLabel = [UILabel labelWithTitle:@"分类商品" textColor:kWhiteColor textAlignment:UITextAlignmentLeft font:FontWithSize(kScale(20)) frame:CGRectMake(kScale(10), self.hotGoodsView.jk_bottom + kScale(20), SCREENWIDTH - kScale(10), kScale(32))];
    }
    return _cateLabel;
}

-(SDCycleScrollView*)hotGoodsView {
    if (!_hotGoodsView) {
        NSMutableArray *imageArr = [NSMutableArray new];
        for (ProductModel *model in [DataManager shareInstance].hotGoodsArray) {
            [imageArr addObject:model.firstImgName];
        }
        
        _hotGoodsView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(kScale(10), self.hotGoodsLabel.jk_bottom + kScale(10), SCREENWIDTH - kScale(20), kScale(150)) imageNamesGroup:imageArr];
        _hotGoodsView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _hotGoodsView.backgroundColor = kWhiteColor;
        _hotGoodsView.delegate = self;
    }
    return _hotGoodsView;
}

-(UILabel *)hotGoodsLabel {
    if (!_hotGoodsLabel) {
        _hotGoodsLabel = [UILabel labelWithTitle:@"热门商品" textColor:kWhiteColor textAlignment:UITextAlignmentLeft font:FontWithSize(kScale(20)) frame:CGRectMake(kScale(10), self.searchTextField.jk_bottom + kScale(20), SCREENWIDTH - kScale(10), kScale(32))];
    }
    return _hotGoodsLabel;
}

-(UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.searchTextField.jk_right + kScale(10), 0, kScale(44), kScale(44))];
        _searchBtn.jk_centerY = self.searchTextField.jk_centerY;
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

-(UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScale(10), mcNavBarAndStatusBarHeight, SCREENWIDTH - kScale(70), kScale(30))];
        _searchTextField.placeholder = @"  请输入商品名称";
        _searchTextField.backgroundColor = kWhiteColor;
        [_searchTextField jk_cornerRadius:kScale(15) strokeSize:0 color:kWhiteColor];
        
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScale(30), kScale(30))];
        iconImgView.image = IMG(@"icon_mall_search");
        _searchTextField.leftView = iconImgView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchTextField;
}


@end
