//
//  JMMyOrderListViewController.m
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyOrderListViewController.h"
#import "JMTitlesView.h"
#import "JMOrderStatusTableViewCell.h"
#import "JMOrderCellData.h"
#import "JMHTTPManager+FectchOrderList.h"
#import "JMOrderCellData.h"
#import "JMLogisticsInfoViewController.h"
#import "JMSearchOrderViewController.h"
#import "JMApplyForRefundViewController.h"
#import "JMCreatChatAction.h"
#import "WXApi.h"
#import "JMHTTPManager+OrderPay.h"
#import "JMOrderPaymentModel.h"
#import "JMRefundCauseView.h"
#import "JMAfterSalesInfoViewController.h"
#import "JMOrderInfoViewController.h"
#import "JMOrderListExtensionTableViewCell.h"
#import "JMHTTPManager+ChangeOrderStatus.h"
@interface JMMyOrderListViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,JMOrderStatusTableViewCellDelegate,JMRefundCauseViewDelegate>
@property (strong, nonatomic) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)JMOrderCellData *orderCellData;
@property(nonatomic,assign)NSInteger index;
//@property (strong, nonatomic) UIScrollView *scrollView;
//@property (strong, nonatomic) UIView *BGView;
@property (strong, nonatomic) NSMutableArray *listDataArray;
@property (nonatomic, copy) NSString *currentStatus;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger per_page;
@property(nonatomic,assign) BOOL isShowAllData;
@property(nonatomic,strong)JMRefundCauseView *deleteOrderView;
@property(nonatomic,strong)UILabel *topLab;
@end
static NSString *cellID = @"statusCellID";
static NSString *cellID2 = @"extensionCellID";

@implementation JMMyOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
//    [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];

    self.per_page = 10;
    self.page = 1;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        [self getData_status:self.currentStatus];
        self.title = @"订单列表";
    }else{
        [self getC_data_status:self.currentStatus];
        if (_viewType == JMMyOrderListViewControllerCUserExtension) {
            self.title = @"推广订单";
        }else{
            self.title = @"我的订单";
        
        }
        
        
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - 数据请求
-(void)getData_status:(NSString *)status{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchOrderList_order_id:nil contact_city:nil contact_phone:nil keyword:@"" status:status s_date:nil e_date:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMOrderCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            if (array.count == 0) {
                _isShowAllData = YES;
                [self.tableView.mj_footer setHidden:YES];
            }
                        
            [self.listDataArray addObjectsFromArray:array];

            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];

        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)getC_data_status:(NSString *)status{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    NSString *referrer_id = @"";
    NSString *user_id = @"";
    if (_viewType == JMMyOrderListViewControllerCUserExtension) {
        referrer_id = userModel.user_id;
    }else if (_viewType == JMMyOrderListViewControllerCUser){
        user_id = userModel.user_id;
    }
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchC_OrderList_order_id:nil contact_city:nil referrer_id:referrer_id  user_id:user_id  contact_phone:nil keyword:@"" status:status s_date:nil e_date:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMOrderCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            if (array.count == 0) {
                _isShowAllData = YES;
                [self.tableView.mj_footer setHidden:YES];
            }
                        
            [self.listDataArray addObjectsFromArray:array];

            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];

        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)deleteOrderStatus:(NSString *)status order_id:(NSString *)order_id msg:(NSString *)msg{
    [[JMHTTPManager sharedInstance]deleteOrderWithOrder_id:order_id status:status msg:msg successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.tableView.mj_header beginRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

-(void)refreshData{
    [self.listDataArray removeAllObjects];
    self.page = 1;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        [self getData_status:self.currentStatus];
    }else{
        [self getC_data_status:self.currentStatus];
    }
}

-(void)loadMoreBills{
    if (!_isShowAllData) {
        self.page += 1;
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            [self getData_status:self.currentStatus];
        }else{
            [self getC_data_status:self.currentStatus];
        }
        
    }

}
-(void)setupHeaderRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
//    [self.tableView.mj_header beginRefreshing];
}

-(void)setupFooterRefresh
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
    
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    footer.stateLabel.textColor = MASTER_COLOR;
    
    // 设置footer
    self.tableView.mj_footer = footer;
    //     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initView{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    [self.view addSubview:self.tableView];
    if (_viewType == JMMyOrderListViewControllerCUserExtension) {
        self.tableView.tableHeaderView = self.topLab;
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.mas_equalTo(self.mas_topLayoutGuideTop);
              make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
              make.left.and.right.mas_equalTo(self.view);
          }];
    }else if (_viewType == JMMyOrderListViewControllerCUser && [userModel.type isEqualToString:C_Type_USER]) {
        [self.view addSubview:self.titleView];
        self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideTop).offset(self.titleView.frame.size.height);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
            make.left.and.right.mas_equalTo(self.view);
        }];
    }else if ([userModel.type isEqualToString:B_Type_UESR]) {
        [self.view addSubview:self.titleView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideTop).offset(self.titleView.frame.size.height);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
            make.left.and.right.mas_equalTo(self.view);
        }];
    }
//    [self.view addSubview:self.BGView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.deleteOrderView];
    [self.deleteOrderView setHidden:YES];

    [self setupHeaderRefresh];
    [self setupFooterRefresh];
    
//    [self.BGView addSubview:self.tableView2];
//    [self.BGView addSubview:self.tableView3];

}

-(void)setCurrentIndex{
//    __weak typeof(self) ws = self;
//  [self.scrollView setContentOffset:CGPointMake(_index * SCREEN_WIDTH, 0) animated:YES];
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
////        self.scrollView.contentOffset.x = -_index * SCREEN_WIDTH;
//        CGRect Frame = ws.BGView.frame;
//        Frame.origin.x = -_index * SCREEN_WIDTH;
//        ws.BGView.frame = Frame;
////        //        CGRect Frame2 = ws.partTimeJobVC.view.frame;
////        //        Frame2.origin.x = -_index * SCREEN_WIDTH;
////        //        ws.partTimeJobVC.view.frame = Frame2;
////
//
//    } completion:nil];
    switch (_index) {
        case 0:
            self.currentStatus = nil;//全部
            break;
        case 1:
            self.currentStatus = @"2";//已支付

            break;
        case 2:
            self.currentStatus = @"0";//已下单 ，没付款

            break;
        case 3:
            self.currentStatus = @"-1";//售后中
            
            break;
        default:
            break;
    }
    
    [self.tableView.mj_header beginRefreshing];
    
    
}

#pragma mark - action
-(void)rightAction{
    NSLog(@"asdf");
    JMSearchOrderViewController *vc = [[JMSearchOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
    CGFloat goodsViewH;
    goodsViewH = _orderCellData.goods.count * 80;
    if (_viewType == JMMyOrderListViewControllerCUserExtension) {
        return 110 + goodsViewH;
    }
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    CGFloat bottomH;
//    if ([userModel.type isEqualToString:C_Type_USER]) {
        bottomH = 59;
//    }
//    else{
//        bottomH = 0;
//    }
    if (_orderCellData.isSpread) {
        return 190+bottomH+goodsViewH;
    }
    return 110+bottomH+goodsViewH;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_viewType == JMMyOrderListViewControllerCUserExtension) {
        JMOrderListExtensionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2 forIndexPath:indexPath];
           if (cell == nil) {
               cell = [[JMOrderListExtensionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
           }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           NSLog(@"%ld",(long)indexPath.row);
           [cell setOrderCellData:self.listDataArray[indexPath.row]];
           // Configure the cell...
           return cell;
    }else{
        JMOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[JMOrderStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        NSLog(@"%ld",(long)indexPath.row);
        [cell setOrderCellData:self.listDataArray[indexPath.row]];
        // Configure the cell...
        return cell;
    
    }
}

#pragma mark - Table view data delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _orderCellData = self.listDataArray[indexPath.row];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if([_orderCellData.status isEqualToString:@"0"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeNoPay;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else  if([_orderCellData.status isEqualToString:@"1"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeDidDeleteOrder;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([_orderCellData.status isEqualToString:@"2"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeWaitDeliverGoods;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if([_orderCellData.status isEqualToString:@"6"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewDidDeliverGoods;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if([_orderCellData.status isEqualToString:@"7"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewSetRefund;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if([_orderCellData.status isEqualToString:@"8"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeWaitGoodsReturn;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if([_orderCellData.status isEqualToString:@"9"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeRefuseRefund;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if([_orderCellData.status isEqualToString:@"10"]){
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewCDidDeliverGoods;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
       else if ([_orderCellData.status isEqualToString:@"11"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeDidRefund;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
       else if([_orderCellData.status isEqualToString:@"12"]){
           JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
           vc.order_id = _orderCellData.order_id;
           vc.viewType = JMOrderInfoViewTakeDeliveryGoods;
           [self.navigationController pushViewController:vc animated:YES];
       }
  
        
    }else{
        if ([_orderCellData.status isEqualToString:@"0"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeNoPay;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([_orderCellData.status isEqualToString:@"1"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeDidDeleteOrder;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([_orderCellData.status isEqualToString:@"2"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeDidPay;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if ([_orderCellData.status isEqualToString:@"6"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewDidDeliverGoods;
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                vc.isExtension = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        else  if ([_orderCellData.status isEqualToString:@"7"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewAfterSales;
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                vc.isExtension = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_orderCellData.status isEqualToString:@"8"]) {//等待退货
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeWaitGoodsReturn;
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                vc.isExtension = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_orderCellData.status isEqualToString:@"9"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType =  JMOrderInfoViewTypeRefuseRefund;
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                vc.isExtension = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_orderCellData.status isEqualToString:@"10"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewCDidDeliverGoods;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([_orderCellData.status isEqualToString:@"11"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTypeDidRefund;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([_orderCellData.status isEqualToString:@"12"]) {//已收货
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType = JMOrderInfoViewTakeDeliveryGoods;
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                vc.isExtension = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([_orderCellData.status isEqualToString:@"13"]) {
            JMOrderInfoViewController *vc = [[JMOrderInfoViewController alloc]init];
            vc.order_id = _orderCellData.order_id;
            vc.viewType =  JMOrderInfoViewFinish;
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                vc.isExtension = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}


#pragma mark - myDelegate

-(void)didClickDetail_isSpread:(BOOL)isSpread indexPath:(nonnull NSIndexPath *)indexPath{
    _orderCellData = self.listDataArray[indexPath.row];
    if (_orderCellData.isSpread == NO) {
        _orderCellData.isSpread = YES;
        
    }else{
        _orderCellData.isSpread = NO;
    }
    //        [self.listDataArray replaceObjectAtIndex:indexPath.row withObject:_orderCellData];
    
//    [self.tableView reloadData];
    [self.tableView beginUpdates];
//    NSIndexPath *indexRow = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//
    [self.tableView endUpdates];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.row] withRowAnimation:(UITableViewRowAnimationFade)];
    
}

-(void)didClickDeliverGoodsWithData:(JMOrderCellData *)data{
    JMLogisticsInfoViewController *vc = [[JMLogisticsInfoViewController alloc]init];
    vc.order_id = data.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}

//100取消订单  101联系卖/买家  102确认收货 103去付款
-(void)didClickBottomBtnActionWithTag:(NSInteger)tag data:(nonnull JMOrderCellData *)data{
    _orderCellData = data;
    if (tag == 100) {
//        [self changOrderStatus:@"1" order_id:data.order_id];
        [self.deleteOrderView show];
    }else if (tag == 101) {
        NSString *user_id = [NSString stringWithFormat:@"%@b",data.shop_user_id];
        [JMCreatChatAction create4TypeChatRequstWithAccount:user_id];
        
    }else if (tag == 102){
        [self changOrderStatus:@"12" order_id:data.order_id];
    
    }else if (tag == 103){
        [self payWithData:data mode:@""];
         
    }
    
//    JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
 
}

-(void)changOrderStatus:(NSString *)status order_id:(NSString *)order_id{
    [[JMHTTPManager sharedInstance]changeOrderStatusWithOrder_id:order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                         delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
           [alert show];
        [self.tableView.mj_header beginRefreshing];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

- (void)payWithData:(JMOrderCellData *)data mode:(NSString *)mode
{
    [[JMHTTPManager sharedInstance]fectchOrderPaymentInfoWithOrder_id:data.order_id scenes:@"app" type:@"2" mode:mode is_invoice:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMOrderPaymentModel *model = [JMOrderPaymentModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self wechatPayWithModel:model];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}
//拉起微信支付
- (void)wechatPayWithModel:(JMOrderPaymentModel *)model{
    
    PayReq* req = [[PayReq alloc] init];
    req.partnerId = model.wx_partnerid;
    req.prepayId = model.wx_prepayid;
    req.nonceStr = model.wx_noncestr;
    req.timeStamp = model.wx_timestamp;
    req.package = model.wx_package;
    req.sign = model.wx_sign;
    [WXApi sendReq:req];
    
//    [self payMoneyRequestWithNo:model.serial_no amount:@"130"];
    
    
}

-(void)submitActionWithMsg:(NSString *)msg{
    [self deleteOrderStatus:@"1" order_id:self.orderCellData.order_id msg:msg];
 
}
#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,_titleView.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderListExtensionTableViewCell" bundle:nil] forCellReuseIdentifier:cellID2];

    }
    return _tableView;
}



        
- (JMTitlesView *)titleView {
    if (!_titleView) {
        NSArray *titleArray = [NSArray array];
        JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
        if ([model.type isEqualToString:B_Type_UESR]) {
            titleArray = @[@"全部", @"已付款", @"未付款",@"已发货"];
        }else if ([model.type isEqualToString:C_Type_USER]){
            if (_viewType == JMMyOrderListViewControllerCUserExtension) {
                 titleArray = @[@"全部", @"即将到账",@"已到账"];
            }else if (_viewType == JMMyOrderListViewControllerCUser) {
                titleArray = @[@"全部", @"已付款", @"未付款",@"售后中"];
            
            }
        }
   
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:titleArray];
        __weak JMMyOrderListViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}


-(NSMutableArray *)listDataArray{
    if (_listDataArray.count == 0) {
        _listDataArray = [NSMutableArray array];
    }
    return _listDataArray;
}


-(JMRefundCauseView *)deleteOrderView{
    if (!_deleteOrderView) {
        _deleteOrderView = [[JMRefundCauseView alloc]init];
        _deleteOrderView.titleArray = @[@"不想买了",@"信息填写错误，重新拍" ,@"卖家缺货",@"点错了",@"其他原因"];
        _deleteOrderView.titleLab.text = @"取消原因";
        _deleteOrderView.delegate = self;
        _deleteOrderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _deleteOrderView;
}

-(UILabel *)topLab{
    if (!_topLab) {
        _topLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        _topLab.text = @"消费者如自成交日起十五天内退款，佣金将原路退回";
        _topLab.textAlignment = NSTextAlignmentCenter;
        _topLab.backgroundColor = UIColorFromHEX(0xFEF9E5);
        _topLab.textColor = UIColorFromHEX(0xF2822E);
        _topLab.font = kFont(12);
    }
    return _topLab;

}
//
//-(UIView *)BGView{
//    if (!_BGView) {
//        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0,43, SCREEN_WIDTH*3, SCREEN_HEIGHT)];
//        _BGView.backgroundColor = MASTER_COLOR;
//
//    }
//    return _BGView;
//}
//



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
