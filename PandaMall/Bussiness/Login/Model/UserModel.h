//
//  UserModel.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : RLMObject

@property NSString *userNickname;
@property NSString *cellPhone;
@property NSString *userName;
@property NSString *password;
@property NSString *addressInfo;

@end

RLM_ARRAY_TYPE(UserModel)

NS_ASSUME_NONNULL_END
