//
//  YYNavigationViewController.m
//  Respirator
//
//  Created by yuwell on 2018/11/1.
//  Copyright © 2018年 zhaofen. All rights reserved.
//

#import "YYNavigationViewController.h"

@interface YYNavigationViewController ()

@end

@implementation YYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakself = self;
           if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
               self.interactivePopGestureRecognizer.delegate = (id)weakself;
           }
    // Do any additional setup after loading the view.
}
#pragma mark - UIGestureRecognizerDelegate
//这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        //屏蔽调用rootViewController的滑动返回手势，避免右滑返回手势引起死机问题
        if (self.viewControllers.count < 2 ||
 self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    //这里就是非右滑手势调用的方法啦，统一允许激活
    return YES;
}
/**
 *  重写navigation的push方法
 *
 *  @param viewController push到的控制器
 *  @param animated       是否开启动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        UIImage *image = [UIImage imageNamed:@"back_black"];
        viewController.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
        viewController.hidesBottomBarWhenPushed=YES;// 进入后隐藏tabbar
    }else{
        self.hidesBottomBarWhenPushed = NO;// 退出时显示tabbar
    }
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:ColorWithRGB(245, 245, 245, 1)] forBarMetrics:(UIBarMetricsDefault)];

    [super pushViewController:viewController animated:animated];
    
//    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
    
}

/**
 *  返回上一个控制器
 */
- (void)pop{
    [self popViewControllerAnimated:YES];
}


@end
