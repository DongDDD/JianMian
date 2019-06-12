//
//  JMTaskManageViewController.m
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskManageViewController.h"
#import "JMTitlesView.h"
#import "JMTaskManageTableViewCell.h"
#import "JMHTTPManager+FectchMyTaskOrderList.h"
#import "JMHTTPManager+TaskOrderStatus.h"
#import "JMHTTPManager+CreateTaskComment.h"

@interface JMTaskManageViewController ()<UITableViewDelegate,UITableViewDataSource,JMTaskManageTableViewCellDelegate>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSArray *listsArray;

@property (strong, nonatomic)NSArray *currentStatus;

@end

@implementation JMTaskManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.currentStatus = @[Task_WaitDealWith];
    [self getDataWitnStatus:self.currentStatus];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 获取数据

-(void)getDataWitnStatus:(NSArray *)status{
    [[JMHTTPManager sharedInstance]fectchTaskList_status:status page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.listsArray = [JMTaskOrderListCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}


#pragma mark - setUI -

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideTop).mas_offset(44);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.left.and.right.mas_equalTo(self.view);
    }];
    [self setupHeaderRefresh];
    [self setupFooterRefresh];
    
}

#pragma mark - myDelegate

-(void)leftActionWithData:(JMTaskOrderListCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    //待通过状态的该操作只能在B端出现-----
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        if ([data.status isEqualToString:Task_WaitDealWith]) {
            //拒绝
            [self changeTaskStatusRequestWithStatus:Task_Refuse task_order_id:data.task_order_id];
        }
    }
}

-(void)rightActionWithData:(JMTaskOrderListCellData *)data{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.type isEqualToString:B_Type_UESR]) {
            //现在状态：待处理or待通过
        if ([data.status isEqualToString:Task_WaitDealWith]) {
             //改状态------B端通过任务申请
            [self changeTaskStatusRequestWithStatus:Task_Pass task_order_id:data.task_order_id];
            return;
        }else if([data.status isEqualToString:Task_Finish]) {
             //改状态------B端确认完成任务
            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            return;
        }else if([data.status isEqualToString:Task_Pass]) {
            //改状态------销售分成点击结束任务按钮
            [self changeTaskStatusRequestWithStatus:Task_DidComfirm task_order_id:data.task_order_id];
            return;
        }else if([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_boss isEqualToString:@"0"]) {
            //B——创建评价
            [self createTaskCommentRequestWithTask_order_id:data.task_order_id reputation:Comment_VeryGood commentDescription:@"很好很好，下次继续合作"];
            return;
        }
    }else{
        //----进行中----
        if ([data.status isEqualToString:Task_Pass]) {
            if (![data.snapshot_type_label_id isEqualToString:@"1043"]) {
                //进行中状态的该操作只能在C端出现-----点击已完成 把状态改成 3
                [self changeTaskStatusRequestWithStatus:Task_Finish task_order_id:data.task_order_id];
                return;
            }
        }else if([data.status isEqualToString:Task_DidComfirm] && [data.is_comment_user isEqualToString:@"0"]) {
            //B——创建评价
            [self createTaskCommentRequestWithTask_order_id:data.task_order_id reputation:Comment_VeryGood commentDescription:@"很好很好，下次继续合作"];
            return;
        }
    }
    
   
    
}


-(void)setCurrentIndex{
    switch (_index) {
        case 0:
            //待处理
            self.currentStatus = @[Task_WaitDealWith];
            break;
        case 1:
            //进行中
            self.currentStatus = @[Task_Pass,Task_Finish];

            break;
        case 2:
            //已结束
            self.currentStatus = @[Task_Refuse,Task_DidComfirm];

            break;
            
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
    [self getDataWitnStatus:self.currentStatus];


}
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMTaskManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[JMTaskManageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell setData:self.listsArray[indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    _model = self.listsArray[indexPath.row];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    JMTaskOrderListCellData *data = self.listsArray[indexPath.row];
    //C端待处理且是0状态
    if ([data.status isEqualToString:Task_WaitDealWith] && [userModel.type isEqualToString:C_Type_USER]) {
        return 130;
    }else{
        return 177;

    }
    
}

#pragma mark - 数据请求
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


-(void)refreshData{
    [self getDataWitnStatus:self.currentStatus];

}

-(void)loadMoreBills{
    [self getDataWitnStatus:self.currentStatus];

}

-(void)changeTaskStatusRequestWithStatus:(NSString *)status task_order_id:(NSString *)task_order_id {
    
    [[JMHTTPManager sharedInstance]changeTaskOrderStatusWithTask_order_id:task_order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.tableView.mj_header beginRefreshing];
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

//创建评价
-(void)createTaskCommentRequestWithTask_order_id:(NSString *)task_order_id reputation:(NSString *)reputation commentDescription:(NSString *)commentDescription{
    [[JMHTTPManager sharedInstance]createTaskCommentWithForeign_key:task_order_id reputation:reputation commentDescription:commentDescription successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
        [self.tableView.mj_header beginRefreshing];

    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

}

#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"待通过", @"进行中", @"已结束"]];
        _titleView.viewType = JMTitlesViewDefault;;
        [_titleView setCurrentTitleIndex:0];
        __weak JMTaskManageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = MASTER_COLOR;
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //        _tableView.sectionHeaderHeight = 43;
        //        _tableView.sectionFooterHeight = 0;
        //        [_tableView registerNib:[UINib nibWithNibName:@"JMSquareHeaderModulesTableViewCell" bundle:nil] forCellReuseIdentifier:headerCellId];
        [_tableView registerNib:[UINib nibWithNibName:@"JMTaskManageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMBUserSquareTableViewCell" bundle:nil] forCellReuseIdentifier:B_cellIdent];
        
    }
    return _tableView;
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
