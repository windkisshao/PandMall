//
//  TopBarView.h
//  yuwellCGM
//
//  Created by yuwell on 2021/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopBarView : UIView
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIButton *goBackBtn;
@property(nonatomic,strong) UIButton *rightBtn;
-(instancetype)initWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
