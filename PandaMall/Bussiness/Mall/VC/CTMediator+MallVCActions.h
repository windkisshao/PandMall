//
//  CTMediator+MallVCActions.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (MallVCActions)

-(UIViewController *)mallVC_ViewControllerWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
