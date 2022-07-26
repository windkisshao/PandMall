//
//  ProductListCell.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "ProductListCell.h"

@interface ProductListCell()

@property(nonatomic,strong)UIImageView *iconImgView;
@property(nonatomic,strong)UILabel *productNameLabel;
@property(nonatomic,strong)UILabel *priceLabel;

@end

@implementation ProductListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

-(void)setModel:(ProductModel *)model {
    _model = model;
    self.iconImgView.image = IMG(model.firstImgName);
    self.productNameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥ %@/kg",model.price];
}

-(void)initView {
    [self addSubview:self.iconImgView];
    [self addSubview:self.productNameLabel];
    [self addSubview:self.priceLabel];
}

-(UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScale(20), kScale(8), kScale(64), kScale(64))];
    }
    return  _iconImgView;
}

-(UILabel *)productNameLabel {
    if (!_productNameLabel) {
        _productNameLabel = [UILabel labelWithTitle:@"" textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(20)) frame:CGRectMake(self.iconImgView.jk_right + kScale(30), kScale(10), kScale(100), kScale(22))];
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

@end
