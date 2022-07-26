//
//  AppDelegate.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "AppDelegate.h"
#import "YYTabBarViewController.h"
#import "RealmManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if(@available(ios 15.0,*)){
            UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
            [appearance configureWithOpaqueBackground];
            appearance.backgroundColor = [UIColor whiteColor];
            appearance.shadowColor = [UIColor clearColor];
        [UINavigationBar appearance].standardAppearance = appearance;
        [UINavigationBar appearance].scrollEdgeAppearance=[UINavigationBar appearance].standardAppearance;
    }else{
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageWithColor:[UIColor whiteColor]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UINavigationBar
          appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    }
    
    [self configSomeScrollViewPropertiesInIOS11];
    
    [RealmManager initRealm];
    [DataManager shareInstance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[YYTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    
    return YES;
}

- (void)configSomeScrollViewPropertiesInIOS11 {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [[UITableView appearance] setEstimatedRowHeight:0.0f];
        [[UITableView appearance] setEstimatedSectionFooterHeight:0.0f];
        [[UITableView appearance] setEstimatedSectionHeaderHeight:0.0f];
    }
}

@end
