//
//  OrderConfirmModel.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderConfirmModel : RLMObject

@property NSString *name;
@property NSString *price;
@property NSString *firstImgName;
@property NSInteger count;//数量

@end

RLM_ARRAY_TYPE(OrderConfirmModel)

NS_ASSUME_NONNULL_END
