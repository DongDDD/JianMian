//
//  JMCTypeSaleDetailViewController.m
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMCTypeSaleDetailViewController.h"
#import "JMTaskDetailHeaderView.h"
#import "JMTitlesView.h"
#import "JMTaskDetailHeaderTableViewCell.h"
#import "JMCTypeSaleCellConfigures.h"
#import "JMHTTPManager+FectchTaskInfo.h"
#import "JMHTTPManager+FectchCommentInfo.h"
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"
#import "JMHTTPManager+CreateConversation.h"
#import "JMMessageListModel.h"
#import "JMChatViewController.h"
#import "WXApi.h"
#import "JMTaskApplyForView.h"
#import "JMShareView.h"
#import "JMHTTPManager+CreateTaskOrder.h"
#import "JMHTTPManager+CompanyLike.h"
#import "JMCompanyDetailViewController.h"
#import "JMPostPartTimeResumeViewController.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMHTTPManager+UpdateTask.h"
#import "JMBUserPostSaleJobViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"
#import "JMHTTPManager+DeleteTask.h"
#import "JMSendCustumMsg.h"//发送自定义消息
#import "JMCreatChatAction.h"//创建聊天
#import "JMGoodsDetailViewController.h"

@interface JMCTypeSaleDetailViewController ()<UITableViewDelegate,UITableViewDataSource,JMShareViewDelegate,JMTaskApplyForViewDelegate,JMCSaleTypeDetailGoodsTableViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;

//@property (nonatomic, strong) UIView *headerTitleView;
@property (nonatomic, strong) JMTaskDetailHeaderView *taskDetailHeaderView;

@property (nonatomic, strong) JMTitlesView *titleView;
@property (assign, nonatomic) NSUInteger index;
@property (nonatomic, strong) JMCTypeSaleCellConfigures *configures;
@property (copy, nonatomic) NSString *user_id;
@property (nonatomic, strong) UIView *windowViewBGView;
@property (nonatomic, strong) JMTaskApplyForView *taskApplyForView;
@property (nonatomic, strong) JMShareView *shareView;
@property (nonatomic ,strong) UIView *BGShareView;
@end

@implementation JMCTypeSaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
    [self upDateUserData];
}

-(void)initView{
    //    [self.view addSubview:self.taskDetailHeaderView];
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.BGShareView];
    [self.view addSubview:self.shareView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
    }];
    [self initTaskApplyForView];
//    [self.BGShareView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.view);
//        make.left.and.right.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view);
//    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenChoosePayView)];
    [self.BGShareView addGestureRecognizer:tap];

}
-(void)initTaskApplyForView{
    [[UIApplication sharedApplication].keyWindow addSubview:self.windowViewBGView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.taskApplyForView];
    [self.taskApplyForView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.width.mas_equalTo(330);
        make.height.mas_equalTo(250);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenApplyForView)];
    [self.windowViewBGView addGestureRecognizer:tap];
    
    
}
#pragma mark -- Data

-(void)getData{
    [self showProgressHUD_view:self.view];
    [[JMHTTPManager sharedInstance]fectchTaskInfo_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.model = [JMCDetailModel mj_objectWithKeyValues:responsObject[@"data"]];
            if (self.viewType == CTypeSaleViewDefaultType) {
                //过滤
                NSMutableArray *imgArr = [NSMutableArray array];
                for (JMCDetailImageModel *imgModel in self.configures.model.images) {
                    if ([imgModel.status isEqualToString:@"2"]) {
                        [imgArr addObject:imgModel];
                    }
                }
                 
                self.configures.model.images = imgArr.mutableCopy;
            }

//            self.haveApply.text = [NSString stringWithFormat:@"%@人已报名", self.configures.model.effective_count];
                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
//
//            }
            if (_viewType == CTypeSaleViewPreviewType) {
                [self initView];
                [self setRightBtnImageViewName:@"jobDetailShare" imageNameRight2:@"Bdelete"];
                [self.tableView reloadData];

            }else  if (_viewType == CTypeSaleViewDefaultType) {
                [self setRightBtnImageViewName:@"collect" imageNameRight2:@"jobDetailShare"];
                [self getCommentInfo];
            
            }
            
            if (_viewType == CTypeSaleViewPreviewType) {
                if ([self.configures.model.status isEqualToString:Position_Online]) {
//                    [self.bottomLeftBtn setTitle:@"任务下线" forState:UIControlStateNormal];
//                    [self.bottomRightBtn setTitle:@"编辑任务" forState:UIControlStateNormal];
                    
                }else if (([self.configures.model.status isEqualToString:Position_Downline])) {
//                    [self.bottomLeftBtn setTitle:@"编辑任务" forState:UIControlStateNormal];
//                    [self.bottomRightBtn setTitle:@"重新发布" forState:UIControlStateNormal];
                    
                }
            }else if (_viewType == CTypeSaleViewDefaultType) {
//                [self.bottomLeftBtn setTitle:@"咨询雇主" forState:UIControlStateNormal];
//                [self.bottomRightBtn setTitle:@"立即申请" forState:UIControlStateNormal];
            }
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
-(void)getCommentInfo{
    [[JMHTTPManager sharedInstance]fectchCommentInfoWithTask_order_id:nil order_id:nil user_id:nil company_id:self.configures.model.user_company_id page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.configures.commentListArray = [JMCommentCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self initView];
            [self.tableView reloadData];
            [self hiddenHUD];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}


//申请职位
-(void)sendResquest{

        [[JMHTTPManager sharedInstance]createTaskOrder_taskID:self.task_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
            //            [self showAlertSimpleTips:@"提示" message:@"申请成功" btnTitle:@"好的"];
            [self showAlertVCSucceesSingleWithMessage:@"申请已发出" btnTitle:@"好的"];
            //创建自定义消息
            [self createChatToSendCustumMessageRequstWithForeign_key:self.task_id user_id:self.configures.model.user_id];
            //            [self setTaskMessage_receiverID:receiverId dic:nil title:@"任务提醒"];
            
            
        } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
            
        }];
}

//申请任务后的创建聊天，用来发送自定义消息
-(void)createChatToSendCustumMessageRequstWithForeign_key:(NSString *)foreign_key user_id:(NSString *)user_id{
    
    [[JMHTTPManager sharedInstance]createChat_type:@"2" recipient:user_id foreign_key:foreign_key sender_mark:@"" recipient_mark:@"" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        //        JMMessageListModel *messageListModel = [JMMessageListModel mj_objectWithKeyValues:responsObject[@"data"]];
        //
        NSString *receiverId = [NSString stringWithFormat:@"%@b",_user_id];
        [JMSendCustumMsg setCustumMessage_receiverID:receiverId dic:nil title:@"[任务申请]"];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}


//更新任务上下线
-(void)updateTaskStatusRequestWithStatus:(NSString *)status{
    [[JMHTTPManager sharedInstance]updateTaskWithId:self.task_id payment_method:nil unit:nil payment_money:nil front_money:nil quantity_max:nil myDescription:nil industry_arr:nil city_id:nil longitude:nil latitude:nil address:nil goods_title:nil goods_price:nil goods_desc:nil video_path:nil video_cover:nil image_arr:nil   ids:nil  sorts:nil  is_invoice:nil invoice_title:nil invoice_tax_number:nil invoice_email:nil status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        NSString *title;
        if ([status isEqualToString:Position_Downline]) {
            title  = @"已下线";
        }else if ([status isEqualToString:Position_Online]) {
            title  = @"已上线";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.configures numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.configures heightForRowsInSection:indexPath.section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.configures heightForFooterInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.configures heightForHeaderInSection:section];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.titleView;
    }
 
    return [UIView new];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == JMCTypeSaleCellTypeHeader) {
        JMTaskDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTaskDetailHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setModel:self.configures.model];
        return cell;
    }else if (indexPath.section == JMCTypeSaleCellTypeTaskDesc1){
        JMCDetailTaskDecriTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailTaskDecriTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;
    }else if (indexPath.section == JMCTypeSaleCellTypeTaskDesc2){
        JMCDetailTaskDecri2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCDetailDecri2TableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setModel:self.configures.model];
        return cell;
    }else if (indexPath.section == JMCTypeSaleCellTypeMyStoreHeader){
        JMCSaleTypeDetailStoreHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setModel:self.configures.model];
        return cell;
    }else if (indexPath.section == JMCTypeSaleCellTypeMyStoreGoods){
        JMCSaleTypeDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setModel:self.configures.model];
        return cell;
    }
    
    return nil;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//  return  se
//
//}

-(void)showPageContentView{
    switch (_index) {
        case 0:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        case 1:
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        default:
            break;
    }

}
#pragma mark - delegate
-(void)didSelectedGoodsItemsWithModel:(JMCDetailModel *)model{
    JMGoodsDetailViewController *vc = [[JMGoodsDetailViewController alloc]init];
    vc.title = @"产品详情";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy
- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"任务描述", @"信誉评价"]];
        __weak JMCTypeSaleDetailViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    } 
    return _titleView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
//        _tableView.sectionHeaderHeight = 1;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
//                _tableView.sectionFooterHeight = 5;
        [_tableView registerNib:[UINib nibWithNibName:@"JMTaskDetailHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMTaskDetailHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecriTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecriTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecri2TableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailDecri2TableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailVideoTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailVideoTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailImageTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailImageTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailCommentTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailCommentTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCSaleTypeDetailStoreHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCSaleTypeDetailGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:JMCSaleTypeDetailGoodsTableViewCellIdentifier];

//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailProduceTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailProduceTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMapTableViewCell" bundle:nil] forCellReuseIdentifier:JMMapTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMNoDataTableViewCell" bundle:nil] forCellReuseIdentifier:JMNoDataTableViewCellIdentifier];

        
    }
    return _tableView;
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

-(JMCTypeSaleCellConfigures *)configures{
    if (!_configures) {
        _configures = [[JMCTypeSaleCellConfigures alloc]init];
    }
    return _configures;
}

-(JMTaskApplyForView *)taskApplyForView{
    if (!_taskApplyForView) {
        _taskApplyForView = [[JMTaskApplyForView alloc]init];
        _taskApplyForView.layer.cornerRadius = 10;
        [_taskApplyForView setHidden:YES];
        _taskApplyForView.delegate = self;
    }
    return _taskApplyForView;
}


-(UIView *)windowViewBGView{
    if (!_windowViewBGView) {
        _windowViewBGView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _windowViewBGView.backgroundColor = [UIColor blackColor];
        [_windowViewBGView setHidden:YES];
        _windowViewBGView.alpha = 0.3;
    }
    return _windowViewBGView;
}
-(UIView *)BGShareView{
    if (!_BGShareView) {
        _BGShareView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
        _BGShareView.backgroundColor = [UIColor blackColor];
        _BGShareView.alpha = 0.5;
        _BGShareView.hidden = YES;
    }
    return  _BGShareView;
    
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
