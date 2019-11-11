//
//  HomeViewController.m
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HometableViewCell.h"
#import "LoginViewController.h"
#import "JobDetailsViewController.h"
#import "JMHTTPManager+Work.h"
#import "JMHomeWorkModel.h"
#import "JMUserInfoModel.h"
#import "JMUserInfoManager.h"
#import "Masonry.h"
#import "JMLabsChooseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "JMVideoPlayManager.h"
#import "JMPlayerViewController.h"
#import "PositionDesiredViewController.h"
#import "JMCityListViewController.h"
#import "JMLabChooseBottomView.h"
#import "JMHTTPManager+FectchSpecialInfo.h"
#import "JMSpecialModel.h"
#import "JMSpecialViewController.h"
#import "SDCycleScrollView.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMLabsChooseViewControllerDelegate,HomeTableViewCellDelegate,PositionDesiredDelegate,JMCityListViewControllerDelegate,JMLabChooseBottomViewDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *allOfPositionBtn; //所有职位
@property (weak, nonatomic) IBOutlet UIButton *choosePositionBtn;//职位筛选
@property (weak, nonatomic) IBOutlet UIButton *companyRequireBtn;//公司要求

@property (nonatomic, strong) NSMutableArray *arrDate;
@property(nonatomic,copy)NSString *city_id;
@property(nonatomic,copy)NSString *work_lab_id;
@property(nonatomic,copy)NSString *education;
@property(nonatomic,copy)NSString *work_year_s;
@property(nonatomic,copy)NSString *work_year_e;
@property(nonatomic,copy)NSString *salary_min;
@property(nonatomic,copy)NSString *salary_max;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger per_page;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PositionDesiredViewController *choosePositionVC;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;
@property (nonatomic, strong) JMLabChooseBottomView *labChooseBottomView;
@property (nonatomic, strong) UIButton *bgBtn;

@property(nonatomic,strong)NSMutableArray *playerArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

//@property (nonatomic, copy)NSString *job_lab_id;
@property (weak, nonatomic) IBOutlet UIImageView *schoolImgView;
@property(nonatomic,strong)JMSpecialModel *specialModel;

@property(nonatomic,strong)SDCycleScrollView *SDCScrollView;

@property(nonatomic,strong)NSMutableArray *specialModelArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;

@end

static NSString *cellIdent = @"cellIdent";


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    [self setTitleViewImageViewName:@"demi_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"不限"];
    self.per_page = 10;
    self.page = 1;
    [self setTableView];
    [self initView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(schoolAction)];
//    [self.schoolImgView addGestureRecognizer:tap];
    self.schoolImgView.userInteractionEnabled = YES;
    [self getSpecialInfo];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - 布局UI

-(void)setTableView{
   
    self.tableView = [[UITableView alloc]init];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self getData];
//
//    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
//        make.bottom.mas_equalTo(self.view);
    }];
    // 马上进入刷新状态
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.schoolImgView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.view);
    }];
    
    MJRefreshNormalHeader *header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    [self setupUpRefresh];
}

-(void)initView{

    [self.bgBtn setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];

    [self.view addSubview:self.bgBtn];
    [self.view addSubview:self.labschooseVC.view];
    [self.view addSubview:self.labChooseBottomView];
    [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-150);
    }];
    [_labChooseBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labschooseVC.view.mas_bottom);
        make.height.mas_equalTo(37);
        make.left.right.mas_equalTo(self.view);
    }];
   
    
}

-(void)setSDCScrollView{
      NSMutableArray *imagesURLStrings = [NSMutableArray array];
        for (JMSpecialModel *model in self.specialModelArray) {
            
            [imagesURLStrings addObject:model.cover_path];
            
        }
//        
//        NSArray *imagesURLStrings = @[
//                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                      ];

        

        // 网络加载 --- 创建带标题的图片轮播器
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.schoolImgView.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"break"]];
        
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        [self.schoolImgView addSubview:cycleScrollView2];
      
      
        
        //         --- 模拟加载延迟
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//        });
        
        
        cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
            NSLog(@">>>>>  %ld", (long)index);
            JMSpecialViewController *vc = [[JMSpecialViewController alloc]init];
            JMSpecialModel *model = self.specialModelArray[index];
            vc.title = model.title;
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        
    

}




#pragma mark - 菊花

-(void)setupUpRefresh
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
    
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    // 设置颜色
    footer.stateLabel.textColor = MASTER_COLOR;
    
    // 设置footer
    self.tableView.mj_footer = footer;
    //     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
}

#pragma mark - 数据 -

-(void)loadMoreBills
{
    self.page += 1;
    [self getHomeListData];
    
}

-(void)refreshData
{
    [self.arrDate removeAllObjects];
    _page = 1;
    [self getHomeListData];
  
}

-(void)getHomeListData{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSArray *citys = [NSArray array];
    if (_city_id!=nil) {
        citys = @[_city_id];
    }else{
        citys = @[];
    }
    [[JMHTTPManager sharedInstance]fetchWorkPaginateWith_city_ids:citys company_id:nil label_id:nil work_label_id:_work_lab_id education:self.education experience_min:_work_year_s experience_max:_work_year_e salary_min:self.salary_min salary_max:self.salary_max subway_names:nil status:@"1" page:page per_page:per_page SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *modelArray = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            if (modelArray.count > 0) {
                [self.arrDate addObjectsFromArray:modelArray];
            }
            if (modelArray.count < 10) {
                [self.tableView.mj_footer setHidden:YES];
            }else{
                [self.tableView.mj_footer setHidden:NO];
            }
        }
        [self.tableView reloadData];
        [self.progressHUD setHidden:YES];
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)getSpecialInfo{
    [[JMHTTPManager sharedInstance]getSpecialInfoWithMode:@"list" SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSArray *arrayData =  [JMSpecialModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            for (JMSpecialModel *model in arrayData) {
                NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
                NSString *s_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",model.s_date];
                NSString *e_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",model.e_date];
                NSDate *s_Date= [self dateFromString:s_timeStr];
                NSDate *e_Date= [self dateFromString:e_timeStr];
                
                int s_result = [self compareOneDay:currentDate withAnotherDay:s_Date];
                int e_result = [self compareOneDay:currentDate withAnotherDay:e_Date];
                //s_Date < current < e_Date 在活动时间内
                if (s_result == 1 && e_result == -1) {
                    [self.specialModelArray addObject:model];
                    //                    [self.schoolImgView sd_setImageWithURL:[NSURL URLWithString:self.specialModel.cover_path] placeholderImage:[UIImage imageNamed:@"break"]];
                }else if((s_result == 0 || e_result == 0)){
                    [self.specialModelArray addObject:model];
                    
                }
               
            }
            if (self.specialModelArray.count > 0) {
                self.constraintHeight.constant = 142;
                [self setSDCScrollView];
                 
            }else{
                self.constraintHeight.constant = 0;
            
            }
            
        }
              
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
//    [[JMHTTPManager sharedInstance]getSpecialInfoWithModel:@"model"  SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        if (responsObject[@"data"]) {
//            self.specialModel =  [JMSpecialModel mj_objectWithKeyValues:responsObject[@"data"]];
//
//            NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
//            NSString *s_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",self.specialModel.s_date];
//            NSString *e_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",self.specialModel.e_date];
//            NSDate *s_Date= [self dateFromString:s_timeStr];
//            NSDate *e_Date= [self dateFromString:e_timeStr];
//
//            int s_result = [self compareOneDay:currentDate withAnotherDay:s_Date];
//            int e_result = [self compareOneDay:currentDate withAnotherDay:e_Date];
//            //s_Date < current < e_Date
//            if (s_result == 1 && e_result == -1) {
//                [self.schoolImgView sd_setImageWithURL:[NSURL URLWithString:self.specialModel.cover_path] placeholderImage:[UIImage imageNamed:@"break"]];
//                self.constraintHeight.constant = 142;
//            }else{
//                self.constraintHeight.constant = 0;
//            }
//
//
//        }
//
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];

}




#pragma mark - 点击事件 -

-(void)fanhui{
    JMCityListViewController *vc = [[JMCityListViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didSelectedCity_id:(NSString *)city_id{
    _city_id = city_id;
    self.arrDate = [NSMutableArray array];
    [self.tableView.mj_header beginRefreshing];

}

-(void)rightAction{
    NSLog(@"搜索");
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
    _work_lab_id = nil;
    _education = nil;
    _salary_max = nil;
    _salary_min = nil;
    [self.tableView.mj_header beginRefreshing];
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

-(void)closeVideoAction{

  

}

-(void)bgBtnAction{
    [self.bgBtn setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
}

//-(void)schoolAction{
//    NSLog(@"asdf");
//    JMSpecialViewController *vc = [[JMSpecialViewController alloc]init];
//    vc.title = self.specialModel.title;
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//-(void)getPlayerArray
//{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        for (JMHomeWorkModel *model in self.arrDate) {
//            if (model.videoFile_path) {
//                NSURL *url = [NSURL URLWithString:model.videoFile_path];
//                //直接创建AVPlayer，它内部也是先创建AVPlayerItem，这个只是快捷方法
//                AVPlayer *player = [AVPlayer playerWithURL:url];
//
//                [[JMVideoPlayManager sharedInstance].C_User_playArray addObject:player];
//            }else{
//                [[JMVideoPlayManager sharedInstance].C_User_playArray addObject:[NSNull null]];
//
//            }
//
//        }
//
//        self.playerArray = [JMVideoPlayManager sharedInstance].C_User_playArray;
//    });
//
//}

#pragma mark - 所有职位 -

- (IBAction)allPositionAction:(UIButton *)sender {
    [self.allOfPositionBtn setBackgroundColor:MASTER_COLOR];
    [self.allOfPositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.choosePositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.bgBtn setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
    _page = 1;
    _city_id = nil;
    _work_year_e = nil;
    _work_year_s = nil;
    _work_lab_id = nil;
    _education = nil;
    _salary_max = nil;
    _salary_min = nil;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 职位筛选 -
- (IBAction)choosePosition:(UIButton *)sender {
    [self.allOfPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allOfPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:MASTER_COLOR];
    [self.choosePositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.companyRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.companyRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.navigationController pushViewController:self.choosePositionVC animated:YES];
//    [self.choosePositionVC.view setHidden:NO];
    [self.bgBtn setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
   
}

-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    _work_lab_id = labIDStr;
    [self.arrDate removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 公司要求 -

- (IBAction)companyRequire:(UIButton *)sender {
    [self.companyRequireBtn setBackgroundColor:MASTER_COLOR];
    [self.companyRequireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.allOfPositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allOfPositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.choosePositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:NO];
    [self.labChooseBottomView setHidden:NO];
    [self.bgBtn setHidden:NO];

 
}


-(void)didSelectedCity_id:(NSString *)city_id city_name:(NSString *)city_name{
    _city_id = city_id;
    _page = 1;
    [self.arrDate removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
}

//人才要求
-(void)didChooseLabsTitle_str:(NSString *)str index:(NSInteger)index{
    
    if ([str isEqualToString:@"最低学历"]) {
            self.education = [NSString stringWithFormat:@"%ld",(long)(index)];
   
        NSLog(@"学历：%@",self.education);
    
        
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

-(void)playAction_cell:(HomeTableViewCell *)cell model:(JMHomeWorkModel *)model{
    
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:model.videoFile_path];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
    
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

#pragma mark - tableView DataSource -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrDate.count;
}


#pragma mark - tableView Delegate -

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
//    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    cell.indexpath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.arrDate.count > 0) {
        JMHomeWorkModel *model = self.arrDate[indexPath.row];
        
        [cell setModel:model];
    }
   
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailsViewController *vc = [[JobDetailsViewController alloc] init];
    JMHomeWorkModel *model = self.arrDate[indexPath.row];

    vc.homeworkModel = model;
    
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


-(PositionDesiredViewController *)choosePositionVC{
    if (_choosePositionVC == nil) {
        _choosePositionVC = [[PositionDesiredViewController alloc]init];
        _choosePositionVC.searchView.hidden = YES;
        _choosePositionVC.delegate = self;
        [_choosePositionVC setIsHomeViewVC:YES];
//        _choosePositionVC.view.hidden = YES;
//        [self addChildViewController:_choosePositionVC];
//        [self.view addSubview:_choosePositionVC.view];
//        [_choosePositionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.headView.mas_bottom);
//            make.left.and.right.mas_equalTo(self.view);
//            make.bottom.mas_equalTo(self.view).mas_offset(-500);
//        }];
        
    }

    return _choosePositionVC;

}


-(JMLabsChooseViewController *)labschooseVC{
    if (_labschooseVC == nil) {
        _labschooseVC = [[JMLabsChooseViewController alloc]init];
        _labschooseVC.delegate = self;
        [self addChildViewController:_labschooseVC];
        
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

-(UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc]init];
        _bgBtn.backgroundColor = [UIColor blackColor];
        _bgBtn.alpha = 0.3;
        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_bgBtn];
        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return _bgBtn;
}

-(NSMutableArray *)arrDate{
    if (!_arrDate) {
        _arrDate = [NSMutableArray array];
    }
    return _arrDate;
}

-(NSMutableArray *)specialModelArray{
    if (!_specialModelArray) {
        _specialModelArray = [NSMutableArray array];
    }
    return _specialModelArray;
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
