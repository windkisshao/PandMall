//
//  BasketProductModel.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasketProductModel : RLMObject

@property NSString *name;
@property NSString *price;
@property NSString *firstImgName;
@property NSInteger count;//数量

@end

RLM_ARRAY_TYPE(BasketProductModel)


NS_ASSUME_NONNULL_END
