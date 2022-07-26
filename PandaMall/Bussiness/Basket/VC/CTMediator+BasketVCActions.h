//
//  CTMediator+BasketVCActions.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (BasketVCActions)

-(UIViewController *)basketVC_ViewControllerWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
