//
//  DataManager.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)shareInstance {
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)saveDataModels:(NSArray<RLMObject *> *)modelArr {
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addOrUpdateObjects:modelArr];
    }];
}

-(void)updateDateModl:(RLMObject *)model {
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] addOrUpdateObject:model];
    }];
}

-(void)deleteDateModel:(RLMObject *)model {
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObject:model];
    }];
}

-(NSArray *)findAllOrders {
    RLMResults<OrderModel*> *resultArr = [OrderModel allObjects];
    NSMutableArray *arr = [NSMutableArray new];
    for (OrderModel *model in resultArr) {
        [arr addObject:model];
    }
    return arr;
}

-(NSArray *)findAllbasketObjects {
    RLMResults<BasketProductModel *> *resultArr = [BasketProductModel allObjects];
    NSMutableArray *arr = [NSMutableArray new];
    for (BasketProductModel *model in resultArr) {
        [arr addObject:model];
    }
    return arr;
}

-(ProductModel *)getProductModelWithName:(NSString *)name {
    for (ProductModel *model in [DataManager shareInstance].allGoodsArray) {
        if ([model.name isEqualToString:name]) {
            return model;
        }
    }
    return nil;
}

-(instancetype)init {
    if (self = [super init]) {
        _allGoodsArray = [NSMutableArray new];
        _hotGoodsArray = [NSMutableArray new];
        _seafoodGoodsArray = [NSMutableArray new];
        _vegeGoodsArray = [NSMutableArray new];
        _meatGoodsArray = [NSMutableArray new];
        _basketGoodsArray = [NSMutableArray new];
        
        [self initLocalData];
        
        RealUserModel *realModel = [[RealUserModel alloc] init];
        realModel.userName = @"test";
        realModel.password = @"1234";
        self.realUserModel = realModel;
    }
    return self;
}

-(void)initLocalData {
    [self initHotGoodsArray];
    [self initAllGoodsArray];
    [self initSeafoodGoodsArray];
    [self initMeatGoodsArray];
    [self initVegaGoodsArray];
    [self initBasketGoodsArray];
    [self initUserModelInfo];
}

-(void)initUserModelInfo {
    RLMResults<UserModel *> *resultArr = [UserModel allObjects];
    if (resultArr.count > 0) {
       self.userModel = resultArr[0];
    }
}

-(void)refreshBasketArray {
    [self.basketGoodsArray removeAllObjects];
    [self initBasketGoodsArray];
}

-(void)initBasketGoodsArray {
    RLMResults<BasketProductModel *> *resultArr = [BasketProductModel allObjects];
    for (BasketProductModel *model in resultArr) {
        [self.basketGoodsArray addObject:model];
    }
}

-(void)addProductModelToBasket:(ProductModel *)model {
    [self refreshBasketArray];
    
    BOOL isExists = NO;
    for (BasketProductModel *tempModel in self.basketGoodsArray) {
        if ([model.name isEqualToString:tempModel.name]) {
            isExists = YES;
            break;
        }
    }
    if (!isExists) {
        //不存在，保存
        BasketProductModel *basketModel = [[BasketProductModel alloc] init];
        basketModel.name = model.name;
        basketModel.count = 1;
        basketModel.price = model.price;
        basketModel.firstImgName = model.firstImgName;
        
        [[DataManager shareInstance] saveDataModels:@[basketModel]];
        [self.basketGoodsArray addObject:basketModel];
    }
}

-(void)initHotGoodsArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hot" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in arr) {
        ProductModel *model = [ProductModel mj_objectWithKeyValues:dic];
        [self.hotGoodsArray addObject:model];
    }
}

-(void)initAllGoodsArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"all" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in arr) {
        ProductModel *model = [ProductModel mj_objectWithKeyValues:dic];
        [self.allGoodsArray addObject:model];
    }
}

-(void)initSeafoodGoodsArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"seafood" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in arr) {
        ProductModel *model = [ProductModel mj_objectWithKeyValues:dic];
        [self.seafoodGoodsArray addObject:model];
    }
}

-(void)initMeatGoodsArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meat" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in arr) {
        ProductModel *model = [ProductModel mj_objectWithKeyValues:dic];
        [self.meatGoodsArray addObject:model];
    }
}

-(void)initVegaGoodsArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vega" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *arr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in arr) {
        ProductModel *model = [ProductModel mj_objectWithKeyValues:dic];
        [self.vegeGoodsArray addObject:model];
    }
}

@end
