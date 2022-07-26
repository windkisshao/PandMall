//
//  Target_MallVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "Target_MallVC.h"
#import "MallVC.h"

@implementation Target_MallVC

-(UIViewController *)Action_NativeToMallVCWithParams:(NSDictionary *)params {
    MallVC *vc = [[MallVC alloc] init];
    return vc;
}

@end
