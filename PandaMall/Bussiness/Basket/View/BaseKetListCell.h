//
//  BaseKetListCell.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickAddOrMinusBlock)(BOOL isAdd, BasketProductModel *model);

typedef void(^ClickChooseBtn)(BOOL isSelected, BasketProductModel *model);

@interface BaseKetListCell : UITableViewCell

@property(nonatomic,strong)BasketProductModel *model;

@property(nonatomic,copy)ClickAddOrMinusBlock clickAddOrMinusBlock;
@property(nonatomic,copy)ClickChooseBtn clickChooseBlock;
@property(nonatomic,assign)BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
