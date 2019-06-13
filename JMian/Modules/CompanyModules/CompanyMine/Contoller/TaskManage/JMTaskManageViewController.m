//
//  JMTaskManageViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskManageViewController.h"
#import "JMTitlesView.h"
#import "JMTaskManageTableViewCell.h"
#import "JMHTTPManager+FectchMyTaskOrderList.h"
#import "JMHTTPManager+TaskOrderStatus.h"
#import "JMHTTPManager+CreateTaskComment.h"
#import "JMTaskCommetViewController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JMHTTPManager+OrderPay.h"
#import "JMOrderPaymentModel.h"
#import "JMShareView.h"
#import "JMSnapshotWebViewController.h"

@interface JMTaskManageViewController ()<UITableViewDelegate,UITableViewDataSource,JMTaskManageTableViewCellDelegate,JMTaskCommetViewControllerDelegate,JMShareViewDelegate>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSArray *listsArray;
@property (strong, nonatomic) JMShareView *choosePayView;
@property (strong, nonatomic) JMOrderPaymentModel *orderPaymentModel;
@property (nonatomic ,strong) UIView *BGPayView;

@property (strong, nonatomic)NSArray *currentStatus;
@end

@implementation JMTaskManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.currentStatus = @[Task_WaitDealWith];
    [self getDataWitnStatus:self.currentStatus];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 获取数据

-(void)getDataWitnStatus:(NSArray *)status{
    [[JMHTTPManager sharedInstance]fectchTaskList_status:status page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.listsArray = [JMTaskOrderListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


#pragma mark - setUI -

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.choosePayView];
    [self.view addSubview:self.BGPayView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop).mas_offset(44);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.left.and.right.mas_equalTo(self.view);
    }];
    [self.BGPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_choosePayView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGPayView addGestureRecognizer:tap];
    [self setupHeaderRefresh];
    [self setupFooterRefresh];
    
}

#pragma mark - myDelegate
//底部左面的按钮事件
-(void)leftActionWithData:(JMTaskOrderListCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([data.status isEqualToString:Task_WaitDealWith]) {
            //B拒绝
            [self changeTaskStatusRequestWithStatus:Task_Refuse task_order_id:data.task_order_id];
        }
    }
}

//底部右面的按钮事件
-(void)rightActionWithData:(JMTaskOrderListCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        //B现在状态：待处理or待通过
        if ([data.status isEqualToString:Task_WaitDealWith]) {
            //B改状态------B端通过任务申请
            [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
            return;
        }else if([data.status isEqualToString:Task_Finish]) {
            //B改状态------B端确认完成任务&支付尾款
            [self payWithData:data];
            //            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            return;
        }else if([data.status isEqualToString:Task_Pass]) {
            //B改状态------销售分成点击结束任务按钮
            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            return;
        }else if([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_boss isEqualToString:@"0"]) {
            //B——创建评价
            JMTaskCommetViewController *vc = [[JMTaskCommetViewController alloc]init];
            [vc setData:data];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            return;
        }
    }else{
        //C----进行中----
        if ([data.status isEqualToString:Task_Pass]) {
            if (![data.snapshot_type_label_id isEqualToString:@"1043"]) {
                //C---点"已完成"（C 唯一操作）-----status change to  '3'
                [self changeTaskStatusRequestWithStatus:Task_Finish task_order_id:data.task_order_id];
                return;
            }
        }else if([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_user isEqualToString:@"0"]) {
            //C——-创建评价
            JMTaskCommetViewController *vc = [[JMTaskCommetViewController alloc]init];
            [vc setData:data];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            return;
        }
    }
    
    
    
}

-(void)showChoosePayView{
    

    [self.choosePayView setHidden:NO];
    [self.BGPayView setHidden:NO];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0, self.view.frame.size.height-205, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
   
}

-(void)hiddenChoosePayView{
    [self.choosePayView setHidden:YES];
    [self.BGPayView setHidden:YES];
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
        
        
    }];
    
}

-(void)cancelAction{
    [self hiddenChoosePayView];

}


-(void)leftAction{
    [self wechatPayWithModel:self.orderPaymentModel];
    
}

-(void)rightAction{
    [self alipayWithModel:self.orderPaymentModel];
    
    
}
#pragma mark - 支付
- (void)payWithData:(JMTaskOrderListCellData *)data
{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchOrderPaymentInfoWithOrder_id:data.task_order_id scenes:@"app" type:@"1" mode:@"3" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.orderPaymentModel = [JMOrderPaymentModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            [self hiddenHUD];
            [self showChoosePayView];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}




- (void)wechatPayWithModel:(JMOrderPaymentModel *)model{
    PayReq* req = [[PayReq alloc] init];
    req.partnerId = model.wx_partnerid;
    req.prepayId = model.wx_prepayid;
    req.nonceStr = model.wx_noncestr;
    req.timeStamp = model.wx_timestamp;
    req.package = model.wx_package;
    req.sign = model.wx_sign;
    [WXApi sendReq:req];
    
    
}


//支付宝支付
-(void)alipayWithModel:(JMOrderPaymentModel *)model{
    // 发起支付
    [[AlipaySDK defaultService] payOrder:model.alipay fromScheme:@"alisdkdemo" callback:^(NSDictionary *resultDic) {
        NSLog(@"支付结果 reslut = %@",resultDic);
    }];
    
}





-(void)setCurrentIndex{
    switch (_index) {
        case 0:
            //待处理
            self.currentStatus = @[Task_WaitDealWith];
            break;
        case 1:
            //进行中
            self.currentStatus = @[Task_Pass,Task_Finish];
            
            break;
        case 2:
            //已结束
            self.currentStatus = @[Task_Refuse,Task_DidComfirm];
            
            break;
            
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
    [self getDataWitnStatus:self.currentStatus];
    
    
}

-(void)didComment{
    [self.tableView.mj_header beginRefreshing];
    
    
}
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMTaskManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[JMTaskManageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell setData:self.listsArray[indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JMTaskOrderListCellData *data = self.listsArray[indexPath.row];
    JMSnapshotWebViewController *vc = [[JMSnapshotWebViewController alloc]init];
    vc.data = data;
    [self.navigationController pushViewController:vc animated:YES];
    //    _model = self.listsArray[indexPath.row];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    JMTaskOrderListCellData *data = self.listsArray[indexPath.row];
    //C端待处理且是0状态
    if ([data.status isEqualToString:Task_WaitDealWith] && [userModel.type isEqualToString:C_Type_USER]) {
        return 130;
    }else{
        return 177;
        
    }
    
}



#pragma mark - 数据请求
-(void)setupHeaderRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
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


-(void)refreshData{
    [self getDataWitnStatus:self.currentStatus];
    
}

-(void)loadMoreBills{
    [self getDataWitnStatus:self.currentStatus];
    
}

-(void)changeTaskStatusRequestWithStatus:(NSString *)status task_order_id:(NSString *)task_order_id {
    
    [[JMHTTPManager sharedInstance]changeTaskOrderStatusWithTask_order_id:task_order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.tableView.mj_header beginRefreshing];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

//创建评价
-(void)createTaskCommentRequestWithTask_order_id:(NSString *)task_order_id reputation:(NSString *)reputation commentDescription:(NSString *)commentDescription{
    [[JMHTTPManager sharedInstance]createTaskCommentWithForeign_key:task_order_id reputation:reputation commentDescription:commentDescription successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self.tableView.mj_header beginRefreshing];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"待通过", @"进行中", @"已结束"]];
        _titleView.viewType = JMTitlesViewDefault;;
        [_titleView setCurrentTitleIndex:0];
        __weak JMTaskManageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = MASTER_COLOR;
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        //        _tableView.sectionFooterHeight = 0;
        //        [_tableView registerNib:[UINib nibWithNibName:@"JMSquareHeaderModulesTableViewCell" bundle:nil] forCellReuseIdentifier:headerCellId];
        [_tableView registerNib:[UINib nibWithNibName:@"JMTaskManageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        //        [_tableView registerNib:[UINib nibWithNibName:@"JMBUserSquareTableViewCell" bundle:nil] forCellReuseIdentifier:B_cellIdent];
        
    }
    return _tableView;
}

-(JMShareView *)choosePayView{
    if (!_choosePayView) {
        _choosePayView = [[JMShareView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight)];
        _choosePayView.delegate = self;
        [_choosePayView.btn1 setImage:[UIImage imageNamed:@"WeChat_pay"] forState:UIControlStateNormal];
        [_choosePayView.btn2 setImage:[UIImage imageNamed:@"Alipay_pay"] forState:UIControlStateNormal];
        _choosePayView.lab1.text = @"微信支付";
        _choosePayView.lab2.text = @"支付宝";
    }
    return _choosePayView;
}

-(UIView *)BGPayView{
    if (!_BGPayView) {
        _BGPayView = [[UIView alloc]init];
        _BGPayView.backgroundColor = [UIColor blackColor];
        _BGPayView.alpha = 0.5;
        _BGPayView.hidden = YES;
    }
    return  _BGPayView;
    
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
