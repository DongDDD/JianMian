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

@interface JMManageInterviewViewController ()<UITableViewDelegate,UITableViewDataSource,JMMangerInterviewTableViewCellDelegate,JMChooseTimeViewControllerDelegate>

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

@end

static NSString *cellIdent = @"managerCellIdent";

@implementation JMManageInterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"面试管理";
    [self setTableViewUI];
    [self initDatePickerView];
    _statusArray = @[@"0",@"1",@"2",@"3"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}

-(void)setTableViewUI{

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

- (IBAction)invitedBtnAction:(UIButton *)sender {
    [self.invitedBtn setBackgroundColor:MASTER_COLOR];
    [self.invitedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.isInterviewBtn setBackgroundColor:[UIColor whiteColor]];
    [self.isInterviewBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self getListData_Status:_statusArray];//请求已邀请的数据

}

- (IBAction)isInterviewBtnAction:(UIButton *)sender {
    [self.isInterviewBtn setBackgroundColor:MASTER_COLOR];
    [self.isInterviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.invitedBtn setBackgroundColor:[UIColor whiteColor]];
    [self.invitedBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    NSArray *status = @[@"4",@"5"];
    [self getListData_Status:status];//请求已面试的数据

}


//代理点击事件
-(void)cellLeftBtnActionWith_model:(JMInterViewModel *)model
{
    //本地获取账户类型企业还是个人，再决定Cell的布局
    JMUserInfoModel *userinfoModel = [JMUserInfoManager getUserInfo];
    
    if ([userinfoModel.type isEqualToString:C_Type_USER]) {
        
        if ([model.status isEqualToString:Interview_WaitAgree]) {//接受邀约按钮
            
            [[JMHTTPManager sharedInstance]updateInterViewWith_Id:model.interview_id status:Interview_WaitInterview successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"接受面试成功"
                                                              delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [alert show];
                
                [self getListData_Status:_statusArray];//请求已邀请的数据
            } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
                
            }];
        }
        
    }else if ([userinfoModel.type isEqualToString:B_Type_UESR]){
     
        if ([model.status isEqualToString:Interview_WaitAgree]) {//修改时间
            self.BgBtn.hidden = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300,SCREEN_WIDTH, 300);
                [self.dateView show];
            }];
            self.model = model;
            
        }
        
    }
    
}

-(void)cellRightBtnAction_model:(JMInterViewModel *)model
{
    
    //因为B端和C端都只有这个status才有“进入房间”按钮，所以一个判断就可以了
        if ([model.status isEqualToString:Interview_WaitInterview]) {//进入房间
         
            JMVideoChatViewController *vc = [[JMVideoChatViewController alloc]init];
            vc.interviewModel = model;
            vc.videoChatViewType = JMJMVideoChatViewFromInterview;
            [self.navigationController pushViewController:vc animated:YES];
        }
    
    


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
