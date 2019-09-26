//
//  JMCompanyHomeViewController.m
//  JMian
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyHomeViewController.h"
#import "JMCompanyHomeTableViewCell.h"
#import "JMPersonDetailsViewController.h"
#import "JMHTTPManager+VitaPaginate.h"
#import "JMHTTPManager+PositionDesired.h"
#import "JMCompanyHomeModel.h"
#import "JMPlayerViewController.h"
#import "JMVideoPlayManager.h"
#import "JMLabsChooseViewController.h"
#import "JMChoosePositionTableViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHomeWorkModel.h"
#import "JMCityListViewController.h"
#import "JMVideoSingleViewController.h"
#import "JMLabChooseBottomView.h"
#import "JMHTTPManager+FectchSpecialInfo.h"
#import "JMSpecialModel.h"
#import "JMSpecialViewController.h"



@interface JMCompanyHomeViewController ()<UITableViewDelegate,UITableViewDataSource,JMCompanyHomeTableViewCellDelegate,JMLabsChooseViewControllerDelegate,JMChoosePositionTableViewControllerDelegate,JMCityListViewControllerDelegate,JMLabChooseBottomViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *arrDate;
@property(nonatomic,strong)NSMutableArray *playerArray;
@property (nonatomic, strong) JMChoosePositionTableViewController *choosePositionVC;
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;
@property (weak, nonatomic) IBOutlet UIButton *choosePositionBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseRequireBtn;
@property(nonatomic,strong)NSMutableArray *choosePositionArray;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)JMLabChooseBottomView *labChooseBottomView;
@property (weak, nonatomic) IBOutlet UIImageView *schoolImgView;
@property (nonatomic, strong)JMSpecialModel *specialModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;
@property (atomic, strong) NSURL *url;
// -----------筛选------------
@property(nonatomic,copy)NSString *job_label_id;
@property(nonatomic,copy)NSString *city_id;
@property(nonatomic,copy)NSString *education;
@property(nonatomic,copy)NSString *work_year_s;
@property(nonatomic,copy)NSString *work_year_e;
@property(nonatomic,copy)NSString *salary_min;
@property(nonatomic,copy)NSString *salary_max;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger per_page;

@end
static NSString *cellIdent = @"cellIdent";

@implementation JMCompanyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleViewImageViewName:@"demi_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"不限"];
//    [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];
//    [self setIsHiddenBackBtn:YES];
    [self setIsHiddenRightBtn:YES];
    self.view.backgroundColor = BG_COLOR;
    self.per_page = 10;
    self.page = 1;
//    [self getData];
    [self setTableView];
    [self initView];
    [self getSpecialInfo];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(schoolAction)];
    [self.schoolImgView addGestureRecognizer:tap];
    self.schoolImgView.userInteractionEnabled = YES;
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


#pragma mark - 获取数据
-(void)getCompanyHomeListData{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fetchVitaPaginateWith_city_id:self.city_id job_label_id:self.job_label_id education:self.education work_year_s:self.work_year_s work_year_e:self.work_year_e salary_min:self.salary_min salary_max:self.salary_max page:page per_page:per_page SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *modelArray = [JMCompanyHomeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            if (modelArray.count > 0) {
                
                [self.arrDate addObjectsFromArray:modelArray];
                //                [self getPlayerArray];
            }
            if (modelArray.count < 10) {
                [self.tableView.mj_footer setHidden:YES];
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];



}

//获取发布了的职位列表
-(void) getPositionListData{
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    model = [JMUserInfoManager getUserInfo];
    
    
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWith_city_ids:nil company_id:nil label_id:nil work_label_id:nil education:nil experience_min:nil experience_max:nil salary_min:nil salary_max:nil subway_names:nil status:model.status page:nil per_page:nil SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {

            self.choosePositionArray = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];

            if (self.choosePositionArray.count > 0) {
                self.tableView.hidden  = NO;

            }
            
            [self.choosePositionVC setChoosePositionArray:self.choosePositionArray];
            [self.choosePositionVC.tableView reloadData];
        }
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)getSpecialInfo{
    [[JMHTTPManager sharedInstance]getSpecialInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.specialModel =  [JMSpecialModel mj_objectWithKeyValues:responsObject[@"data"]];
            
            NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
            NSString *s_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",self.specialModel.s_date];
            NSString *e_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",self.specialModel.e_date];
            NSDate *s_Date= [self dateFromString:s_timeStr];
            NSDate *e_Date= [self dateFromString:e_timeStr];
            
            int s_result = [self compareOneDay:currentDate withAnotherDay:s_Date];
            int e_result = [self compareOneDay:currentDate withAnotherDay:e_Date];
            //s_Date < current < e_Date
            if (s_result == 1 && e_result == -1) {
                [self.schoolImgView sd_setImageWithURL:[NSURL URLWithString:self.specialModel.cover_path] placeholderImage:[UIImage imageNamed:@"break"]];
                self.constraintHeight.constant = 142;
            }else{
                self.constraintHeight.constant = 0;
            }
            
            
        }
        
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}


//弃用这个方法 太消耗性能
//
//-(void)getPlayerArray{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [[JMVideoPlayManager sharedInstance].B_User_playArray removeAllObjects];
//
//        for (JMCompanyHomeModel *model in self.arrDate) {
//            if (model.video_file_path) {
//                NSURL *url = [NSURL URLWithString:model.video_file_path];
//                //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//                AVPlayer *player = [AVPlayer playerWithURL:url];
//
//                [[JMVideoPlayManager sharedInstance].B_User_playArray addObject:player];
//            }else{
//                [[JMVideoPlayManager sharedInstance].B_User_playArray addObject:[NSNull null]];
//
//            }
//
//        }
//
//        self.playerArray = [JMVideoPlayManager sharedInstance].B_User_playArray;
//    });
//
//
//}
#pragma mark - 布局UI

-(void)setTableView{
    
    self.tableView = [[UITableView alloc]init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor = BG_COLOR;
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.schoolImgView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    [self setupHeaderRefresh];//添加下拉刷新
    [self setupFooterRefresh];//下拉加载更多

}

-(void)initView{
    [self.bgBtn setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
    [self.choosePositionVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.view addSubview:self.bgBtn];
    [self.view addSubview:self.labschooseVC.view];
    [self.view addSubview:self.choosePositionVC.view];
    [self.view addSubview:self.labChooseBottomView];
    [_labChooseBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labschooseVC.view.mas_bottom);
        make.height.mas_equalTo(37);
        make.left.right.mas_equalTo(self.view);
    }];
}



#pragma mark - 下拉刷新 -
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

//-(void)loadNewData
//{
//
//    [self getData];
//}

-(void)loadMoreBills
{
        self.page += 1;
        [self getCompanyHomeListData];
  
}
-(void)refreshData
{
    [self.arrDate removeAllObjects];
    _page = 1;
    [self getCompanyHomeListData];
    
}


#pragma mark - tableView DataSouce Delegate -
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrDate.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMCompanyHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[JMCompanyHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.delegate = self;
    if (self.arrDate.count > 0) {
        JMCompanyHomeModel *model = self.arrDate[indexPath.row];
        [cell setModel:model];
    }
//
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMPersonDetailsViewController *vc = [[JMPersonDetailsViewController alloc] init];
    if(self.arrDate.count > 0 ){
        JMCompanyHomeModel *model = self.arrDate[indexPath.row];
        vc.companyModel = model;
        
    }

    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 点击事件

-(void)fanhui{
    JMCityListViewController *vc = [[JMCityListViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didSelectedCity_id:(NSString *)city_id city_name:(nonnull NSString *)city_name{

    _city_id = city_id;
    [self setBackBtnImageViewName:@"site_Home" textName:city_name];
    self.arrDate = [NSMutableArray array];
    [self.tableView.mj_header beginRefreshing];
}

-(void)playAction_comcell:(JMCompanyHomeTableViewCell *)cell model:(JMCompanyHomeModel *)model{
    
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:model.video_file_path];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
    
}

- (IBAction)choosePositionAction:(UIButton *)sender {
    [self.chooseRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.choosePositionBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    [self.choosePositionVC.view setHidden:NO];
    [self.labschooseVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.bgBtn setHidden:NO];
    [self getPositionListData];
    
 
    //    self.choosePositionVC
}

- (IBAction)requireChooseAction:(UIButton *)sender {
    [self.chooseRequireBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    [self.choosePositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:NO];
    [self.choosePositionVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:NO];
    [self.bgBtn setHidden:NO];
 
}


-(void)bgBtnAction{
    [self.choosePositionVC.view setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [_bgBtn setHidden:YES];

}

//要求筛选
-(void)labChooseBottomLeftAction{
    self.arrDate = [NSMutableArray array];
    [self.labschooseVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [_bgBtn setHidden:YES];
    _page = 1;
    _city_id = nil;
    _work_year_e = nil;
    _work_year_s = nil;
    _job_label_id = nil;
    _education = nil;
    _salary_max = nil;
    _salary_min = nil;
    [self.tableView.mj_header beginRefreshing];
    [self.choosePositionBtn setTitle:@"选择职位" forState:UIControlStateNormal];
    
//    [self.labschooseVC.view setHidden:YES];
//    [_bgBtn setHidden:YES];
    
}

//确认
-(void)labChooseBottomRightAction
{
    self.arrDate = [NSMutableArray array];
    [self.labschooseVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [_bgBtn setHidden:YES];
    [self.tableView.mj_header beginRefreshing];

}

//职位选择
-(void)didSelectCellActionController:(JMChoosePositionTableViewController *)controller{
    [self.choosePositionVC.view setHidden:YES];
    [_bgBtn setHidden:YES];
    [self.arrDate removeAllObjects];
    self.job_label_id = controller.homeModel.work_label_id;
    [self.tableView.mj_header beginRefreshing];
    [self.choosePositionBtn setTitle:controller.homeModel.work_name forState:UIControlStateNormal];
    NSLog(@"work_label_name%@",controller.homeModel.work_name);
    NSLog(@"job_label_id%@",self.job_label_id);

}

//人才要求
-(void)didChooseLabsTitle_str:(NSString *)str index:(NSInteger)index{
    if ([str isEqualToString:@"最低学历"]) {
        NSString *strIndex = [NSString stringWithFormat:@"%ld",(long)index];
        self.education = strIndex;
   
        NSLog(@"学历---%@",self.education);
    }else if ([str isEqualToString:@"工作经验"]) {
        NSString *labStr = [self getArray_index:index];
        [self getExpWithLabStr:labStr];
    }else if ([str isEqualToString:@"薪资要求"]) {
//        [self getSalaryStr_index:index];
        if (index == 0) {
            self.salary_min = @"";
            self.salary_max = @"";
        }else{
            NSString *salaryStr = [self getSalaryStr_index:index];
            NSMutableArray *salaryArr = [self setSalaryRangeWithSalaryStr:salaryStr];
            self.salary_min = salaryArr[0];
            self.salary_max = salaryArr[1];
            
        }
    }
}


-(void)getExpWithLabStr:(NSString *)labStr{
    if ([labStr isEqualToString:@"应届生"]) {
        self.work_year_s = @"0";
        self.work_year_e = @"1";

    }else if ([labStr isEqualToString:@"1年"]) {
         self.work_year_s = @"1";
        self.work_year_e = @"2";
    }else if ([labStr isEqualToString:@"1～3年"]) {
        self.work_year_s = @"1";
        self.work_year_e = @"3";
        
    }else if ([labStr isEqualToString:@"3～5年"]) {
        self.work_year_s = @"3";
        self.work_year_e = @"5";
        
        
    }else if ([labStr isEqualToString:@"5～10年"]) {
        self.work_year_s = @"5";
        self.work_year_e = @"10";
        
        
    }else if ([labStr isEqualToString:@"10年以上"]) {
        self.work_year_s = @"10";
        self.work_year_e = @"30";
        
        
    }else if ([labStr isEqualToString:@"全部"]) {
        self.work_year_s = nil;
        self.work_year_e = nil;
        
        
    }
 

}



-(NSString *)getArray_index:(NSInteger )index
{
    NSArray *array;
  
    array = @[@"全部",@"应届生",@"1年",@"1～3年",@"3～5年",@"5～10年",@"10年以上"];

    
    
    return array[index];
    
}

-(NSString *)getSalaryStr_index:(NSInteger )index
{
    NSArray *array;
    
    array = @[@"",
              @"1k-2k",
              @"2k-4k",
              @"4k-6k",
              @"6k-8k",
              @"8k-10k",
              @"10k-15k",
              @"15k-20k",
              @"20k-30k",
              @"30k-40k",
              @"40k-50k",
              @"50k-100k"];
    
    
    
    return array[index];
    
}

-(void)schoolAction{
    NSLog(@"asdf");
    JMSpecialViewController *vc = [[JMSpecialViewController alloc]init];
    vc.title = self.specialModel.title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - lazy

-(NSMutableArray *)playerArray
{
    if (_playerArray == nil) {
        _playerArray = [NSMutableArray array];
    }
    return _playerArray;
}

-(JMChoosePositionTableViewController *)choosePositionVC{
    if (_choosePositionVC == nil) {
        _choosePositionVC = [[JMChoosePositionTableViewController alloc]init];
        _choosePositionVC.delegate = self;
        [self addChildViewController:_choosePositionVC];
        [self.view addSubview:_choosePositionVC.view];
//        _bgBtn = [[UIButton alloc]init];
//        _bgBtn.backgroundColor = [UIColor blackColor];
//        _bgBtn.alpha = 0.3;
//        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchDown];
//        [self.view addSubview:_bgBtn];
        [_choosePositionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-200);
        }];
        
//        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_choosePositionVC.view.mas_bottom);
//            make.left.and.right.mas_equalTo(_choosePositionVC.view);
//            make.bottom.mas_equalTo(self.view);
//        }];
    }
    return  _choosePositionVC;
    
}


-(UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc]init];
        _bgBtn.backgroundColor = [UIColor blackColor];
        _bgBtn.alpha = 0.3;
        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_bgBtn];
        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return _bgBtn;
}

-(JMLabsChooseViewController *)labschooseVC{
    if (_labschooseVC == nil) {
        _labschooseVC = [[JMLabsChooseViewController alloc]init];
        _labschooseVC.view.frame = CGRectMake(0, self.headerView.frame.origin.y+self.headerView.frame.size.height, SCREEN_WIDTH, self.view.frame.size.height);
        _labschooseVC.delegate = self;
        _labschooseVC.view.tag = 556;
        [self addChildViewController:_labschooseVC];
        [self.view addSubview:_labschooseVC.view];
        [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-150);
        }];
        
 
    }
    return  _labschooseVC;
    
}


-(JMLabChooseBottomView *)labChooseBottomView{
    if (!_labChooseBottomView) {
        _labChooseBottomView = [[JMLabChooseBottomView alloc]init];
        _labChooseBottomView.delegate = self;
    }
    return  _labChooseBottomView;
}

-(NSMutableArray *)arrDate{
    if (!_arrDate) {
        _arrDate = [NSMutableArray array];
    }
    return _arrDate;
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
