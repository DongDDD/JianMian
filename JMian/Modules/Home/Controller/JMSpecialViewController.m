//
//  JMSpecialViewController.m
//  JMian
//
//  Created by mac on 2019/8/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSpecialViewController.h"
#import "JMTitlesView.h"
#import "HomeTableViewCell.h"
#import "JMHTTPManager+Work.h"
#import "JobDetailsViewController.h"
#import "PositionDesiredViewController.h"
#import "JMLabChooseBottomView.h"
#import "JMLabsChooseViewController.h"
#import "JMVideoPlayManager.h"



@interface JMSpecialViewController ()<UITableViewDelegate,UITableViewDataSource,JMLabsChooseViewControllerDelegate,JMLabChooseBottomViewDelegate,HomeTableViewCellDelegate>
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSInteger index;

@property (nonatomic, strong) NSMutableArray *arrDate;
@property (nonatomic, strong) PositionDesiredViewController *choosePositionVC;
@property (nonatomic, strong) JMLabsChooseViewController *labschooseVC;
@property (nonatomic, strong) JMLabChooseBottomView *labChooseBottomView;
@property (nonatomic, strong) UIButton *bgBtn;

//请求参数
@property(nonatomic,copy)NSString *city_id;
@property(nonatomic,copy)NSString *work_lab_id;
@property(nonatomic,copy)NSString *education;
@property(nonatomic,copy)NSString *work_year_s;
@property(nonatomic,copy)NSString *work_year_e;
@property(nonatomic,copy)NSString *salary_min;
@property(nonatomic,copy)NSString *salary_max;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger per_page;

@end
static NSString *CHomeCellID = @"CHomeCellID";
static NSString *BHomeCellID = @"BHomeCellID";

@implementation JMSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self getCHomeListData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView{

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    [self setupUpRefresh];
    [self.labschooseVC.view setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.bgBtn setHidden:YES];
    
    [self.view addSubview:self.bgBtn];
    [self.view addSubview:self.labschooseVC.view];
    [self.view addSubview:self.labChooseBottomView];
    [_labschooseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(44);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-150);
    }];
    
    [_labChooseBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labschooseVC.view.mas_bottom);
        make.height.mas_equalTo(37);
        make.left.right.mas_equalTo(self.view);
    }];
}

#pragma mark - 菊花

-(void)setupUpRefresh
{
    MJRefreshNormalHeader *header =  [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];

    
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

#pragma mark - data

-(void)loadMoreBills
{
    self.page += 1;
    [self getCHomeListData];
    
}

-(void)refreshData
{
    [self.arrDate removeAllObjects];
    _page = 1;
    [self getCHomeListData];
    
}

-(void)getCHomeListData{
    [self showProgressHUD_view:self.view];
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
                [self.arrDate addObjectsFromArray:modelArray];
            if (modelArray.count < 15) {
                [self.tableView.mj_footer setHidden:YES];
            }
        }
        [self.tableView reloadData];
        [self hiddenHUD];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrDate.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 100;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.titleView;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}
#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHomeCellID];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CHomeCellID];
    }

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
#pragma mark - Action
-(void)showPageContentView{
    if (_index == 0) {
        [self.navigationController pushViewController:self.choosePositionVC animated:YES];
        //    [self.choosePositionVC.view setHidden:NO];
        [self.bgBtn setHidden:YES];
        [self.labChooseBottomView setHidden:YES];
        [self.labschooseVC.view setHidden:YES];
        
    }else if (_index == 1) {
        [self.labschooseVC.view setHidden:NO];
        [self.labChooseBottomView setHidden:NO];
        [self.bgBtn setHidden:NO];
    }

}

-(void)bgBtnAction{
    [self.bgBtn setHidden:YES];
    [self.labChooseBottomView setHidden:YES];
    [self.labschooseVC.view setHidden:YES];
}

#pragma mark - MyDelegate

-(void)sendPositoinData:(NSString *)labStr labIDStr:(NSString *)labIDStr{
    _work_lab_id = labIDStr;
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
#pragma mark - getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        NSString *str1;
        NSString *str2;
        str1 = @"职位筛选 v";
        
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            str2 = @"人才要求 v";
            
        }else{
            str2 = @"公司要求 v";
        }
        
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[str1, str2]];
        __weak JMSpecialViewController *weakSelf = self;
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
        _tableView.rowHeight = 141;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 5;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        _tableView.sectionFooterHeight = 5;
        [_tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:CHomeCellID];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMCDetailTaskDecriTableViewCell" bundle:nil] forCellReuseIdentifier:JMCDetailTaskDecriTableViewCellIdentifier];
     
        
    }
    return _tableView;
}

-(NSMutableArray *)arrDate{
    if (!_arrDate) {
        _arrDate = [NSMutableArray array];
    }
    return _arrDate;
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
            make.top.mas_equalTo(self.view).mas_offset(44);
            make.left.and.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view);
        }];
    }
    return _bgBtn;
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
