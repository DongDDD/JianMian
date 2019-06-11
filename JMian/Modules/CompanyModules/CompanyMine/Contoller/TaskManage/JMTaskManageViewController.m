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
@interface JMTaskManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSArray *listsArray;


@end

@implementation JMTaskManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务管理";
    [self initView];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 获取数据

-(void)getData{
    [[JMHTTPManager sharedInstance]fectchTaskList_status:nil page:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];


}


#pragma mark - setUI -

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
//    [self setupHeaderRefresh];
//    [self setupFooterRefresh];
    
}
#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JMTaskManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[JMTaskManageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.delegate = self;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    _model = self.listsArray[indexPath.row];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 177;
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
#pragma mark - Getter

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"待通过", @"进行中", @"已结束"]];
        _titleView.viewType = JMTitlesViewDefault;;
        [_titleView setCurrentTitleIndex:0];
        __weak JMTaskManageViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
//            [weakSelf setCurrentIndex];
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
