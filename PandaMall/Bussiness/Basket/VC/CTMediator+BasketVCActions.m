//
//  CTMediator+BasketVCActions.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "CTMediator+BasketVCActions.h"

//1.字符串是类名 Target_xxx.h 中的xxx部分
NSString *const kCTMediatorTarget = @"BasketVC";

//2.字符串是 Target_xxx.h 中 定义的 Action_xxxx 函数名的 xxx 部分
NSString *const KCTMediatorActionNativeTo_BasketVC = @"NativeToBasketVCWithParams";

@implementation CTMediator (BasketVCActions)

-(UIViewController *)basketVC_ViewControllerWithParams:(NSDictionary *)params {
    UIViewController *viewController = [self performTarget:kCTMediatorTarget action:KCTMediatorActionNativeTo_BasketVC params:params shouldCacheTarget:NO];
    
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
