//
//  JMSearchOrderViewController.m
//  JMian
//
//  Created by mac on 2019/10/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSearchOrderViewController.h"
#import "SearchView.h"
#import "JMOrderStatusTableViewCell.h"
#import "JMOrderCellData.h"
#import "JMHTTPManager+FectchOrderList.h"
#import "JMOrderCellData.h"
#import "JMLogisticsInfoViewController.h"

@interface JMSearchOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(weak, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong)SearchView *searchView;
@property(strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)JMOrderCellData *orderCellData;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger per_page;
@property(strong, nonatomic) NSMutableArray *listDataArray;

@end
static NSString *cellID = @"statusCellID";

@implementation JMSearchOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单搜索";
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.tableView];
//     [self getData_keyword:@""];

}

#pragma mark - 数据请求
-(void)getData_keyword:(NSString *)keyword{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchOrderList_order_id:nil contact_city:nil contact_phone:nil keyword:keyword status:@""    s_date:nil e_date:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMOrderCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
//            if (array.count == 0) {
//                [self.tableView.mj_footer setHidden:YES];
//            }
                        
            [self.listDataArray addObjectsFromArray:array];

//            [self.tableView.mj_header endRefreshing];
//            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];

        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}
#pragma mark - delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    [self initSearchRequest_keywords:textField.text request:nil];
//    _keywordsRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    [self.searchView.searchTextField resignFirstResponder];
    [self getData_keyword:textField.text];

//    [self.tableView reloadData];
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.listDataArray.count;
    }
//    else if (tableView == self.tableView2){
//        return self.listDataArray2.count;
//    }else if (tableView == self.tableView3){
//        return self.listDataArray3.count;
//    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _orderCellData = self.listDataArray[indexPath.row];
    if (_orderCellData.isSpread) {
        return 256;
    }
    return 164;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JMOrderStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    [cell setOrderCellData:self.listDataArray[indexPath.row]];
    // Configure the cell...
    return cell;
}

#pragma mark - myDelegate

-(void)didClickDetail_isSpread:(BOOL)isSpread indexPath:(nonnull NSIndexPath *)indexPath{
    _orderCellData = self.listDataArray[indexPath.row];
    if (_orderCellData.isSpread == NO) {
        _orderCellData.isSpread = YES;
    }else{
        _orderCellData.isSpread = NO;
    }
    [self.listDataArray replaceObjectAtIndex:indexPath.row withObject:_orderCellData];
    [self.tableView reloadData];
    
}

-(void)didClickDeliverGoodsWithData:(JMOrderCellData *)data{
    JMLogisticsInfoViewController *vc = [[JMLogisticsInfoViewController alloc]init];
    vc.order_id = data.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - lazy

-(SearchView *)searchView{
    if (_searchView == nil) {
        _searchView = [[SearchView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 40)];
        _searchView.searchTextField.delegate = self;
        _searchView.searchTextField.placeholder = @"搜索订单";

    }
    return _searchView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.topView.frame.origin.y+self.topView.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];

    }
    return _tableView;
}

-(NSMutableArray *)listDataArray{
    if (_listDataArray.count == 0) {
        _listDataArray = [NSMutableArray array];
    }
    return _listDataArray;
}

@end
