//
//  EditInfoVC.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/26.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    EditTypeNickName,
    EditTypeCellPhone,
    EditTypeAddressInfo,
} EditType;

NS_ASSUME_NONNULL_BEGIN

@interface EditInfoVC : BaseViewController

@property(nonatomic,assign)EditType editType;

@end

NS_ASSUME_NONNULL_END
