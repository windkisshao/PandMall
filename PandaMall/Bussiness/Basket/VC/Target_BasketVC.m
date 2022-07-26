//
//  Target_BasketVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "Target_BasketVC.h"
#import "BasketVC.h"

@implementation Target_BasketVC

-(UIViewController *)Action_NativeToBasketVCWithParams:(NSDictionary *)params {
    BasketVC *vc = [[BasketVC alloc] init];
    return vc;
}

@end
