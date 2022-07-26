//
//  BaseKetListCell.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "BaseKetListCell.h"

@interface BaseKetListCell()

@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *productNameLabel;
@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UIButton *decreaseBtn;
@property(nonatomic,strong)UILabel *numsLabel;
@property(nonatomic,strong)UIButton *addBtn;

@end

@implementation BaseKetListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];

    }
    return self;
}

-(void)initView {
    [self.contentView addSubview:self.chooseBtn];
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.productNameLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.contentView addSubview:self.decreaseBtn];
    [self.contentView addSubview:self.numsLabel];
    [self.contentView addSubview:self.addBtn];

}

#pragma mark - actions
-(void)chooseBtnClickAction:(UIButton *)btn {
    BOOL isSelected = !btn.selected;
    if (isSelected) {
        [self.chooseBtn setSelected:YES];
        if (self.clickChooseBlock) {
            self.clickChooseBlock(YES, _model);
        }
    } else {
        [self.chooseBtn setSelected:NO];
        if (self.clickChooseBlock) {
            self.clickChooseBlock(NO, _model);
        }
    }
}

-(void)addNumAction {
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        _model.count += 1;
    }];
    self.numsLabel.text = [NSString stringWithFormat:@"%@",@(_model.count)];
    if (self.clickAddOrMinusBlock) {
        self.clickAddOrMinusBlock(YES,_model);
    }
}

-(void)minusNumAction {
    if (_model.count == 1) {
        [SVProgressHUD showErrorWithStatus:@"已经是最小值了"];
        return;
    }
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        _model.count -= 1;
    }];
    self.numsLabel.text = [NSString stringWithFormat:@"%@",@(_model.count)];
    if (self.clickAddOrMinusBlock) {
        self.clickAddOrMinusBlock(NO,_model);
    }
}

-(void)setModel:(BasketProductModel *)model {
    _model = model;
    self.iconImgView.image = IMG(model.firstImgName);
    self.productNameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@/kg",model.price];
    self.numsLabel.text = [NSString stringWithFormat:@"%@",@(model.count)];
}

-(void)setIsSelected:(BOOL)isSelected {
    [self.chooseBtn setSelected:isSelected];
}


#pragma mark - view getters
-(UILabel *)numsLabel {
    if (!_numsLabel) {
        _numsLabel = [UILabel labelWithTitle:@"" textColor:kBlackColor textAlignment:NSTextAlignmentCenter font:FontWithSize(kScale(16)) frame:CGRectMake(0, 0, kScale(40), kScale(18))];
        _numsLabel.jk_right = self.addBtn.jk_left;
        _numsLabel.jk_centerY = self.addBtn.jk_centerY;
    }
    return _numsLabel;
}

-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScale(32), kScale(32))];
        [_addBtn setImage:IMG(@"icon_btn_add") forState:UIControlStateNormal];
        _addBtn.jk_right = SCREENWIDTH - kScale(10);
        _addBtn.jk_centerY = kScale(40);
        [_addBtn addTarget:self action:@selector(addNumAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addBtn;
}

-(UIButton *)decreaseBtn {
    if (!_decreaseBtn) {
        _decreaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.addBtn.jk_top, kScale(32), kScale(32))];
        [_decreaseBtn setImage:IMG(@"icon_btn_minus") forState:UIControlStateNormal];
        _decreaseBtn.jk_right = self.numsLabel.jk_left;
        [_decreaseBtn addTarget:self action:@selector(minusNumAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _decreaseBtn;
}

-(UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.chooseBtn.jk_right + kScale(20), kScale(8), kScale(64), kScale(64))];
    }
    return  _iconImgView;
}

-(UILabel *)productNameLabel {
    if (!_productNameLabel) {
        _productNameLabel = [UILabel labelWithTitle:@"" textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(20)) frame:CGRectMake(self.iconImgView.jk_right + kScale(10), kScale(10), kScale(100), kScale(22))];
        _productNameLabel.jk_top = self.iconImgView.jk_top;
    }
    return _productNameLabel;
}

-(UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel labelWithTitle:@"" textColor:kRedColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(18)) frame:CGRectMake(0, 0, kScale(100), kScale(20))];
        _priceLabel.jk_left = self.productNameLabel.jk_left;
        _priceLabel.jk_bottom = self.iconImgView.jk_bottom;
    }
    return _priceLabel;
}

-(UIButton *)chooseBtn {
    if (!_chooseBtn) {
        _chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScale(10), kScale(24), kScale(32), kScale(32))];
        [_chooseBtn setImage:IMG(@"icon_btn_choosed") forState:UIControlStateSelected];
        [_chooseBtn setImage:IMG(@"icon_btn_notchoosed") forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}

@end
