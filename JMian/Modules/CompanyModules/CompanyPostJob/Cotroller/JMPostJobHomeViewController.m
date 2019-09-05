//
//  JMPostJobHomeViewController.m
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostJobHomeViewController.h"
//#import "JMTitlesView.h"
#import "JMPageView.h"
#import "JMPostNewJobViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHTTPManager+Login.h"
#import "JMIDCardIdentifyViewController.h"
#import "JMHomeWorkModel.h"
#import "JMPostJobHomeTableViewCell.h"
#import "JobDetailsViewController.h"
#import "JMPostTaskBottomView.h"

@interface JMPostJobHomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMPostJobHomeTableViewCellDelegate,JMPostTaskBottomViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *breakBGView;
//@property (nonatomic, strong) JMTitlesView *titleView;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;
@property (weak, nonatomic) IBOutlet UIButton *postOrIdentityBtn;
@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) JMPostTaskBottomView *postTaskBottomView;
@end

static NSString *cellIdent = @"cellIdent";


@implementation JMPostJobHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:@"职位管理"];
    _status = nil;
    
    [self setupDownRefresh];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.hidden = YES;
    self.breakBGView.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.postTaskBottomView];
    [self.postTaskBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.height.mas_equalTo(64);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.bottom.mas_equalTo(self.postTaskBottomView.mas_top);
        make.left.and.right.mas_equalTo(self.view);
    }];

}


- (IBAction)gotoIdentify:(UIButton *)sender {
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    model = [JMUserInfoManager getUserInfo];
   
    if ([model.card_status isEqualToString:@"0"]) {
        [self showAlertWithTitle:@"提示" message:@"请先进行实名认证" leftTitle:@"返回" rightTitle:@"去实名认证"];
        
        
        
    }else if ([model.card_status isEqualToString:@"3"]){
  
//        self.hidesBottomBarWhenPushed=YES;
        
        JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
//        self.hidesBottomBarWhenPushed=NO;
  
    }else if ([model.card_status isEqualToString:@"2"]){
        
        [self showAlertWithTitle:@"提示" message:@"实名认证不通过" leftTitle:@"返回" rightTitle:@"去实名认证"];
   
 
    }else if ([model.card_status isEqualToString:@"1"]) {
        [self showAlertSimpleTips:@"提示" message:@"实名认证审核" btnTitle:@"好的"];
    
    }
    
    
}

//-(void)alerLeftAction{
//}

-(void)alertRightAction{
    JMIDCardIdentifyViewController *vc = [[JMIDCardIdentifyViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];


}

-(void)rightAction{
    self.hidesBottomBarWhenPushed=YES;
    
    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    

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
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.delegate = self;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    JMHomeWorkModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JobDetailsViewController *vc = [[JobDetailsViewController alloc]init];
    JMHomeWorkModel *model = self.dataArray[indexPath.row];
    vc.homeworkModel = model;
    vc.status = model.status;
    vc.viewType = JobDetailsViewTypeEdit;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - myDelegate
-(void)didClickCopyActionWithHomeWorkModel:(JMHomeWorkModel *)homeWorkModel{
    
    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    vc.work_id = homeWorkModel.work_id;
    vc.viewType = JMPostNewJobViewTypeHistory;
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)didClickPostAction{
    JMPostNewJobViewController *vc = [[JMPostNewJobViewController alloc]init];
    vc.viewType = JMPostNewJobViewTypeDefault;
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - lazy

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 120.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        [self.tableView registerNib:[UINib nibWithNibName:@"JMPostJobHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
        
       
    }
    return _tableView;
    
}



-(JMPostTaskBottomView *)postTaskBottomView{
    if (!_postTaskBottomView) {
        _postTaskBottomView = [[JMPostTaskBottomView alloc]init];
        [_postTaskBottomView.postTaskBtn setTitle:@"发布职位" forState:UIControlStateNormal];
        _postTaskBottomView.delegate = self;
    }
    return _postTaskBottomView;
}

//-(JMPostTypeChooseView *)postTypeChooseView{
//    if (!_postTypeChooseView) {
//        _postTypeChooseView = [[JMPostTypeChooseView alloc]init];
//        _postTypeChooseView.delegate = self;
//    }
//    return _postTypeChooseView;
//}

//- (JMTitlesView *)titleView {
//    if (!_titleView) {
//        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"已发布", @"已下线"]];
//        __weak JMPostJobHomeViewController *weakSelf = self;
//
//        _titleView.didTitleClick = ^(NSInteger index) {
//            _index = index;
//            if (index==0) {
//                _status = Position_Online;//已发布职位
//            }else{
//                _status = Position_Downline;//已下线职位
//            }
//            [weakSelf getListData];
//        };
//
//    }
//    return _titleView;
//}
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
