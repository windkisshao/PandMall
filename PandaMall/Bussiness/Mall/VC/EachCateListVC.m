//
//  EachCateListVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "EachCateListVC.h"
#import "ProductListCell.h"
#import "ProductDetailInfoVC.h"

@interface EachCateListVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation EachCateListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    self.dataArray = [NSMutableArray new];

    switch (self.type) {
        case ProductTypeMeat:
        {
            [self setNavTitle:@"鲜肉类产品"];
            self.dataArray = [DataManager shareInstance].meatGoodsArray;

        }
            break;
            
        case ProductTypeVege:
        {
            [self setNavTitle:@"果蔬类产品"];
            self.dataArray = [DataManager shareInstance].vegeGoodsArray;
        }
            break;
            
        case ProductTypeSeafood:
        {
            [self setNavTitle:@"海鲜类产品"];
            self.dataArray = [DataManager shareInstance].seafoodGoodsArray;
        }
            break;
    }
    
    
    [self.view addSubview:self.tableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductModel *model = self.dataArray[indexPath.row];
    ProductDetailInfoVC *vc = [[ProductDetailInfoVC alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[ProductListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    ProductModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScale(80);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, mcNavBarAndStatusBarHeight, SCREENWIDTH, ScreenHeight - mcNavBarAndStatusBarHeight - mcBottomSafeHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kClearColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

@end
