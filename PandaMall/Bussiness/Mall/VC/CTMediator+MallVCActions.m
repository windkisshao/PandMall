//
//  CTMediator+MallVCActions.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "CTMediator+MallVCActions.h"

//TODO: 这里的两个字符串必须 hard code

//1.字符串是类名 Target_xxx.h 中的xxx部分
NSString *const kCTMediatorMallVCTarget = @"MallVC";

//2.字符串是 Target_xxx.h 中 定义的 Action_xxxx 函数名的 xxx 部分
NSString *const KCTMediatorActionNativeTo_MallVC = @"NativeToMallVCWithParams";

@implementation CTMediator (MallVCActions)

-(UIViewController *)mallVC_ViewControllerWithParams:(NSDictionary *)params {
    UIViewController *viewController = [self performTarget:kCTMediatorMallVCTarget action:KCTMediatorActionNativeTo_MallVC params:params shouldCacheTarget:NO];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        NSLog(@"%@ 未能实例化页面", NSStringFromSelector(_cmd));
        return [[UIViewController alloc] init];
    }
}

@end
