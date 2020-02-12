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
#import "JMHTTPManager+GetManageGoodsList.h"
#import "JMGoodsData.h"
@interface JMProductManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *listArray;
@property(nonatomic,assign)NSInteger index;
@end

@implementation JMProductManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品";
    [self setRightBtnTextName:@"发布"];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getDataWithStatus:@""];
}

-(void)rightAction{
    [self.navigationController pushViewController:[JMSelectProductCategoriesViewController new] animated:YES];

}

-(void)getDataWithStatus:(NSString *)status{
    [[JMHTTPManager sharedInstance]getManagerGoodsLIstWithKeyword:@"" shop_id:@"" status:status page:@"" per_page:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.listArray = [JMGoodsData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [self.tableView reloadData];
        
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
    [cell setData:self.listArray[indexPath.row]];
    //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
    //        [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeB];
    return cell;
    
    
}

-(void)showPageContentView{
    if (_index == 0) {
        [self getDataWithStatus:@""];
        
    }else if (_index == 1) {
        [self getDataWithStatus:@"0"];
        
    }else if (_index == 2) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
