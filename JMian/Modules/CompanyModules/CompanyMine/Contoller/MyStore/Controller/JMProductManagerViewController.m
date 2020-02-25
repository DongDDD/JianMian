//
//  JMProductManagerViewController.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductManagerViewController.h"
#import "JMTitlesView.h"
#import "JMProductManagerTableViewCell.h"
#import "JMSelectProductCategoriesViewController.h"
#import "JMGoodsData.h"
#import "JMHTTPManager+GetGoodsList.h"
#import "JMHTTPManager+UpdateGoodsStatus.h"
@interface JMProductManagerViewController ()<UITableViewDelegate,UITableViewDataSource,JMProductManagerTableViewCellDelegate>
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *listArray;
@property (nonatomic, copy) NSString *currentStatus;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger per_page;
@property(nonatomic,assign)NSInteger index;
@end

@implementation JMProductManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品";
    [self setRightBtnTextName:@"发布"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
    [self setupHeaderRefresh];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getDataWithStatus:@""];
}

-(void)setupHeaderRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
//    [self.tableView.mj_header beginRefreshing];
}

//-(void)setupFooterRefresh
//{
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
//
//    // 设置文字
//    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
//    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
//
//    // 设置字体
//    footer.stateLabel.font = [UIFont systemFontOfSize:14];
//
//    // 设置颜色
//    footer.stateLabel.textColor = MASTER_COLOR;
//
//    // 设置footer
//    self.tableView.mj_footer = footer;
//    //     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
//}

-(void)rightAction{
    [self.navigationController pushViewController:[JMSelectProductCategoriesViewController new] animated:YES];

}

-(void)getDataWithStatus:(NSString *)status{
    [[JMHTTPManager sharedInstance]getGoodsListWithShop_id:self.shop_id status:status keyword:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {

        if (responsObject[@"data"]) {
           NSArray *listArray = [JMGoodsData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [self.listArray addObjectsFromArray:listArray];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];

        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}


-(void)updataGoodsStatus:(NSString *)status goods_id:(NSString *)goods_id{
    [[JMHTTPManager sharedInstance]upDateGoodsStatusWithGoods_id:goods_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            [self.listArray removeAllObjects];
            [self getDataWithStatus:self.currentStatus];
//            [self.tableView.mj_header beginRefreshing];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return self.listArray.count;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMProductManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMProductManagerTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setData:self.listArray[indexPath.row]];
    //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
    //        [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeB];
    return cell;
    
}

-(void)didSelectedBtnWithTitle:(NSString *)title data:(nonnull JMGoodsData *)data{
    if ([title isEqualToString:@"上架"]) {
        [self updataGoodsStatus:@"1" goods_id:data.goods_id];
        
    }else if ([title isEqualToString:@"下架"]) {
    [self updataGoodsStatus:@"0" goods_id:data.goods_id];
    
    }else if ([title isEqualToString:@"复制"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该功能还没开通，敬请等待新版本" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
    }
}

-(void)refreshData{
    [self.listArray removeAllObjects];
    self.page = 1;
    [self getDataWithStatus:self.currentStatus];
}

-(void)showPageContentView{
    [self.listArray removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
    if (_index == 0) {
        self.currentStatus = @"";
        [self getDataWithStatus:@""];
        
    }else if (_index == 1) {
        self.currentStatus = @"0";
        [self getDataWithStatus:@"0"];
        
    }else if (_index == 2) {
        self.currentStatus = @"1";

        [self getDataWithStatus:@"1"];
        
    }
    
}

#pragma mark - lazy

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全部", @"未上架", @"已上架"]];
        __weak JMProductManagerViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.backgroundColor = [UIColor whiteColor];;

        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.titleView;
        _tableView.rowHeight = 154;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;

        [_tableView registerNib:[UINib nibWithNibName:@"JMProductManagerTableViewCell" bundle:nil] forCellReuseIdentifier:JMProductManagerTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreOrderStatusTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager1TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager1TableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager2TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager2TableViewCellIdentifier];
          
        
        
    }
    return _tableView;
}


-(NSMutableArray *)listArray{
    if (_listArray.count == 0) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
