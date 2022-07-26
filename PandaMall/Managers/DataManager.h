//
//  DataManager.h
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
#import "UserModel.h"
#import "RealUserModel.h"
#import "OrderModel.h"
#import "OrderConfirmModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property(nonatomic,strong)NSMutableArray *allGoodsArray;
@property(nonatomic,strong)NSMutableArray *hotGoodsArray;
@property(nonatomic,strong)NSMutableArray *vegeGoodsArray;
@property(nonatomic,strong)NSMutableArray *meatGoodsArray;
@property(nonatomic,strong)NSMutableArray *seafoodGoodsArray;

@property(nonatomic,strong)NSMutableArray *basketGoodsArray;

@property(nonatomic,strong)UserModel *userModel;
@property(nonatomic,strong)RealUserModel *realUserModel;

+(instancetype)shareInstance;

-(void)saveDataModels:(NSArray<RLMObject *> *)modelArr;

-(void)updateDateModl:(RLMObject *)model;

-(void)deleteDateModel:(RLMObject *)model;

-(NSArray *)findAllbasketObjects;

-(NSArray *)findAllOrders;

-(ProductModel *)getProductModelWithName:(NSString *)name;

-(void)addProductModelToBasket:(ProductModel *)model;

@end

NS_ASSUME_NONNULL_END
