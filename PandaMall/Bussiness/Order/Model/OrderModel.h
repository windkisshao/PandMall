//
//  OrderModel.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "OrderConfirmModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : RLMObject

@property NSString *tradeNo;
@property NSString *tradeTime;
@property NSString *totalPrice;
@property NSString *userNickName;
@property NSString *cellPhone;
@property NSString *addressInfo;
@property RLMArray<OrderConfirmModel *><OrderConfirmModel> *products;//产品

@end

RLM_ARRAY_TYPE(OrderModel)

NS_ASSUME_NONNULL_END
