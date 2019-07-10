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

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,JMLabsChooseViewControllerDelegate,HomeTableViewCellDelegate,PositionDesiredDelegate,JMCityListViewControllerDelegate>

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
@property(nonatomic,assign)BOOL isShowAllData;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PositionDesiredViewController *choosePositionVC;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;

@property(nonatomic,strong)NSMutableArray *playerArray;
@property (nonatomic, strong) MBProgressHUD *progressHUD;

//@property (nonatomic, copy)NSString *job_lab_id;

@end

static NSString *cellIdent = @"cellIdent";


@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleViewImageViewName:@"demi_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"全国"];
    self.per_page = 15;
    self.page = 1;
    [self setTableView];
    [self setJuhua];
//    [self getData];
    
//    [self loginIM];
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

    [self.view addSubview:self.tableView];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self getData];
//
//    }];

    // 马上进入刷新状态
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    
    MJRefreshNormalHeader *header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    [self setupUpRefresh];
}

#pragma mark - 菊花
-(void)setJuhua{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.progressHUD.progress = 0.0;
    self.progressHUD.dimBackground = NO; //设置有遮罩
    [self.progressHUD showAnimated:YES]; //显示进度框
    [self.view addSubview:self.progressHUD];
}
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
//-(void)setupUpRefresh
//{
//
//
//
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
//}
#pragma mark - 刷新数据 -

//-(void)loadNewData
//{
//
//    [self getHomeListData];
//}

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
                //                [self getPlayerArray];
            }else{
                _isShowAllData = YES;
            }
        }
        [self.tableView reloadData];
        [self.progressHUD setHidden:YES];

        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
    
    
    
//    [[JMHTTPManager sharedInstance]fetchWorkPaginateWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
////
////        if (responsObject[@"data"]) {
////
////            self.arrDate = [JMHomeWorkModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
//////            [[JMVideoPlayManager sharedInstance].C_User_playArray removeAllObjects];
////
//////            [self getPlayerArray];
////            [self.tableView.mj_header endRefreshing];
////            [self.tableView reloadData];
////            [self.tableView.mj_footer endRefreshing];
////            [self.progressHUD setHidden:YES];
////        }
//        if (responsObject[@"data"]) {
//            NSMutableArray *modelArray = [JMCompanyHomeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
//
//            if (modelArray.count > 0) {
//
//                [self.arrDate addObjectsFromArray:modelArray];
//                //                [self getPlayerArray];
//                [self.tableView reloadData];
//                [self.tableView.mj_header endRefreshing];
//                [self.tableView.mj_footer endRefreshing];
//            }else{
//                _isShowAllData = YES;
//                [self.tableView.mj_footer setHidden:YES];
//
//            }
//        }
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, NSError  *error) {
//
//
//    }];
    

}


-(void)resetAction{
    [self.labschooseVC.view setHidden:YES];
    [self.tableView.mj_header beginRefreshing];

}

-(void)OKAction
{
    self.arrDate = [NSMutableArray array];
    [self.labschooseVC.view setHidden:YES];
    [self.tableView.mj_header beginRefreshing];

    
}


-(void)closeVideoAction{

  

}

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
    [self.labschooseVC.view setHidden:YES];
    [self.navigationController pushViewController:self.choosePositionVC animated:YES];
//    [self.choosePositionVC.view setHidden:NO];
   
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
    
        
    }else if ([str isEqualToString:@"工作经历"]) {
        NSString *exp = [self getArray_index:index];
        if (![exp isEqualToString:@"全部"] && ![exp isEqualToString:@"应届生"]) {
            self.work_year_e = [exp substringToIndex:0];
            self.work_year_s = [exp substringToIndex:3];
            
        }else if([exp isEqualToString:@"应届生"]){
            
            
            
        }
        //        self.work_year_s
    }
    
}
-(NSString *)getArray_index:(NSInteger )index
{
    NSArray *array;
    
    array = @[@"全部",@"应届生",@"1年",@"1～3年",@"3～5年",@"5～10年",@"10年以上"];
    
    return array[index];
    
}

-(void)playAction_cell:(HomeTableViewCell *)cell model:(JMHomeWorkModel *)model{
    
    [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:model.videoFile_path];
    [[JMVideoPlayManager sharedInstance] play];
    AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
    [self presentViewController:playVC animated:YES completion:nil];
    [[JMVideoPlayManager sharedInstance] play];
    
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
        [self.view addSubview:_labschooseVC.view];
        [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-71);
        }];
    }
    return  _labschooseVC;

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
