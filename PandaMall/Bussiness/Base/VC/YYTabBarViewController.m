//
//  YYTabBarViewController.m
//  CustomerShopping
//
//  Created by yuwell on 2019/10/9.
//  Copyright © 2019 zhaofen. All rights reserved.
//

#import "YYTabBarViewController.h"
#import "YYNavigationViewController.h"
#import "CTMediator+MallVCActions.h"
#import "CTMediator+MineVCActions.h"
#import "CTMediator+BasketVCActions.h"

@interface YYTabBarViewController ()<UITabBarControllerDelegate>
@end

@implementation YYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        if (@available(iOS 13.0, *)) {
            UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
            standardAppearance.backgroundColor = [UIColor whiteColor];//根据自己的情况设置
//            standardAppearance.shadowColor = [UIColor whiteColor];//也可以设置为白色或任何颜色
//            standardAppearance.backgroundEffect = nil;
            // 设置未被选中的颜色
            standardAppearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName:ColorWithRGB(0x9a, 0x9f, 0xb3, 1)};
            // 设置被选中时的颜色
            standardAppearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName:RGBColor(0x12, 0x96, 0xdb)};
            
            if (@available(iOS 15.0, *)) {
                self.tabBar.scrollEdgeAppearance = standardAppearance;
            }
            self.tabBar.standardAppearance = standardAppearance;
            
         } else {
//            [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
//            [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
            [UITabBar appearance].backgroundColor = [UIColor whiteColor];//根据自己的情况设置
             [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBColor(0x12, 0x96, 0xdb)} forState:UIControlStateSelected];
             // 未选中状态的标题颜色
             [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorWithRGB(0x9a, 0x9f, 0xb3, 1)} forState:UIControlStateNormal];
        }
        
        //首页
        UIViewController *mallVC = [[CTMediator sharedInstance] mallVC_ViewControllerWithParams:@{}];
        [self addChildViewControllerWithClass:mallVC withTitle:@"商城" withImage:[UIImage imageNamed:@"icon_mall_nor"] withSelectImage:[UIImage imageNamed:@"icon_mall_sel"]];

        
        //购物篮
        UIViewController *basketVC = [[CTMediator sharedInstance] basketVC_ViewControllerWithParams:@{}];
        [self addChildViewControllerWithClass:basketVC withTitle:@"购物篮" withImage:[UIImage imageNamed:@"icon_basket_nor"] withSelectImage:[UIImage imageNamed:@"icon_basket_sel"]];

        
        //创建我的控制器
        UIViewController *mineVC = [[CTMediator sharedInstance] mineVC_ViewControllerWithParams:@{}];
        [self addChildViewControllerWithClass:mineVC withTitle:@"我的" withImage:[UIImage imageNamed:@"icon_mine_nor"] withSelectImage:[UIImage imageNamed:@"icon_mine_sel"]];
    }
    return self;
}

- (UIViewController *)addChildViewControllerWithClass:(UIViewController *)vc withTitle:(NSString *)title withImage:(UIImage *)image withSelectImage:(UIImage *)selectImage{
        
    return [self addChildViewControllerWithVC:vc withTitle:title withImage:image withSelectImage:selectImage];
}

- (UIViewController *)addChildViewControllerWithVC:(UIViewController *)VC withTitle:(NSString *)title withImage:(UIImage *)image withSelectImage:(UIImage *)selectImage
{
    
    //设置标题
    VC.title                = title;
    //设置图片
    VC.tabBarItem.image     = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
    //设置tabBar选中时的图片
    VC.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.delegate = self;
    
    YYNavigationViewController *nav = [[YYNavigationViewController alloc] initWithRootViewController:VC];
    
    [self addChildViewController:nav];
    
    return VC;
}


@end
