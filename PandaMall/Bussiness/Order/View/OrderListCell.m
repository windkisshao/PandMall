//
//  OrderListCell.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "OrderListCell.h"

@interface OrderListCell()

@property(nonatomic,strong)UILabel *tradeNoLabel;
@property(nonatomic,strong)UILabel *tradeTimeLabel;
@property(nonatomic,strong)UILabel *priceTotalLabel;

@end

@implementation OrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

-(void)setModel:(OrderModel *)model {
    _model = model;
    self.tradeNoLabel.text = [NSString stringWithFormat:@"交易编号：%@",model.tradeNo];
    self.tradeTimeLabel.text = [NSString stringWithFormat:@"交易时间：%@",model.tradeTime];
    self.priceTotalLabel.text = [NSString stringWithFormat:@"总价:￥%@",model.totalPrice];

}

-(void)initView {
    [self.contentView addSubview:self.tradeNoLabel];
    [self.contentView addSubview:self.tradeTimeLabel];
    [self.contentView addSubview:self.priceTotalLabel];
}

-(UILabel *)tradeNoLabel {
    if (!_tradeNoLabel) {
        _tradeNoLabel = [UILabel labelWithTitle:@"" textColor:kBlackColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(18)) frame:CGRectMake(kScale(20), kScale(10), kScale(300), kScale(20))];
    }
    return _tradeNoLabel;
}

-(UILabel *)tradeTimeLabel {
    if (!_tradeTimeLabel) {
        _tradeTimeLabel = [UILabel labelWithTitle:@"" textColor:kGrayColor textAlignment:NSTextAlignmentLeft font:FontWithSize(kScale(14)) frame:CGRectMake(kScale(20), self.tradeNoLabel.jk_bottom + kScale(20), kScale(220), kScale(18))];
    }
    return _tradeTimeLabel;
}

-(UILabel *)priceTotalLabel {
    if (!_priceTotalLabel) {
        _priceTotalLabel = [UILabel labelWithTitle:@"" textColor:kRedColor textAlignment:NSTextAlignmentRight font:FontWithSize(kScale(14)) frame:CGRectMake(0, 0, kScale(120), kScale(18))];
        _priceTotalLabel.jk_right = SCREENWIDTH - kScale(10);
        _priceTotalLabel.jk_bottom = kScale(70);
    }
    return _priceTotalLabel;
}

@end
