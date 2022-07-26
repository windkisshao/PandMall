//
//  SearchResultVC.m
//  PandaMall
//
//  Created by Sherlock on 2022/7/25.
//

#import "SearchResultVC.h"
#import "ProductListCell.h"
#import "ProductDetailInfoVC.h"

@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation SearchResultVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#5BB2CD"];
    [self setNavTitle:@"搜索结果"];

    self.dataArray = [NSMutableArray new];
    
    [self.view addSubview:self.tableView];
    
    [SVProgressHUD showWithStatus:@"搜索中..."];
    
    [CommonUtil doTaskAfter:1.5 withBlock:^{
        if ([DataManager shareInstance].allGoodsArray.count > 0) {
            for (ProductModel *model in [DataManager shareInstance].allGoodsArray) {
                if ([model.name containsString:_contentStr]) {
                    [self.dataArray addObject:model];
                }
            }
            
            [SVProgressHUD dismiss];
            if (self.dataArray.count <= 0) {
                [SVProgressHUD showErrorWithStatus:@"未找到相关结果"];
            } else {
                [self.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"未找到相关结果"];
        }
    }];
    

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
