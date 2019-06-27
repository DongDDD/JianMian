//
//  JMManageInterviewViewController.m
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMManageInterviewViewController.h"
#import "JMMangerInterviewTableViewCell.h"
#import "JMHTTPManager+InterView.h"
#import "JMInterViewModel.h"
#import "JMChooseTimeViewController.h"
#import "THDatePickerView.h"
#import "JMVideoChatViewController.h"
#import "JMVideoChatView.h"
#import "JMFeedBackChooseViewController.h"
////面试状态
//#define Interview_WaitAgree @"0" //等待同意
//#define Interview_Delete @"1" //已取消
//#define Interview_Refuse @"2" //已拒绝
//#define Interview_WaitInterview @"3" //待面试 （已同意，等待面试）
//#define Interview_AlreadyInterview @"4" //未反馈
//#define Interview_Reflect @"5" //已反馈
@interface JMManageInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,JMMangerInterviewTableViewCellDelegate,JMChooseTimeViewControllerDelegate,JMVideoChatViewDelegate,JMFeedBackChooseViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSArray *listsArray;
@property (nonatomic ,strong)JMChooseTimeViewController * chooseTimeVC;
@property (nonatomic ,strong)JMInterViewModel *model;
@property (weak, nonatomic) IBOutlet UIButton *invitedBtn;
@property (weak, nonatomic) IBOutlet UIButton *isInterviewBtn;

@property (weak, nonatomic) THDatePickerView *dateView;
@property (strong, nonatomic) UIButton *BgBtn;//点击背景  隐藏时间选择器
@property (nonatomic, strong)NSArray *statusArray;
@property (nonatomic, strong)JMVideoChatView *videoChatView;
@end

static NSString *cellIdent = @"managerCellIdent";

@implementation JMManageInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"面试管理";
    [self setTableViewUI];
    [self initDatePickerView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self.navigationController setNavigationBarHidden:NO];

}

-(void)setTableViewUI{
    _statusArray = @[@"0",@"1",@"2",@"3"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 189;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMMangerInterviewTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadNewData
{
    [self getListData_Status:_statusArray];//请求已邀请的数据
}


-(void)getListData_Status:(NSArray *)status{
    [[JMHTTPManager sharedInstance]fetchInterViewListWithStatus:status page:@"1" per_page:@"7" successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            
            self.listsArray = [JMInterViewModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
        
    }];

}

#pragma mark - 点击事件
//已邀请
- (IBAction)invitedBtnAction:(UIButton *)sender {
    [self.invitedBtn setBackgroundColor:MASTER_COLOR];
    [self.invitedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.isInterviewBtn setBackgroundColor:[UIColor whiteColor]];
    [self.isInterviewBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    _statusArray = @[@"0",@"1",@"2",@"3"];
    [self.tableView.mj_header beginRefreshing];
//    [self getListData_Status:_statusArray];//请求已邀请的数据

}
//已面试
- (IBAction)isInterviewBtnAction:(UIButton *)sender {
    [self.isInterviewBtn setBackgroundColor:MASTER_COLOR];
    [self.isInterviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.invitedBtn setBackgroundColor:[UIColor whiteColor]];
    [self.invitedBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    _statusArray =  @[@"4",@"5"];
    [self.tableView.mj_header beginRefreshing];

//    [self getListData_Status:_statusArray];//请求已面试的数据
}


//代理点击事件
-(void)cellLeftBtnActionWith_model:(JMInterViewModel *)model
{
    //本地获取账户类型企业还是个人，再决定Cell的布局
    JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
    
    if ([userinfoModel.type isEqualToString:C_Type_USER]) {
        
        if ([model.status isEqualToString:Interview_WaitAgree]) {//接受邀约按钮
            [self updateInterviewStatus_interviewID:model.interview_id status:Interview_WaitInterview];
        }
        
    }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
     
        if ([model.hire isEqualToString:@"0"] && ([model.status isEqualToString:@"4"] || [model.status isEqualToString:@"5"])) {//修改时间
//            self.BgBtn.hidden = NO;
//
//            [UIView animateWithDuration:0.3 animations:^{
//                self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300,SCREEN_WIDTH, 300);
//                [self.dateView show];
//            }];
//            self.model = model;
//            0:未确定 1:不合适 2:已录用
            //确认录用
            [self updateInterviewHire_interviewID:model.interview_id label_ids:@[@"2"]];
        }
        
    }
    
}

-(void)cellRightBtnAction_model:(JMInterViewModel *)model isInterviewTime:(BOOL)isInterviewTime
{
    JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
    if ([userinfoModel.type isEqualToString:B_Type_UESR]) {
        if ([model.status isEqualToString:@"3"] && isInterviewTime) {//进入房间
            
            _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            _videoChatView.delegate = self;
            _videoChatView.tag = 222;
            [_videoChatView setInterviewModel:model];
            [self.view addSubview:_videoChatView];  
            [self.navigationController setNavigationBarHidden:YES];
            
        }else if ([model.status isEqualToString:@"0"]) {//这个状态可以 取消面试
            
            [self updateInterviewStatus_interviewID:model.interview_id status:@"2"];
            
        }else if ([model.hire isEqualToString:@"0"] && ([model.status isEqualToString:@"4"] || [model.status isEqualToString:@"5"])) {

            //0:未确定 1:不合适 2:已录用
            //不适合录用
            [self updateInterviewHire_interviewID:model.interview_id label_ids:@[@"1"]];
        }
        
    }else{
        if ([model.status isEqualToString:@"3"] && isInterviewTime){
            _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
            _videoChatView.delegate = self;
            _videoChatView.tag = 222;
//            [_videoChatView createChatRequstWithForeign_key:foreign_key recipient:recipient chatType:chatType];
            [_videoChatView setInterviewModel:model];
            [self.view addSubview:_videoChatView];
            [self.navigationController setNavigationBarHidden:YES];
////            candidate应聘者 interviewer面试官 Foreign_key关系主键 recipient接收者
//            if ([userinfoModel.type isEqualToString:B_Type_UESR]) {
//
//                [self gotoVideoChatViewWithForeign_key:model.interview_id recipient:model.candidate_user_id chatType:@"1"];
//            }else{
//                 [self gotoVideoChatViewWithForeign_key:model.interview_id recipient:model.interviewer_id chatType:@"1"];
//            }
        
        }else if ([model.status isEqualToString:@"0"]){
            //C残忍拒绝
            [self updateInterviewStatus_interviewID:model.interview_id status:@"2"];
   
        }
        
        
        if ([model.status isEqualToString:@"4"]) {//这个状态可以 面试反馈
            JMFeedBackChooseViewController *vc = [[JMFeedBackChooseViewController alloc]init];
            vc.viewType = JMFeedBackChooseViewDefault;
            vc.interview_id = model.interview_id;
//            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            //            [self updateInterviewStatus_interviewID:model.interview_id status:@"2"];
            
        }
    }
    
}

-(void)gotoVideoChatViewWithForeign_key:(NSString *)foreign_key
                              recipient:(NSString *)recipient
                               chatType:(NSString *)chatType{
    _videoChatView = [[JMVideoChatView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    _videoChatView.delegate = self;
    _videoChatView.tag = 222;
    [_videoChatView createChatRequstWithForeign_key:foreign_key recipient:recipient chatType:chatType];
    //    [_videoChatView setInterviewModel:nil];
    [self.view addSubview:_videoChatView];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)updateInterviewHire_interviewID:(NSString *)interviewID label_ids:(NSArray *)label_ids{
    [[JMHTTPManager sharedInstance]feedbackInterViewWith_interview_id:interviewID label_ids:label_ids successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
      
        [self.tableView.mj_header beginRefreshing];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    

}



-(void)updateInterviewStatus_interviewID:(NSString *)interviewID status:(NSString *)status{
    [[JMHTTPManager sharedInstance]updateInterViewWith_Id:interviewID status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已更新面试列表"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([status isEqualToString:@"4"] && [userModel.type isEqualToString:C_Type_USER]) {
            //C端在这个状态才可以去反馈
            JMFeedBackChooseViewController *vc = [[JMFeedBackChooseViewController alloc]init];
            vc.interview_id = interviewID;
            vc.viewType = JMFeedBackChooseViewDefault;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
        [self.tableView.mj_header beginRefreshing];
//        [self getListData_Status:_statusArray];//请求已邀请的数据
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}
//-(void)cellLeftBtnActionWith_row:(NSInteger)row{
//    self.chooseTimeVC = [[JMChooseTimeViewController alloc]init];
//    self.chooseTimeVC.delegate = self;
//    [self addChildViewController:self.chooseTimeVC];
//    [self.view addSubview:self.chooseTimeVC.view];
//    self.chooseTimeVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self.chooseTimeVC didMoveToParentViewController:self];
//
//    self.model = self.listsArray[row];
//
//}

//-(void)cellRightBtnAction_row:(NSInteger)row{
//
//    self.model = self.listsArray[row];
//    [[JMHTTPManager sharedInstance]updateInterViewWith_Id:self.model.interview_id status:Interview_Delete successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消面试成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//}

//修改面试时间
//时间选择器
-(void)initDatePickerView
{
    self.BgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    self.BgBtn.backgroundColor = [UIColor blackColor];
    self.BgBtn.hidden = YES;
    self.BgBtn.alpha = 0.3;
    [self.view addSubview:self.BgBtn];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, SCREEN_WIDTH, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    //    dateView.minuteInterval = 1;
    [self.view addSubview:dateView];
    self.dateView = dateView;
    
}
//显示时间选择器
-(void)bottomRightButtonAction{
    self.BgBtn.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];
    
    //    self.chooseTimeVC = [[JMChooseTimeViewController alloc]init];
    //    self.chooseTimeVC.delegate = self;
    //    [self addChildViewController:self.chooseTimeVC];
    //    [self.view addSubview:self.chooseTimeVC.view];
    //    self.chooseTimeVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //     [self.chooseTimeVC didMoveToParentViewController:self];
    //    NSLog(@"邀请面试");
    
}
#pragma mark - myDelegate

//-(void)didCommitActionWithInterview_id:(NSString *)interview_id{
//  
//    [self updateInterviewStatus_interviewID:interview_id status:@"5"];
//
//}

//挂断
-(void)hangupAction_model:(JMInterViewModel *)model{
    [_videoChatView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO];
    //挂断后改状态成 4
    [self updateInterviewStatus_interviewID:model.interview_id status:@"4"];
    
}

//-(void)hangupAction_model:
#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    //    self.timerLbl.text = timer;
    
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    
    
    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.model.user_job_id time:timer successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        [self getListData_Status:@"0"];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.BgBtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

//-(void)OKInteviewTimeViewAction:(NSString *)interviewTime{
//    [self.chooseTimeVC willMoveToParentViewController:nil];
//    [self.chooseTimeVC removeFromParentViewController];
//    [self.chooseTimeVC.view removeFromSuperview];
//    self.navigationController.navigationBarHidden = NO;
//    [[JMHTTPManager sharedInstance]createInterViewWith_user_job_id:self.model.user_job_id time:interviewTime successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邀请成功"
//                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
//        [alert show];
//
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//
//
//}

//-(void)deleteInteviewTimeViewAction{
//
//    [self.chooseTimeVC willMoveToParentViewController:nil];
//    [self.chooseTimeVC removeFromParentViewController];
//    [self.chooseTimeVC.view removeFromSuperview];
//
//    self.navigationController.navigationBarHidden = NO;
//}




#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMMangerInterviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[JMMangerInterviewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    JMInterViewModel *model = self.listsArray[indexPath.row];
    cell.delegate = self;
    cell.myRow = indexPath.row;
    [cell setModel:model];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    _model = self.listsArray[indexPath.row];

    
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
