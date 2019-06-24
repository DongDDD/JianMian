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



@interface JMAssignmentSquareViewController ()<UITableViewDelegate,UITableViewDataSource,JMChoosePositionTableViewControllerDelegate>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) JMChoosePositionTableViewController *choosePositionVC;//与我匹配
@property (strong, nonatomic) UIView *tapView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger per_page;


@end

@implementation JMAssignmentSquareViewController
static NSString *B_cellIdent = @"BSquareCellID";
static NSString *C_cellIdent = @"CSquareCellID";

//static NSString *headerCellId = @"JMSquareHeaderModulesTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleViewImageViewName:@"demi_home"];
    [self setBackBtnImageViewName:@"site_Home" textName:@"广州"];
    self.per_page = 15;
    self.page = 1;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom)];
    [swipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipe];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapFrom)];
    [self.tapView addGestureRecognizer:tap];
    
    [self initTableView];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
       
        [self BToGetData];
        
    }else{
        [self CToGetData];

    
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)fanhui{
 
 
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
    [self.view addSubview:self.choosePositionVC.view];
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
#pragma mark - Action -

-(void)loadMoreBills
{
    self.page += 1;
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

-(void)handleTapFrom{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect Frame = ws.choosePositionVC.view.frame;
        Frame.origin.x = -SCREEN_WIDTH;
        ws.choosePositionVC.view.frame = Frame;
        self.tapView.hidden = YES;
    } completion:nil];
}
//侧拉手势
-(void)handleSwipeFrom{
    __weak typeof(self) ws = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect Frame = ws.choosePositionVC.view.frame;
        Frame.origin.x = -SCREEN_WIDTH;
        ws.choosePositionVC.view.frame = Frame;
        self.tapView.hidden = YES;
    } completion:nil];
}

-(void)movePageContentView{
    __weak typeof(self) ws = self;
    if (_index == 2) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect Frame = ws.choosePositionVC.view.frame;
            Frame.origin.x = 0;
            ws.choosePositionVC.view.frame = Frame;
            self.tapView.hidden = NO;
            
        } completion:nil];
        
    }

}

#pragma mark - GetData

-(void)BToGetData{
    
    NSString *per_page = [NSString stringWithFormat:@"%ld",(long)self.per_page];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [[JMHTTPManager sharedInstance]fectchAbilityList_city_id:nil type_label_id:nil industry_arr:nil myDescription:nil video_path:nil video_cover:nil image_arr:nil status:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMAbilityCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [self.dataArray addObjectsFromArray:array];
            if (array.count < 15) {
                [self.tableView.mj_footer setHidden:YES];
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
    [[JMHTTPManager sharedInstance]fectchTaskList_user_id:nil city_id:nil type_label_id:nil industry_arr:nil status:nil page:page per_page:per_page successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        if (responsObject[@"data"]) {
            NSMutableArray *array = [NSMutableArray array];
            array = [JMTaskListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            
            [self.dataArray addObjectsFromArray:array];
            if (array.count < 15) {
                [self.tableView.mj_footer setHidden:YES];
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
        if (self.dataArray.count>0) {
            
            [cell setModel:self.dataArray[indexPath.row]];
        }
        return cell;
        
    }else{
        JMCUserSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:C_cellIdent];
        if (cell == nil) {
            cell = [[JMCUserSquareTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:C_cellIdent];
        }
        if (self.dataArray.count>0) {
            
            [cell setModel:self.dataArray[indexPath.row]];
        }
        
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
        JMTaskListCellData *model = self.dataArray[indexPath.row];
        JMCDetailWebViewController *vc = [[JMCDetailWebViewController alloc]init];
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
        JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
        if ([userModel.type isEqualToString:C_Type_USER]) {
            JMSquareHeaderView *view =  [JMSquareHeaderView new];
            [view setUserModel:userModel];
            return view;
        }else{
            return [UIView new];
            
        }
    }
    
    if (section==1) {
        return self.titleView;        
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
    }
    
    return 43;
    
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
            str1 = @"推荐兼职";
            str2 = @"兼职分类";
        }
        
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[str1, str2,@"与我匹配"]];
        __weak JMAssignmentSquareViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf movePageContentView];
        };
    }
    
    return _titleView;
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


-(JMChoosePositionTableViewController *)choosePositionVC{
    if (_choosePositionVC == nil) {
        _choosePositionVC = [[JMChoosePositionTableViewController alloc]init];
        _choosePositionVC.delegate = self;
        [self addChildViewController:_choosePositionVC];
        _choosePositionVC.view.frame = CGRectMake(-SCREEN_WIDTH, 0, SCREEN_WIDTH*0.7, self.view.frame.size.height);

//        [_choosePositionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.view);
//            make.right.mas_equalTo(self.view);
//            make.bottom.mas_equalTo(self.view);
//        }];

//        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_choosePositionVC.view.mas_bottom);
//            make.left.and.right.mas_equalTo(_choosePositionVC.view);
//            make.bottom.mas_equalTo(self.view);
//        }];
    }
    return  _choosePositionVC;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
