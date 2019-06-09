//
//  JMPostJobHomeViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostJobHomeViewController.h"
#import "JMTitlesView.h"
#import "JMPageView.h"
#import "JMPostNewJobViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHTTPManager+Login.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMHomeWorkModel.h"
#import "JMPostJobHomeTableViewCell.h"
#import "JobDetailsViewController.h"


@interface JMPostJobHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *breakBGView;
@property (nonatomic, strong) JMTitlesView *titleView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (weak, nonatomic) IBOutlet UIButton *postOrIdentityBtn;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

static NSString *cellIdent = @"cellIdent";


@implementation JMPostJobHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    [self setTitle:@"职位管理"];
//    [self.view addSubview:self.progressHUD];
    _status = Position_Online;
    [self setupInit];
    [self setupDownRefresh];

//    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
//    model = [JMUserInfoManager getUserInfo];
//    if ([model.card_status isEqualToString:Card_PassIdentify]) {//“3”代表已通过实名认证，通过才能发布职位
//
//        [self getListData];
//        [self setRightBtnTextName:@"发布职位"];
//        self.tableView.hidden = YES;
//
//    }else if ([model.card_status isEqualToString:Card_NOIdentify]){
//
//        self.breakBGView.hidden = NO;
//        self.tableView.hidden = YES;
//    }
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.hidden = YES;
    self.breakBGView.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
//    [self jugdeCard_status];
    [self getUserStatus];

//    [self getUserInfo];
    

}

//-(void)jugdeCard_status{
//
//    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
//    model = [JMUserInfoManager getUserInfo];
//    if ([model.card_status isEqualToString:Card_PassIdentify]) {//“3”代表已通过实名认证，通过才能发布职位
//
//        [self getListData];
//        [self setRightBtnTextName:@"发布职位"];
//
//    }else if ([model.card_status isEqualToString:Card_NOIdentify]){
//
//        self.breakBGView.hidden = NO;
//    }
//    if (self.dataArray.count == 0) {
//        self.tableView.hidden = YES;
//
//    }
//
//
//}


-(void)getUserStatus{

    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        
        JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
        model = [JMUserInfoManager getUserInfo];
        
        if ([model.card_status isEqualToString:Card_PassIdentify]) {
            [self setRightBtnTextName:@"发布职位"];
            [self.tableView.mj_header beginRefreshing];
//            [self getListData];
          
        }else if ([model.card_status isEqualToString:Card_WaitIdentify]){
            
            self.breakBGView.hidden = NO;
            [self.postOrIdentityBtn setHidden:YES];

            self.tipsLab.text = @"实名认证审核中\n发布岗位需实名认证";

        }else if ([model.card_status isEqualToString:Card_NOIdentify]){
            [self.postOrIdentityBtn setTitle:@"去实名认证" forState:UIControlStateNormal];
            self.breakBGView.hidden = NO;
            self.tipsLab.text = @"你还没有实名认证 快去认证吧！\n发布岗位需实名认证";
 
        }else{
            if (self.dataArray.count == 0) {
                self.tableView.hidden = YES;
                
            }
            
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}


- (IBAction)gotoIdentify:(id)sender {
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    model = [JMUserInfoManager getUserInfo];
   
    if ([model.card_status isEqualToString:@"0"]) {
   
        JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];

  
    }else if ([model.card_status isEqualToString:@"3"]){
  
        self.hidesBottomBarWhenPushed=YES;
        
        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        self.hidesBottomBarWhenPushed=NO;
  
    }
    
    
}


-(void)rightAction{
    self.hidesBottomBarWhenPushed=YES;
    
    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    

}

- (void)setupInit {
    [self.view addSubview:self.titleView];

}
-(void)setupDownRefresh
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getListData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    
}
#pragma mark - 获取数据


-(void) getListData{
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWith_city_ids:nil company_id:nil label_id:nil work_label_id:nil education:nil experience_min:nil experience_max:nil salary_min:nil salary_max:nil subway_names:nil status:_status page:nil per_page:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
    
        if (responsObject[@"data"]) {
            
            self.dataArray = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            if (self.dataArray.count > 0) {
                self.tableView.hidden  = NO;

            }else{
            
                self.tipsLab.text = @"你还没有发布职位～\n快去发布吧！";
                self.breakBGView.hidden = NO;
                self.postOrIdentityBtn.hidden = NO;
                [self.postOrIdentityBtn setTitle:@"发布职位" forState:UIControlStateNormal];

            
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        }
  
      
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {

    }];

}


- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"已发布", @"已下线"]];
        __weak JMPostJobHomeViewController *weakSelf = self;
        
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            if (index==0) {
                _status = Position_Online;//已发布职位
                [weakSelf getListData];
            }else{
                _status = Position_Downline;//已下线职位
                [weakSelf getListData];
            }
        };
   
    }
    return _titleView;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //重用单元格
    JMPostJobHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[JMPostJobHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    JMHomeWorkModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JobDetailsViewController *vc = [[JobDetailsViewController alloc]init];
    vc.homeworkModel = self.dataArray[indexPath.row];
    vc.status = _status;
    vc.viewType = JobDetailsViewTypeEdit;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-200) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 78.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView registerNib:[UINib nibWithNibName:@"JMPostJobHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
    
}

//-(MBProgressHUD *)progressHUD{
//    if (!_progressHUD) {
//        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//        _progressHUD.progress = 0.6;
//        _progressHUD.dimBackground = NO; //设置有遮罩
//        [_progressHUD showAnimated:YES]; //显示进度框
//    }
//    return _progressHUD;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
