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

@interface JMCompanyHomeViewController ()<UITableViewDelegate,UITableViewDataSource,JMCompanyHomeTableViewCellDelegate,JMLabsChooseViewControllerDelegate,JMChoosePositionTableViewControllerDelegate,JMCityListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arrDate;
@property(nonatomic,strong)NSMutableArray *playerArray;


@property (nonatomic, strong) JMChoosePositionTableViewController *choosePositionVC;
@property (nonatomic, strong) UIButton *bgBtn;

@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;
@property (weak, nonatomic) IBOutlet UIButton *choosePositionBtn;
@property (weak, nonatomic) IBOutlet UIButton *chooseRequireBtn;
@property(nonatomic,strong)NSMutableArray *choosePositionArray;
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



//
//@property (nonatomic, strong) VIResourceLoaderManager *resourceLoaderManager;
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVPlayerItem *playerItem;
//@property (nonatomic, strong) VIMediaDownloader *downloader;
//


//@property (strong, nonatomic) AVPlayerViewController *playerVC;

@end
static NSString *cellIdent = @"cellIdent";

@implementation JMCompanyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleViewImageViewName:@"jianmian_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];
    [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];
    
//    self.per_page = 7;
//    self.page = 1;
    [self getData];
    [self setTableView];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark - 获取数据
-(void)getData{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fetchVitaPaginateWith_city_id:self.city_id job_label_id:self.job_label_id education:self.education work_year_s:self.work_year_s work_year_e:self.work_year_e salary_min:self.salary_min salary_max:self.salary_max page:page per_page:per_page SuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.arrDate = [JMCompanyHomeModel mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            if (self.arrDate) {
                
                //                [self getPlayerArray];
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
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

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 141;
    [self.tableView registerNib:[UINib nibWithNibName:@"JMCompanyHomeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdent];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    [self setupDownRefresh];//添加下拉刷新
    [self setupUpRefresh];

}

#pragma mark - 下拉刷新 -
-(void)setupDownRefresh
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)setupUpRefresh
{
//     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBills)];
}

-(void)loadNewData
{
    
    [self getData];
}

-(void)loadMoreBills
{
  
//    self.per_page = self.per_page + 3;
    [self getData];
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
    
    cell.indexPath = indexPath;
    cell.delegate = self;
    JMCompanyHomeModel *model = self.arrDate[indexPath.row];
    [cell setModel:model];
//
    return cell;
    
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMPersonDetailsViewController *vc = [[JMPersonDetailsViewController alloc] init];
    JMCompanyHomeModel *model = self.arrDate[indexPath.row];
//    if (self.playerArray) {
//        vc.player = self.playerArray[indexPath.row];
//    }
    //    vc.user_job_id = model.user_job_id;
    vc.companyModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 点击事件

-(void)fanhui{
    JMCityListViewController *vc = [[JMCityListViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)didSelectedCity_id:(NSString *)city_id{

    _city_id = city_id;
    [self.tableView.mj_header beginRefreshing];
}

-(void)playAction_cell:(JMCompanyHomeTableViewCell *)cell{
    
        [[JMVideoPlayManager sharedInstance] setupPlayer_UrlStr:cell.model.video_file_path];
        [[JMVideoPlayManager sharedInstance] play];
        AVPlayerViewController *playVC = [JMVideoPlayManager sharedInstance];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:playVC animated:NO];

}

- (IBAction)choosePositionAction:(UIButton *)sender {
    [self.choosePositionBtn setBackgroundColor:MASTER_COLOR];
    [self.choosePositionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chooseRequireBtn setBackgroundColor:[UIColor whiteColor]];
    [self.chooseRequireBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.choosePositionVC.view setHidden:NO];
    [self.labschooseVC.view setHidden:YES];
    [self getPositionListData];
    [self.bgBtn setHidden:NO];
    //    self.choosePositionVC
}

- (IBAction)requireChooseAction:(UIButton *)sender {
    [self.chooseRequireBtn setBackgroundColor:MASTER_COLOR];
    [self.chooseRequireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.choosePositionBtn setBackgroundColor:[UIColor whiteColor]];
    [self.choosePositionBtn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [self.labschooseVC.view setHidden:NO];
    [self.choosePositionVC.view setHidden:YES];
    [self.bgBtn setHidden:YES];

   

}


-(void)bgBtnAction{
    [self.choosePositionVC.view setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
    [_bgBtn setHidden:YES];

}

//要求筛选
-(void)resetAction{
//    [self.labschooseVC.view removeFromSuperview];
//    [self.labschooseVC.view setHidden:NO];
    [self.labschooseVC.view setHidden:YES];
    [_bgBtn setHidden:YES];
    
}
//职位选择
-(void)OKAction
{
    [self.labschooseVC.view setHidden:YES];
    [_bgBtn setHidden:YES];
    [self.tableView.mj_header beginRefreshing];

    
}
//职位选择
-(void)didSelectCellActionController:(JMChoosePositionTableViewController *)controller{
    [self.choosePositionVC.view setHidden:YES];
    [_bgBtn setHidden:YES];
    
    self.job_label_id = controller.homeModel.work_label_id;
    [self.tableView.mj_header beginRefreshing];


}

//人才要求
-(void)didChooseLabsTitle_str:(NSString *)str index:(NSInteger)index{
    if ([str isEqualToString:@"最低学历"]) {
        if (index >= 1) {
            self.education = [NSString stringWithFormat:@"%ld",(long)(index-1)];
        }else{
            
            self.education = nil;
        }
        
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
        _bgBtn = [[UIButton alloc]init];
        _bgBtn.backgroundColor = [UIColor blackColor];
        _bgBtn.alpha = 0.3;
        [_bgBtn addTarget:self action:@selector(bgBtnAction) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_bgBtn];
        [_choosePositionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-200);
        }];
        
        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_choosePositionVC.view.mas_bottom);
            make.left.and.right.mas_equalTo(_choosePositionVC.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return  _choosePositionVC;
    
}


-(JMLabsChooseViewController *)labschooseVC{
    if (_labschooseVC == nil) {
        _labschooseVC = [[JMLabsChooseViewController alloc]init];
        _labschooseVC.delegate = self;
        [self addChildViewController:_labschooseVC];
        [self.view addSubview:_labschooseVC.view];
        [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view).offset(-71);
        }];
    }
    return  _labschooseVC;
    
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
