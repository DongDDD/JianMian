//
//  JMAssignmentSquareViewController.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAssignmentSquareViewController.h"
#import "JMTitlesView.h"
#import "JMSquareHeaderView.h"
#import "JMCUserSquareTableViewCell.h"
#import "JMChoosePositionTableViewController.h"
#import "JMHTTPManager+FectchAbility.h"
#import "JMHTTPManager+FectchTaskList.h"
#import "JMAbilityCellData.h"
#import "JMTaskListCellData.h"
#import "JMBUserSquareTableViewCell.h"
#import "JMBDetailWebViewController.h"
#import "JMCDetailWebViewController.h"
#import "JMWalletViewController.h"
#import "JMTaskManageViewController.h"
#import "JMGradeView.h"
#import "JMPartTimeJobTypeLabsViewController.h"
#import "JMPartTimeJobResumeViewController.h"
#import "JMTaskListCellData.h"
#import "JMAbilityCellData.h"
#import "JMBUserPostSaleJobViewController.h"
#import "JMBUserPostPartTimeJobViewController.h"
#import "JMPostPartTimeResumeViewController.h"
#import "JMHTTPManager+Login.h"
#import "JMCityListViewController.h"
#import "JMChoosePartTImeJobTypeLablesViewController.h"
#import "JMSquarePostTaskView.h"
#import "JMSquareTaskManageViewController.h"
#import "JMPartTimeJobResumeViewController.h"
#import "JMTaskSeachViewController.h"
#import "JMCDetailViewController.h"



@interface JMAssignmentSquareViewController ()<UITableViewDelegate,UITableViewDataSource,JMChoosePositionTableViewControllerDelegate,JMSquareHeaderViewDelegate,JMPartTimeJobTypeLabsViewControllerDelegate,JMPartTimeJobResumeViewControllerDelegate,JMCityListViewControllerDelegate,JMChoosePartTImeJobTypeLablesViewControllerDelegate,JMSquarePostTaskViewDelegate,JMTaskSeachViewControllerDelegate>
@property (nonatomic, strong) UIView *titleAndPostTaskView;
@property (nonatomic, strong) JMTitlesView *titleView;
@property (nonatomic, strong) JMSquarePostTaskView *postTaskView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSUInteger index;
//@property (strong, nonatomic) JMChoosePositionTableViewController *partTimeJobHomeListVC;//与我匹配
@property(nonatomic, strong)JMPartTimeJobResumeViewController *partTimeJobHomeListVC;

//@property (strong, nonatomic) JMPartTimeJobTypeLabsViewController *partTimeJobTypeLabsVC;
@property (strong, nonatomic) UIView *tapView;
@property (strong, nonatomic) NSMutableArray *dataArray;


@property (copy, nonatomic)NSString *keyword;//搜索关键字
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger per_page;
@property (copy, nonatomic)NSString *city_id;//城市ID
@property (copy, nonatomic)NSString *type_label_id;//职位ID
@property (strong, nonatomic)NSMutableArray *industryLabIDArray;//根据行业标签筛选


@end

@implementation JMAssignmentSquareViewController
static NSString *B_cellIdent = @"BSquareCellID";
static NSString *C_cellIdent = @"CSquareCellID";

//static NSString *headerCellId = @"JMSquareHeaderModulesTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewImageViewName:@"demi_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"不限"];
    self.per_page = 10;
    self.page = 1;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hidePartTimeViewSwipeAction)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipe];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePartTimeViewTapAction)];
    [self.tapView addGestureRecognizer:tap];
    
    [self initTableView];
    [self setIsHiddenRightBtn:YES];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        [self BToGetData];
    }else{
        [self setRightBtnImageViewName:@"Search_Home" imageNameRight2:@""];
        [self CToGetData];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserData];
}

-(void)fanhui{
    JMCityListViewController *vc = [[JMCityListViewController alloc]init];
    vc.viewType = JMCityListViewPartTime;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)rightAction{
    
    JMTaskSeachViewController *vc = [[JMTaskSeachViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setUI -

-(void)initTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.top.mas_equalTo(self.mas_topLayoutGuideTop);
        make.left.and.right.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.tapView];
    [self.view addSubview:self.partTimeJobHomeListVC.view];
    [self setupHeaderRefresh];
    [self setupFooterRefresh];
    
}

#pragma mark - 刷新 -
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

#pragma mark - myDeletgate -
-(void)didSelectedCity_id:(NSString *)city_id city_name:(NSString *)city_name{
    _city_id = city_id;
    _page = 1;
    [self setBackBtnImageViewName:@"site_Home" textName:city_name];
    [self.dataArray removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
}
-(void)didClickIncomeAction{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    [self.navigationController pushViewController:[JMWalletViewController new] animated:YES];
}

-(void)didClickTaskProcessingAction{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    [vc setMyIndex:1];
    vc.title = @"我的任务";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didClickTaskCompletedAction{
    NSString *str = kFetchMyDefault(@"youke");
    if ([str isEqualToString:@"1"]) {
        [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
        return;
    }
    JMTaskManageViewController *vc = [[JMTaskManageViewController alloc]init];
    [vc setMyIndex:2];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)didChooseWithType_id:(NSString *)type_id typeName:(NSString *)typeName{
    _keyword = @"";
    _type_label_id = type_id;
    self.page = 1;
    [_industryLabIDArray removeAllObjects];
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)didClickCellWithTaskData:(JMTaskListCellData *)taskData{
    
    _page = 1;
    _keyword = @"";
    _type_label_id = taskData.type_labelID;
    [self hidePartTimeViewTapAction];
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)didClickCellWithAbilityData:(JMAbilityCellData *)abilityData{
    NSMutableArray *industryArray = [NSMutableArray array];
    for (JMIndustryModel *data in abilityData.industry) {
        [industryArray addObject:data.label_id];
    }
    self.industryLabIDArray = industryArray;
    [self hidePartTimeViewTapAction];
    _page = 1;
    _type_label_id = nil;
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)postPartTimeJobAction{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布网络销售任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMBUserPostSaleJobViewController *vc = [[JMBUserPostSaleJobViewController alloc]init];
            vc.viewType = JMBUserPostSaleJobViewTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"发布任务" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            JMBUserPostPartTimeJobViewController *vc = [[JMBUserPostPartTimeJobViewController alloc]init];
            vc.viewType = JMBUserPostPartTimeJobTypeAdd;
            [self.navigationController pushViewController:vc animated:YES];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([userModel.type isEqualToString:C_Type_USER]) {
        JMPostPartTimeResumeViewController *vc = [[JMPostPartTimeResumeViewController alloc]init];
        vc.viewType = JMPostPartTimeResumeViewAdd;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)didClickPostTaskAction{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        
        JMPartTimeJobResumeViewController *vc = [[JMPartTimeJobResumeViewController alloc]init];
        vc.viewType = JMPartTimeJobTypeManage;
        vc.title = @"任务管理";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"didClickPostTaskAction");
        
    }else{
        
        JMPartTimeJobResumeViewController *vc = [[JMPartTimeJobResumeViewController alloc]init];
        vc.viewType = JMPartTimeJobTypeResume;
        vc.title = @"任务简历";
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"didClickPostTaskAction");
        
        
        
    }
}


-(void)didInputKeywordWithStr:(NSString *)str{
    _keyword = str;
    [self.tableView.mj_header beginRefreshing];

}
#pragma mark - Action -

-(void)loadMoreBills
{
    _page += 1;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {        
        [self BToGetData];
        
    }else{
        [self CToGetData];
        
        
    }
    
}

-(void)refreshData
{
    self.dataArray = [NSMutableArray array];
    _page = 1;
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        
        [self BToGetData];
        
    }else{
        [self CToGetData];
        
        
    }
}

-(void)hidePartTimeViewTapAction{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect Frame = ws.partTimeJobHomeListVC.view.frame;
        Frame.origin.x = -SCREEN_WIDTH;
        ws.partTimeJobHomeListVC.view.frame = Frame;
        self.tapView.hidden = YES;
    } completion:nil];
}
//侧拉手势
-(void)hidePartTimeViewSwipeAction{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect Frame = ws.partTimeJobHomeListVC.view.frame;
        Frame.origin.x = -SCREEN_WIDTH;
        ws.partTimeJobHomeListVC.view.frame = Frame;
        self.tapView.hidden = YES;
    } completion:nil];
}

-(void)showPageContentView{
    if (_index == 0) {
        self.page = 1;
        _type_label_id = nil;
        _city_id = nil;
        _keyword = @"";
        [_industryLabIDArray removeAllObjects];
        [self.tableView.mj_header beginRefreshing];
    }else if (_index == 1) {
        JMChoosePartTImeJobTypeLablesViewController *vc = [[JMChoosePartTImeJobTypeLablesViewController alloc]init];
        vc.myVC = self;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (_index == 2) {
        NSString *str = kFetchMyDefault(@"youke");
        if ([str isEqualToString:@"1"]) {
            [self showAlertWithTitle:@"提示" message:@"当前为游客状态，请先进行登录" leftTitle:@"返回" rightTitle:@"去登录"];
            
        }else{
            //            __weak typeof(self) ws = self;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                //            CGRect Frame = ws.partTimeJobHomeListVC.view.frame;
                //            Frame.origin.x = 0;
                //            ws.partTimeJobHomeListVC.view.frame = Frame;
                self.tapView.hidden = NO;
                _partTimeJobHomeListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.8, self.view.frame.size.height-43);
            } completion:nil];
            
        }
        
    }
    
}

-(void)alertRightAction{
    [self loginOut];
    //    NavigationViewController *naVC = [[NavigationViewController alloc] initWithRootViewController:login];
    //    [UIApplication sharedApplication].delegate.window.rootViewController = naVC;
    //    [self presentViewController:l animated:YES completion:nil];
}

#pragma mark - GetData

-(void)BToGetData{
    
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchAbilityList_city_id:_city_id type_label_id:_type_label_id industry_arr:_industryLabIDArray myDescription:nil video_path:nil video_cover:nil image_arr:nil status:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMAbilityCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [self.dataArray addObjectsFromArray:array];
            if (array.count < 10) {
                [self.tableView.mj_footer setHidden:YES];
            }else{
                [self.tableView.mj_footer setHidden:NO];
                
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)CToGetData{
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchTaskList_user_id:nil city_id:_city_id type_label_id:_type_label_id industry_arr:_industryLabIDArray keyword:_keyword status:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMTaskListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [self.dataArray addObjectsFromArray:array];
            if (array.count < 10) {
                [self.tableView.mj_footer setHidden:YES];
            }else{
                [self.tableView.mj_footer setHidden:NO];
                
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}

-(void)getUserData{
    [[JMHTTPManager sharedInstance] fetchUserInfoWithSuccessBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        JMUserInfoModel *userInfo = [JMUserInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
        [JMUserInfoManager saveUserInfo:userInfo];
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
}
#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        JMBUserSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:B_cellIdent];
        
        if (cell == nil) {
            cell = [[JMBUserSquareTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:B_cellIdent];
        }
        for(UIView *view in [cell subviews]){
            if ([view isKindOfClass:[JMGradeView class]]) {
                [view removeFromSuperview];
            }
        }
        if (self.dataArray.count>0) {
            
            [cell setModel:self.dataArray[indexPath.row]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        JMCUserSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:C_cellIdent];
        if (cell == nil) {
            cell = [[JMCUserSquareTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:C_cellIdent];
        }
        if (self.dataArray.count>0) {
            
            [cell setModel:self.dataArray[indexPath.row]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        JMAbilityCellData *model = self.dataArray[indexPath.row];
        JMBDetailWebViewController *vc = [[JMBDetailWebViewController alloc]init];
        vc.ability_id = model.ability_id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
//        JMTaskListCellData *model = self.dataArray[indexPath.row];
//        JMCDetailWebViewController *vc = [[JMCDetailWebViewController alloc]init];
//        vc.task_id = model.task_id;
//        [self.navigationController pushViewController:vc animated:YES];
        JMCDetailViewController *vc = [[JMCDetailViewController alloc]init];
        JMTaskListCellData *model = self.dataArray[indexPath.row];
        vc.task_id = model.task_id;

        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 159;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  0;
    }
    return 137;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//
//    return self.titleView;;
//}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        //        JMVersionModel *model = [JMVersionManager getVersoinInfo];
        //        if (![model.test isEqualToString:@"1"]) {
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.type isEqualToString:C_Type_USER]) {
            JMSquareHeaderView *view =  [JMSquareHeaderView new];
            view.delegate = self;
            [view setUserModel:userModel];
            return view;
            
        }else{
            return [UIView new];
            
            
        }
        //        }else{
        //            return [UIView new];
        //
        //        }
    }
    
    if (section==1) {
//        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//        if ([userModel.type isEqualToString:C_Type_USER]) {
//            return self.titleView;
//
//        }else{
            [self.titleAndPostTaskView addSubview:self.titleView];
            [self.titleAndPostTaskView addSubview:self.postTaskView];
            [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleAndPostTaskView);
                make.right.mas_equalTo(self.titleAndPostTaskView);
                make.top.mas_equalTo(self.titleAndPostTaskView);
                make.height.mas_equalTo(44);
            }];
            [self.postTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.titleAndPostTaskView);
                make.right.mas_equalTo(self.titleAndPostTaskView);
                make.top.mas_equalTo(self.titleView.mas_bottom);
                make.height.mas_equalTo(61);
            }];
            return self.titleAndPostTaskView;
            
//        }
    }
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.type isEqualToString:C_Type_USER]) {
            return 159;
            
        }else{
            return 0;
            
        }
    }else if (section == 1){
//        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
//        if ([userModel.type isEqualToString:C_Type_USER]) {
//            return 44;
//
//        }else{
            return 100;
            
//        }
    }
    
    return 106;
    
}


#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        NSString *str1;
        NSString *str2;
        
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            str1 = @"推荐人才";
            str2 = @"职位筛选";
            
        }else{
            str1 = @"推荐任务";
            str2 = @"任务分类";
        }
        
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[str1, str2,@"与我匹配"]];
        __weak JMAssignmentSquareViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

-(JMSquarePostTaskView *)postTaskView{
    if (!_postTaskView) {
        _postTaskView = [[JMSquarePostTaskView alloc]init];
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        NSString *str;
        if ([userModel.type isEqualToString:B_Type_UESR]) {
            str = @"立即发布任务";
        }else{
            str = @"立即创建任务简历";

        }
        [_postTaskView.postBtn setTitle:str forState:UIControlStateNormal];
        _postTaskView.delegate = self;
    }
    return _postTaskView;
}

-(UIView *)titleAndPostTaskView{
    if (!_titleAndPostTaskView) {
        _titleAndPostTaskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 106)];
        
    }
    return _titleAndPostTaskView;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = BG_COLOR;
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        //        _tableView.sectionFooterHeight = 0;
        //        [_tableView registerNib:[UINib nibWithNibName:@"JMSquareHeaderModulesTableViewCell" bundle:nil] forCellReuseIdentifier:headerCellId];
        [_tableView registerNib:[UINib nibWithNibName:@"JMCUserSquareTableViewCell" bundle:nil] forCellReuseIdentifier:C_cellIdent];
        [_tableView registerNib:[UINib nibWithNibName:@"JMBUserSquareTableViewCell" bundle:nil] forCellReuseIdentifier:B_cellIdent];
        
    }
    return _tableView;
}


-(JMPartTimeJobResumeViewController *)partTimeJobHomeListVC{
    if (_partTimeJobHomeListVC == nil) {
        _partTimeJobHomeListVC = [[JMPartTimeJobResumeViewController alloc]init];
        _partTimeJobHomeListVC.delegate = self;
        _partTimeJobHomeListVC.viewType = JMPartTimeJobTypeHome;
        [self addChildViewController:_partTimeJobHomeListVC];
        _partTimeJobHomeListVC.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH, self.view.frame.size.height-43);
    }
    return  _partTimeJobHomeListVC;
    
}

-(UIView *)tapView{
    if (!_tapView) {
        _tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tapView.backgroundColor = [UIColor blackColor];
        _tapView.alpha = 0.3;
        _tapView.hidden = YES;
    }
    return _tapView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//兼职职位
//-(JMPartTimeJobResumeViewController *)partTimeJobHomeListVC{
//    if (!_partTimeJobHomeListVC) {
//        _partTimeJobHomeListVC = [[JMPartTimeJobResumeViewController alloc]init];
//        _partTimeJobHomeListVC.delegate = self;
//        _partTimeJobHomeListVC.viewType = JMPartTimeJobTypeManage;
//        _partTimeJobHomeListVC.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH*0.7, self.view.frame.size.height);
//        [self addChildViewController:_partTimeJobHomeListVC];
//    }
//    return _partTimeJobHomeListVC;
//}

//-(JMPartTimeJobTypeLabsViewController *)partTimeJobTypeLabsVC{
//    if (_partTimeJobTypeLabsVC == nil) {
//        _partTimeJobTypeLabsVC = [[JMPartTimeJobTypeLabsViewController alloc]init];
//        _partTimeJobTypeLabsVC.view.frame =  CGRectMake(0, self.titleView.frame.origin.y+self.titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
//        [self addChildViewController:_partTimeJobTypeLabsVC];
//    }
//    return _partTimeJobTypeLabsVC;
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
