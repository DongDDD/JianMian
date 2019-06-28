//
//  JMTaskManageViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskManageViewController.h"
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
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewViewController.h"
#import "JMHTTPManager+PayMoney.h"
#import "JMPayDetailViewController.h"
#import "JMPaySucceedViewController.h"
#import "JMPayFailedViewController.h"
#import "JMHTTPManager+FectchTaskOrderInfo.h"
#import "JMBDetailWebViewController.h"
#import "JMHTTPManager+FectchTaskAbility.h"


@interface JMTaskManageViewController ()<UITableViewDelegate,UITableViewDataSource,JMTaskManageTableViewCellDelegate,JMTaskCommetViewControllerDelegate,JMShareViewDelegate,JMPayDetailViewControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) JMTitlesView *titleView;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSArray *listsArray;
@property (strong, nonatomic) JMShareView *choosePayView;
@property (strong, nonatomic) JMOrderPaymentModel *orderPaymentModel;
@property (strong, nonatomic) NSString *didPayMoney;
@property (strong, nonatomic) JMTaskOrderListCellData *nowTaskData;

@property (nonatomic ,strong) UIView *BGPayView;

@property (strong, nonatomic)NSArray *currentStatusArray;
@property (copy, nonatomic)NSString *task_order_id;
@property (copy, nonatomic)NSString *user_id;

@end

@implementation JMTaskManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.currentStatusArray = @[Task_WaitDealWith];
//    [self getDataWitnStatus:self.currentStatusArray];
//   

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceedNotification) name:Notification_PaySucceed object:nil];

}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - setUI -
-(void)setMyIndex:(NSInteger)myIndex{
    _index = myIndex;
    [self initView];
    [self setCurrentIndex];
    
}


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
-(void)paySucceedNotification{
    
    [self.tableView.mj_header beginRefreshing];
    [self.choosePayView setHidden:YES];
    [self.BGPayView setHidden:YES];
    if ([_nowTaskData.status isEqualToString:Task_Finish]) {
        
        JMTaskCommetViewController *vc = [[JMTaskCommetViewController alloc]init];
        vc.data = _nowTaskData;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        JMPaySucceedViewController *vc = [[JMPaySucceedViewController alloc]init];
        vc.data = _nowTaskData;
        vc.didPayMoney = self.didPayMoney;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
}
//底部左面的按钮事件
-(void)leftActionWithData:(JMTaskOrderListCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([data.status isEqualToString:Task_WaitDealWith]) {
            //B拒绝
            [self changeTaskStatusRequestWithStatus:Task_Refuse task_order_id:data.task_order_id];
        }else if ([data.status isEqualToString:Task_Finish] && _index == 1) {
            //B和他聊聊
            
            [self createChatRequstWithTask_order_id:data.task_order_id user_id:data.user_user_id];
        }else if ([data.status isEqualToString:Task_Pass] && _index == 1) {
            //B结束销售任务
            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];

      
        }
    }
}

//底部右面的按钮事件
-(void)rightActionWithData:(JMTaskOrderListCellData *)data{
    _nowTaskData = data;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        //B现在状态：待处理or待通过
        if ([data.status isEqualToString:Task_WaitDealWith]) {
            
            //B改状态------B端通过任务申请&&支付定金
            if ([data.payment_method isEqualToString:@"3"]) {
                if ([data.front_money isEqualToString:@"0"]) {
                    //无定金直接通过
                    _task_order_id = data.task_order_id;
                    _user_id = data.user_user_id;
                    [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
                }else{
                    //有定金跳支付界面
                    JMPayDetailViewController *vc = [[JMPayDetailViewController alloc]init];
                    vc.data = data;
                    vc.delegate = self;
                    vc.viewType = JMPayDetailViewTypeDownPayment;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
            }else if ([data.payment_method isEqualToString:@"1"]){
                //B改状态------B端通过网络销售任务，直接改状态

                _task_order_id = data.task_order_id;
                _user_id = data.user_user_id;
                [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
                
            }
            return;
        }else if ([data.status isEqualToString:Task_Finish]) {
            //B改状态------B端确认完成任务&支付尾款@"3"
            JMPayDetailViewController *vc = [[JMPayDetailViewController alloc]init];
            vc.data = data;
            vc.delegate = self;
            vc.viewType = JMPayDetailViewTypeFinalPayment;
            [self.navigationController pushViewController:vc animated:YES];
            
             return;
        }else if ([data.status isEqualToString:Task_Pass]) {
            //进行中
            //B---销售分成任务的 分享产品链接按钮
            if ([data.payment_method isEqualToString:@"1"]) {
                //销售任务分享产品链接
                [self getGoodsUrlToShareDataWithTask_order_id:data.task_order_id];
                
            }
            return;
        }else if ([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_boss isEqualToString:@"0"]) {
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
            if (![data.payment_method isEqualToString:@"1"]) {//不是销售分成才有这操作
                //C---点"已完成"（C 唯一操作）-----status change to  '3'
                [self changeTaskStatusRequestWithStatus:Task_Finish task_order_id:data.task_order_id];
                return;
            }else{
                NSLog(@"分享");
                [self getGoodsUrlToShareDataWithTask_order_id:data.task_order_id];

            }
        }else if ([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_user isEqualToString:@"0"]) {
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
//取消
-(void)shareViewCancelAction{
    [self hiddenChoosePayView];

}

//微信支付
-(void)shareViewLeftAction{
    [self wechatPayWithModel:self.orderPaymentModel];
    
}
//支付宝支付
-(void)shareViewRightAction{
    [self alipayWithModel:self.orderPaymentModel];
    
}

//和他聊聊
-(void)iconAlertRightAction{
    
    [self createChatRequstWithTask_order_id:_task_order_id user_id:_user_id];

    
}


//已评价回调
-(void)didComment{
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 数据请求

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

//获得任务信息去快照
-(void)getTaskInfoDataWithTask_order_id:(NSString *)task_order_id{
    [[JMHTTPManager sharedInstance]fectchTaskOrderInfo_taskID:task_order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMTaskOrderListCellData *taskInfoData = [JMTaskOrderListCellData mj_objectWithKeyValues:responsObject[@"data"]];
            
            JMSnapshotWebViewController *vc = [[JMSnapshotWebViewController alloc]init];
            vc.data = taskInfoData;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

//获得ability_id去个人兼职简历
-(void)getTaskAbilityIDInfoWithUser_id:(NSString *)user_id type_label_id:(NSString *)type_label_id{
    
    [[JMHTTPManager sharedInstance]fetchTaskAbilityWithUser_id:user_id type_label_id:type_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSString *ability_id = responsObject[@"data"][@"ability_id"];
            JMBDetailWebViewController *vc = [[JMBDetailWebViewController alloc]init];
            vc.ability_id = ability_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}



-(void)getGoodsUrlToShareDataWithTask_order_id:(NSString *)task_order_id{
    [[JMHTTPManager sharedInstance]fectchTaskOrderInfo_taskID:task_order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMTaskOrderListCellData *taskInfoData = [JMTaskOrderListCellData mj_objectWithKeyValues:responsObject[@"data"]];
            [self wxShare:0 data1:taskInfoData];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

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

//刷新
-(void)refreshData{
    [self getDataWitnStatus:self.currentStatusArray];
    
}
//上拉更多
-(void)loadMoreBills{
    [self getDataWitnStatus:self.currentStatusArray];
    
}
//改变任务状态
-(void)changeTaskStatusRequestWithStatus:(NSString *)status task_order_id:(NSString *)task_order_id {
    
    [[JMHTTPManager sharedInstance]changeTaskOrderStatusWithTask_order_id:task_order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.tableView.mj_header beginRefreshing];
        if ([status isEqualToString:Task_Pass]) {//
            [self showAlertVCWithHeaderIcon:@"purchase_succeeds" message:@"审批通过\n 建议联系对方以便开始任务" leftTitle:@"朕知道了" rightTitle:@"和他聊聊"];
            
        }
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

//创建聊天
-(void)createChatRequstWithTask_order_id:(NSString *)task_order_id user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"1" recipient:user_id foreign_key:task_order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"创建对话成功"
        //                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        //        [alert show];
        JMChatViewViewController *vc = [[JMChatViewViewController alloc]init];
        
        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

#pragma mark - 支付
//支付确认界面
-(void)payDetailViewDownPayAction_data:(JMTaskOrderListCellData *)data{
    _task_order_id = data.task_order_id;
    _user_id = data.user_user_id;
    //B端支付定金
//    [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
    if (![data.front_money isEqualToString:@"0"]) {
        [self payWithData:data mode:@"2"];
        
    }else{
        //定金为0时 直接改状态成@“1” 已通过
        [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:_task_order_id];
    }
    
}

//delegate 付款金额
-(void)didPayMoneyWithStr:(NSString *)str{
    self.didPayMoney = str;
    
}

-(void)payDetailViewAllPayAction_data:(JMTaskOrderListCellData *)data{
    _task_order_id = data.task_order_id;
    _user_id = data.user_user_id;
    //B端支付定金
//    [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
        [self payWithData:data mode:@"3"];
    
}

- (void)payWithData:(JMTaskOrderListCellData *)data mode:(NSString *)mode
{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchOrderPaymentInfoWithOrder_id:data.task_order_id scenes:@"app" type:@"1" mode:mode successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            
            self.orderPaymentModel = [JMOrderPaymentModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            [self hiddenHUD];
            [self showChoosePayView];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

-(void)payMoneyRequestWithNo:(NSString *)no amount:(NSString *)amount{
    
    [[JMHTTPManager sharedInstance]payMoneyOrder_no:no amount:amount successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        NSLog(@"支付成功");
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


//拉起支付宝支付
-(void)alipayWithModel:(JMOrderPaymentModel *)model{
    [self payMoneyRequestWithNo:model.serial_no amount:@"130"];

//    // 发起支付
    [[AlipaySDK defaultService] payOrder:model.alipay fromScheme:@"alisdkdemo" callback:^(NSDictionary *resultDic) {
        NSLog(@"支付结果 reslut = %@",resultDic);
    }];
    
}

-(void)setCurrentIndex{
    switch (_index) {
        case 0:
            //待处理
            self.currentStatusArray = @[Task_WaitDealWith];
            break;
        case 1:
            //进行中
            self.currentStatusArray = @[Task_Pass,Task_Finish];
            
            break;
        case 2:
            //已结束
            self.currentStatusArray = @[Task_Refuse,Task_DidComfirm];
            
            break;
            
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
    [self getDataWitnStatus:self.currentStatusArray];
    
    
}

#pragma mark -- 微信分享的是链接
- (void)wxShare:(int)n data1:(JMTaskOrderListCellData *)data1
{   //检测是否安装微信
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc]init];
    sendReq.bText = NO; //不使用文本信息
    sendReq.scene = n;  //0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = data1.goodsTitle;
    urlMessage.description = data1.goodsDescription;
    
    if (data1.snapshot_images.count > 0) {
        NSString *url;
        for (int i = 0; i < data1.snapshot_images.count; i++) {
            JMTaskOrderImageModel *imgModel = data1.snapshot_images[0];
            url = imgModel.file_path;
        }
        UIImage *image = [self getImageFromURL:url];
        //缩略图,压缩图片,不超过 32 KB
        NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
        [urlMessage setThumbData:thumbData];
        
    }else{
        UIImage *image = [UIImage imageNamed:@"demi_home"];

        NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
        [urlMessage setThumbData:thumbData];
        
    }
 
    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = data1.share_url;
    
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
    NSLog(@"share WX");
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
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
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    JMTaskOrderListCellData *data = self.listsArray[indexPath.row];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        //去个人兼职简历
//        JMBDetailWebViewController *vc =
        [self getTaskAbilityIDInfoWithUser_id:data.user_user_id type_label_id:data.snapshot_type_label_id];
    }else{
        //去快照
        
        [self getTaskInfoDataWithTask_order_id:data.task_order_id];
        
    }
//    JMBDetailWebViewController *vc = [[JMBDetailWebViewController alloc]init];
//    vc.ability_id = data.ability_id;
//    [self.navigationController pushViewController:vc animated:YES];
//    JMSnapshotWebViewController *vc = [[JMSnapshotWebViewController alloc]init];
//    vc.data = data;
//    [self.navigationController pushViewController:vc animated:YES];
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



#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"待通过", @"进行中", @"已结束"]];
        _titleView.viewType = JMTitlesViewDefault;
        [_titleView setCurrentTitleIndex:_index];
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
        [_choosePayView.btn1 setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
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
