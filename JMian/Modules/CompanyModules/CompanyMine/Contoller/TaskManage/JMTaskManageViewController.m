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
#import "JMHTTPManager+OrderPay.h"
#import "JMOrderPaymentModel.h"
#import "JMShareView.h"
#import "JMSnapshotWebViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"
#import "JMHTTPManager+PayMoney.h"
#import "JMPayDetailViewController.h"
#import "JMPaySucceedViewController.h"
#import "JMPayFailedViewController.h"
#import "JMHTTPManager+FectchTaskOrderInfo.h"
#import "JMBDetailWebViewController.h"
#import "JMHTTPManager+FectchTaskAbility.h"
#import "JMHTTPManager+UnReadNotice.h"
#import "JMBDetailViewController.h"
#import "JMMyShareView.h"
//#import <PassKit/PassKit.h>                                 //用户绑定的银行卡信息
//#import <PassKit/PKPaymentAuthorizationViewController.h>    //Apple pay的展示控件
//#import <AddressBook/AddressBook.h>                         //用户联系信息相关


@interface JMTaskManageViewController ()<UITableViewDelegate,UITableViewDataSource,JMTaskManageTableViewCellDelegate,JMTaskCommetViewControllerDelegate,JMShareViewDelegate,JMPayDetailViewControllerDelegate,JMMyShareViewDelegate>
{
    NSMutableArray *summaryItems;
    NSMutableArray *shippingMethods;
}
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) JMMyTitleView *titleView;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSMutableArray *listsArray;
@property (strong, nonatomic) JMShareView *choosePayView;
@property (strong, nonatomic) JMShareView *shareView;
@property (strong, nonatomic) JMMyShareView *myShareView;


@property (strong, nonatomic) JMOrderPaymentModel *orderPaymentModel;
@property (strong, nonatomic) NSString *didPayMoney;
@property (strong, nonatomic) JMTaskOrderListCellData *nowTaskData;

@property (nonatomic ,strong) UIView *BGPayView;

@property (strong, nonatomic)NSArray *currentStatusArray;
@property (copy, nonatomic)NSString *task_order_id;
@property (copy, nonatomic)NSString *user_id;
@property (copy, nonatomic)NSString *receiver_id;

@property (assign, nonatomic)NSInteger per_page;
@property (assign, nonatomic)NSInteger page;

@end

@implementation JMTaskManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.per_page = 10;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        self.title = @"任务管理";
    }else{
        self.title = @"我的任务";
    }
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
    [self.view addSubview:self.BGPayView];
    [self.view addSubview:self.choosePayView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.myShareView];
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
    [self.myShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.left.and.right.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.top.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
    [self.myShareView setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGPayView addGestureRecognizer:tap];
    [self setupHeaderRefresh];
    [self setupFooterRefresh];
    
}



#pragma mark - myDelegate
-(void)paySucceedNotification{
    
    [self.choosePayView setHidden:YES];
    [self.BGPayView setHidden:YES];
    if (_index == 0) {
        
    }else{
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
    
    
    
    [self.tableView.mj_header beginRefreshing];
    
}

//底部左面的按钮事件
-(void)leftActionWithData:(JMTaskOrderListCellData *)data{
    _nowTaskData = data;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        _receiver_id = [NSString stringWithFormat:@"%@a",data.user_user_id];

        if ([data.status isEqualToString:Task_WaitDealWith]) {
            //B拒绝
            [self changeTaskStatusRequestWithStatus:Task_Refuse task_order_id:data.task_order_id];
        }else if ([data.status isEqualToString:Task_Finish]) {
            //B：C任务已完成 和C聊聊
            
            [self createChatJudge];
        }else if ([data.status isEqualToString:Task_Pass]) {
            //B：销售任务进行中 和C聊聊
//            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            [self createChatJudge];
      
        }else if ([data.status isEqualToString:Task_Finish]) {
            //B：普通任务进行中 和C聊聊
            //            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            [self createChatJudge];
            
        }
    }else if ([userModel.type isEqualToString:C_Type_USER]){
        _receiver_id = [NSString stringWithFormat:@"%@a",data.user_user_id];
        [self createChatJudge];
    }
}

//底部右面的按钮事件
-(void)rightActionWithData:(JMTaskOrderListCellData *)data{
    _nowTaskData = data;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//==========《〈《==B端==》〉》========================================

    if ([userModel.type isEqualToString:B_Type_UESR]) {
        _receiver_id = [NSString stringWithFormat:@"%@a",data.user_user_id];
//B端=============待通过=================================

        //B现在状态：待处理or待通过
        if ([data.status isEqualToString:Task_WaitDealWith]) {
            
            //B改状态------B端通过任务申请&&支付定金
            if ([data.payment_method isEqualToString:@"3"]) {
//                JMVersionModel *versionModel = [JMVersionManager getVersoinInfo];
//                if ([versionModel.test isEqualToString:@"1"]) {
//                    //TEST直接通过
//                    _task_order_id = data.task_order_id;
//                    _user_id = data.user_user_id;
//                    [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
//                }else{
                
                    if ([data.front_money isEqualToString:@"0"]) {
                        //无定金直接通过
                        _task_order_id = data.task_order_id;
                        _user_id = data.user_user_id;
                        [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
//                        [self applePay];
                        
                    }else{
                        //有定金跳支付界面
                        JMPayDetailViewController *vc = [[JMPayDetailViewController alloc]init];
                        vc.data = data;
                        vc.delegate = self;
                        vc.viewType = JMPayDetailViewTypeDownPayment;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                    
//                }
                
           //B改状态------B端通过网络销售任务，直接改状态
            }else if ([data.payment_method isEqualToString:@"1"]){
                
                _task_order_id = data.task_order_id;
                _user_id = data.user_user_id;
                [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
                
            }
            return;
//B端=============进行中=================================

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
            //B---销售分成任务的 结束任务
            if ([data.payment_method isEqualToString:@"1"]){
                //销售任务和他聊聊
//                [self getGoodsUrlToShareDataWithTask_order_id:data.task_order_id];
//                self createChatRequstWithTask_order_id:data.snapshot_type_label_id user_id:<#(NSString *)#>
                //B结束销售任务
                [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            }
            return;
//B端=============已结束=================================

        }else if ([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_boss isEqualToString:@"0"]) {
            //B——创建评价
            JMTaskCommetViewController *vc = [[JMTaskCommetViewController alloc]init];
            [vc setData:data];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
            return;
        }
//=================《〈===C端===》〉========================

    }else if ([userModel.type isEqualToString:C_Type_USER]) {
        _receiver_id = [NSString stringWithFormat:@"%@b",data.boss_user_id];
        //C----进行中----
        if ([data.status isEqualToString:Task_Pass]) {
            if (![data.payment_method isEqualToString:@"1"]) {//不是销售分成才有这操作
                //C---点"已完成"（C 唯一操作）-----status change to  '3'
                [self changeTaskStatusRequestWithStatus:Task_Finish task_order_id:data.task_order_id];
                return;
            }else{
                NSLog(@"分享");
                [self.myShareView setHidden:NO];
                self.task_order_id = data.task_order_id;
//                [self getGoodsUrlToShareDataWithTask_order_id:data.task_order_id];

            }
        }else if ([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_user isEqualToString:@"0"]){
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


-(void)showShareView{
    [self.shareView setHidden:NO];
    [self.BGPayView setHidden:NO];
    
    [UIView animateWithDuration:0.18 animations:^{
        self.shareView.frame =CGRectMake(0, self.view.frame.size.height-205, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
    }];
   
}



-(void)hiddenChoosePayView{
    [self.choosePayView setHidden:YES];
    [self.BGPayView setHidden:YES];
    [UIView animateWithDuration:0.18 animations:^{
        self.choosePayView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
    }];
    [UIView animateWithDuration:0.18 animations:^{
        self.shareView.frame =CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight);
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

//APPLE支付
-(void)shareViewRightAction{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if ([model.email isEqualToString:@"379247111@qq.com"]) {
        //支付宝支付
        //    [self alipayWithModel:self.orderPaymentModel];
        if (![self.didPayMoney isEqualToString:@"0"]) {
//            [self applePay];
            
        }else{
            [self hiddenChoosePayView];
        }

    }else{
        [self hiddenChoosePayView];
        
    }
}


-(void)myShareWechat1{
    [self.myShareView setHidden:YES];
    //分享朋友列表
    [self getGoodsUrlToShareDataWithTask_order_id:self.task_order_id wxShare:0];
}

-(void)myShareWechat2{
    [self.myShareView setHidden:YES];
    //分享朋友圈
    [self getGoodsUrlToShareDataWithTask_order_id:self.task_order_id wxShare:1];

}

-(void)myShareDeleteAction{
    [self.myShareView setHidden:YES];


}
//和他聊聊
-(void)iconAlertRightAction{
    [self createChatJudge];

    
}


//已评价回调
-(void)didComment{
    [self.tableView.mj_header beginRefreshing];
}




#pragma mark - PKPaymentAuthorizationViewControllerDelegate

//只要下面的

//- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
//                       didAuthorizePayment:(PKPayment *)payment
//                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion {
//
//    PKPaymentToken *payToken = payment.token;
//    //支付凭据，发给服务端进行验证支付是否真实有效
//    PKContact *billingContact = payment.billingContact;     //账单信息
//    PKContact *shippingContact = payment.shippingContact;   //送货信息
//    PKContact *shippingMethod = payment.shippingMethod;     //送货方式
//    //等待服务器返回结果后再进行系统block调用
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //模拟服务器通信
//        completion(PKPaymentAuthorizationStatusSuccess);
////        [self paySucceedNotification];
//        NSLog(@"paymentAuthorizationSucceed");
//        if (_index == 0) {
//            [self hiddenChoosePayView];
////            [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:_nowTaskData.task_order_id];
//        }else if (_index == 1){
//            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:_nowTaskData.task_order_id];
//
//        }
//    });
//
//
//}
//
//-(void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller{
//    [controller dismissViewControllerAnimated:YES completion:nil];
////    [self paySucceedNotification];
//    NSLog(@"payEnd");
//
//}

#pragma mark - 数据请求

-(void)getDataWitnStatus:(NSArray *)status{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchTaskList_status:status page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *newArray =[NSMutableArray array];
           newArray = [JMTaskOrderListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            if (newArray.count > 0) {
                [self.listsArray addObjectsFromArray:newArray];
                [self.tableView.mj_footer setHidden:NO];

            }else{
                [self.tableView.mj_footer setHidden:YES];
            }
            
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}

//C端获得任务信息去快照
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

//B端获得ability_id去C端个人兼职简历
-(void)getTaskAbilityIDInfoWithUser_id:(NSString *)user_id type_label_id:(NSString *)type_label_id {
    
    [[JMHTTPManager sharedInstance]fetchTaskAbilityWithUser_id:user_id type_label_id:type_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSString *ability_id = responsObject[@"data"][@"ability_id"];
            JMBDetailViewController *vc = [[JMBDetailViewController alloc]init];
            vc.ability_id = ability_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


//用于B端获取兼职简历ID创建聊天
-(void)getTaskAbilityIDToChatWithUser_id:(NSString *)user_id  type_label_id:(NSString *)type_label_id {
    [[JMHTTPManager sharedInstance]fetchTaskAbilityWithUser_id:user_id type_label_id:type_label_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSString *ability_id = responsObject[@"data"][@"ability_id"];
            [self createChatRequestWithForeign_key:ability_id user_id:_nowTaskData.user_user_id];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

-(void)getGoodsUrlToShareDataWithTask_order_id:(NSString *)task_order_id wxShare:(int)wxShare{
    [[JMHTTPManager sharedInstance]fectchTaskOrderInfo_taskID:task_order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            JMTaskOrderListCellData *taskInfoData = [JMTaskOrderListCellData mj_objectWithKeyValues:responsObject[@"data"]];
            
            if([WXApi isWXAppInstalled])
            {
                [self wxShare:wxShare data1:taskInfoData];
            }
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
    [self.listsArray removeAllObjects];
    self.page = 1;
    [self getDataWitnStatus:self.currentStatusArray];
    
}

//上拉更多
-(void)loadMoreBills{
    self.page += 1;
    [self getDataWitnStatus:self.currentStatusArray];
    
}

//改变任务状态
-(void)changeTaskStatusRequestWithStatus:(NSString *)status task_order_id:(NSString *)task_order_id {
    
    [[JMHTTPManager sharedInstance]changeTaskOrderStatusWithTask_order_id:task_order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {        
        [self.tableView.mj_header beginRefreshing];
        if ([status isEqualToString:Task_Pass]) {//
            [self showAlertVCWithHeaderIcon:@"purchase_succeeds" message:@"审批通过\n 建议联系对方以便开始任务" leftTitle:@"确认" rightTitle:@"和他聊聊"];
            [self setTaskMessage_receiverID:_receiver_id dic:nil title:@"[任务发布者已通过任务申请]"];
        }else if ([status isEqualToString:Task_DidComfirm]) {
            [self setTaskMessage_receiverID:_receiver_id dic:nil title:@"[任务发布者已确认完成任务]"];
            
        }else if ([status isEqualToString:Task_Refuse]) {
            if ( _index == 0) {
                [self setTaskMessage_receiverID:_receiver_id dic:nil title:@"[任务发布者已拒绝任务申请]"];
            }else if ([_nowTaskData.payment_method isEqualToString:@"1"] && _index == 1){
                [self setTaskMessage_receiverID:_receiver_id dic:nil title:@"[任务发布者已结束销售任务]"];
            }
            
        }else if ([status isEqualToString:Task_Finish]) {
            //C 端唯一改状态操作
            [self setTaskMessage_receiverID:_receiver_id dic:nil title:@"[任务接受者已完成任务]"];
            
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

//B端用Ability_id创建聊天  C端用Task_id创建聊天
-(void)createChatJudge{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
//        foreign_key = _nowTaskData.
        //调用新接口，获得ability_id
        [self getTaskAbilityIDToChatWithUser_id:_nowTaskData.user_user_id type_label_id:_nowTaskData.snapshot_type_label_id];
        
    }else if ([userModel.type isEqualToString:C_Type_USER]){
        //task_id 创建聊天

        [self createChatRequestWithForeign_key:_nowTaskData.task_id user_id:_nowTaskData.boss_user_id];
    }
    
}



-(void)createChatRequestWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    //Chat_type：2 灵活就业
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        
        
        JMChatViewController *vc = [[JMChatViewController alloc]init];
        vc.myConvModel = messageListModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

//小程序推送消息用
//-(void)unReadNoticeRequestWithTitle:(NSString *)title{
//    NSString *receiver = self.receiver_id;
//
//    NSString *message = title;
//
//
//    [[JMHTTPManager sharedInstance]unreadNoticeCardWithUser_id:receiver message:message successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}

#pragma mark -  （自定义消息）

-(void)setTaskMessage_receiverID:(NSString *)receiverID dic:(NSDictionary *)dic title:(NSString *)title{
    
    TIMConversation *conv = [[TIMManager sharedInstance]
                             getConversation:(TIMConversationType)TIM_C2C
                             receiver:receiverID];
    
    // 转换为 NSData
    
    TIMCustomElem * custom_elem = [[TIMCustomElem alloc] init];
    //    [custom_elem setData:data];
    if (dic) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [custom_elem setData:data];
        
    }
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    [custom_elem setDesc:title];
    TIMMessage * msg = [[TIMMessage alloc] init];
    [msg addElem:custom_elem];
    [conv sendMessage:msg succ:^(){
        NSLog(@"SendMsg Succ");
//        [self unReadNoticeRequestWithTitle:title];
//        [self showAlertVCWithHeaderIcon:@"purchase_succeeds" message:@"申请成功" leftTitle:@"返回" rightTitle:@"查看任务"];
    }fail:^(int code, NSString * err) {
        NSLog(@"SendMsg Failed:%d->%@", code, err);
        
        
    }];
    
    
}
#pragma mark - 支付
/*
-(void)applePay{
    if (![PKPaymentAuthorizationViewController class]) {
        //PKPaymentAuthorizationViewController需iOS8.0以上支持
        NSLog(@"操作系统不支持ApplePay，请升级至9.0以上版本，且iPhone6以上设备才支持");
        return;
    }
    //检查当前设备是否可以支付
    if (![PKPaymentAuthorizationViewController canMakePayments]) {
        //支付需iOS9.0以上支持
        NSLog(@"设备不支持ApplePay，请升级至9.0以上版本，且iPhone6以上设备才支持");
        return;
    }
    //检查用户是否可进行某种卡的支付，是否支持Amex、MasterCard、Visa与银联四种卡，根据自己项目的需要进行检测
    NSArray *supportedNetworks = @[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard,PKPaymentNetworkVisa,PKPaymentNetworkChinaUnionPay];
    //    if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
    //        NSLog(@"没有绑定支付卡");
    //        return;
    //    }
    //设置币种、国家码及merchant标识符等基本信息
    PKPaymentRequest *payRequest = [[PKPaymentRequest alloc]init];
    payRequest.countryCode = @"CN";     //国家代码
    payRequest.currencyCode = @"CNY";       //RMB的币种代码
    payRequest.merchantIdentifier = @"merchant.ApplePayDemi";  //申请的merchantID
    payRequest.supportedNetworks = supportedNetworks;   //用户可进行支付的银行卡
    payRequest.merchantCapabilities = PKMerchantCapability3DS|PKMerchantCapabilityEMV;      //设置支持的交易处理协议，3DS必须支持，EMV为可选，目前国内的话还是使用两者吧
    //    payRequest.requiredBillingAddressFields = PKAddressFieldEmail;
    //如果需要邮寄账单可以选择进行设置，默认PKAddressFieldNone(不邮寄账单)
    //楼主感觉账单邮寄地址可以事先让用户选择是否需要，否则会增加客户的输入麻烦度，体验不好，
    payRequest.requiredShippingAddressFields = PKAddressFieldNone;
    //送货地址信息，这里设置需要地址和联系方式和姓名，如果需要进行设置，默认PKAddressFieldNone(没有送货地址)
    //设置两种配送方式
//    PKShippingMethod *freeShipping = [PKShippingMethod summaryItemWithLabel:@"包邮" amount:[NSDecimalNumber zero]];
//    freeShipping.identifier = @"freeshipping";
//    freeShipping.detail = @"6-8 天 送达";

//    PKShippingMethod *expressShipping = [PKShippingMethod summaryItemWithLabel:@"极速送达" amount:[NSDecimalNumber decimalNumberWithString:@"10.00"]];
//    expressShipping.identifier = @"expressshipping";
//    expressShipping.detail = @"2-3 小时 送达";
//    shippingMethods = [NSMutableArray arrayWithArray:@[freeShipping, expressShipping]];
    //shippingMethods为配送方式列表，类型是 NSMutableArray，这里设置成成员变量，在后续的代理回调中可以进行配送方式的调整。
//    payRequest.shippingMethods = shippingMethods;
//    NSString *str;
//    if (_index == 0) {
//        str = [NSString stringWithFormat:@"%@",_nowTaskData.front_money];
//
//    }else if (_index == 1) {
//        str = [NSString stringWithFormat:@"%@",_nowTaskData.payment_money];
//
//    }
    
    double pay = [self.didPayMoney doubleValue];
    NSLog(@"付款金额: %f",pay);
    NSDecimalNumber *subtotalAmount = [NSDecimalNumber decimalNumberWithMantissa:pay*100 exponent:-2 isNegative:NO];   //12.75
    PKPaymentSummaryItem *subtotal = [PKPaymentSummaryItem summaryItemWithLabel:@"金额" amount:subtotalAmount];

//    NSDecimalNumber *discountAmount = [NSDecimalNumber decimalNumberWithString:@"0"];      //-12.74
//    PKPaymentSummaryItem *discount = [PKPaymentSummaryItem summaryItemWithLabel:@"优惠折扣" amount:discountAmount];
//
//    NSDecimalNumber *methodsAmount = [NSDecimalNumber zero];
//    PKPaymentSummaryItem *methods = [PKPaymentSummaryItem summaryItemWithLabel:@"包邮" amount:methodsAmount];

    NSDecimalNumber *totalAmount = [NSDecimalNumber zero];
    totalAmount = [totalAmount decimalNumberByAdding:subtotalAmount];
//    totalAmount = [totalAmount decimalNumberByAdding:discountAmount];
//    totalAmount = [totalAmount decimalNumberByAdding:methodsAmount];
    PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:@"Demi" amount:totalAmount];  //最后这个是支付给谁

    summaryItems = [NSMutableArray arrayWithArray:@[subtotal,total]];
    //summaryItems为账单列表，类型是 NSMutableArray，这里设置成成员变量，在后续的代理回调中可以进行支付金额的调整。
    payRequest.paymentSummaryItems = summaryItems;
    //ApplePay控件
    PKPaymentAuthorizationViewController *view = [[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:payRequest];
    view.delegate = self;
    [self presentViewController:view animated:YES completion:nil];
}

*/

//支付确认界面
-(void)payDetailViewDownPayAction_data:(JMTaskOrderListCellData *)data{
//    _task_order_id = data.task_order_id;
//    _user_id = data.user_user_id;
    //B端支付定金
//    [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
    
    if (![data.front_money isEqualToString:@"0"]) {
        JMVersionModel *model = [JMVersionManager getVersoinInfo];
        if ([model.test isEqualToString:@"1"]) {
//            [self applePay];
        }else{
            [self payWithData:data mode:@"2"];
            
        }
        
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
    [[JMHTTPManager sharedInstance]fectchOrderPaymentInfoWithOrder_id:data.task_order_id scenes:@"app" type:@"1" mode:mode is_invoice:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
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
    [self hiddenChoosePayView];
    
//    [self payMoneyRequestWithNo:model.serial_no amount:@"130"];
    
    
}


//拉起支付
-(void)alipayWithModel:(JMOrderPaymentModel *)model{
//    [self payMoneyRequestWithNo:model.serial_no amount:@"130"];
  
//    // 发起支付
//    [[AlipaySDK defaultService] payOrder:model.alipay fromScheme:@"alisdkdemo" callback:^(NSDictionary *resultDic) {
//        NSLog(@"支付结果 reslut = %@",resultDic);
//    }];
    
}

-(void)setCurrentIndex{
    switch (_index) {
        case 0:
            //待处理
            self.currentStatusArray = [NSArray array];
            break;
        case 1:
            //进行中
            self.currentStatusArray = @[Task_WaitDealWith];

            
            break;
        case 2:
            //已结束
            self.currentStatusArray = @[Task_Pass,Task_Finish];
            
            break;
        case 3:
            //已结束
            self.currentStatusArray = @[Task_Refuse,Task_DidComfirm];
            
            break;
        default:
            break;
    }
    self.page = 0;
    [self.tableView.mj_header beginRefreshing];
    
    
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
        UIGraphicsBeginImageContext(CGSizeMake(150, 150));
        [image drawInRect:CGRectMake(0, 0, 150, 150)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //缩略图,压缩图片,不超过 32 KB
        NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
   
        [urlMessage setThumbData:thumbData];

    }else{
        UIImage *image = [UIImage imageNamed:@"demi_home"];
        NSData *thumbData = UIImageJPEGRepresentation(image, 0.25);
        [urlMessage setThumbData:thumbData];
        UIImage *image2 = [UIImage imageWithData: thumbData];


    }

    //分享实例
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = data1.share_url;

    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    //发送分享
    [WXApi sendReq:sendReq];
//    NSLog(@"share WX");
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}
//d打印图片大小
//- (void)calulateImageFileSize:(UIImage *)image {
//    NSData *data = UIImagePNGRepresentation(image);
//    if (!data) {
//        data = UIImageJPEGRepresentation(image, 1);//需要改成0.5才接近原图片大小，原因请看下文
//    }
//    double dataLength = [data length] * 1.0;
//    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
//    NSInteger index = 0;
//    while (dataLength > 1024) {
//        dataLength /= 1024.0;
//        index ++;
//    }
//    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
//
//}

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

- (JMMyTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[JMMyTitleView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全部",@"待处理", @"进行中", @"已结束"]];
//        _titleView.viewType = JMMyTitleViewTypeDefault;
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
        [_choosePayView.btn2 setImage:[UIImage imageNamed:@"pry"] forState:UIControlStateNormal];
        [_choosePayView.btn2 setHidden:YES];
        [_choosePayView.lab2 setHidden:YES];
        _choosePayView.lab1.text = @"微信支付";
        _choosePayView.lab2.text = @"Apple Pay (推荐)";
    }
    return _choosePayView;
}

-(JMShareView *)shareView{
    if (!_shareView) {
        _shareView = [[JMShareView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 205+SafeAreaBottomHeight)];
        _shareView.delegate = self;
        [_shareView.btn1 setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
        [_shareView.btn2 setImage:[UIImage imageNamed:@"Friendster"] forState:UIControlStateNormal];
        _shareView.lab1.text = @"微信分享";
        _shareView.lab2.text = @"朋友圈";
    }
    return _shareView;
}

-(JMMyShareView *)myShareView{
    if (!_myShareView) {
           _myShareView = [[JMMyShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
           _myShareView.delegate = self;

       }
       return _myShareView;

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

-(NSMutableArray *)listsArray{
    if (_listsArray.count == 0) {
        _listsArray = [NSMutableArray array];
    }
    return _listsArray;
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
