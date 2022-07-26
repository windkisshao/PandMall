//
//  WEBaseViewController.h
//  Fitness
//
//  Created by liuguangren on 2018/7/31.
//  Copyright © 2018年 Sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)UIView       *navView;
@property (nonatomic,strong)UILabel      *titleLab;
@property (nonatomic,strong)UIButton     *rightBtn;
@property (nonatomic,strong)UIButton     *leftBtn;
@property (nonatomic,assign)BOOL         disablePopGesture;

- (void)setNavTitle:(NSString *)navTitle;

- (void)setNavLeftBtnWithImageName:(NSString *)imageName;

- (void)setNavLeftBtnWithText:(NSString *)btnText;

- (void)setNavRightBtnWithImageName:(NSString *)imageName;

- (void)setNavRightBtnWithBtnText:(NSString *)btnText;

- (void)setNavCenterImageView:(NSString *)imageName;

- (void)popVC;

@end
