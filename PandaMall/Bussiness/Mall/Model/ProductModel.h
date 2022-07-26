//
//  ProductModel.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductTypeSeafood = 0,
    ProductTypeVege = 1,
    ProductTypeMeat = 2
} ProductType;

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *firstImgName;
@property(nonatomic,strong)NSString *detailInfo;
@property(nonatomic,assign)ProductType type;
@property(nonatomic,assign)NSInteger count;//数量

@end

NS_ASSUME_NONNULL_END
