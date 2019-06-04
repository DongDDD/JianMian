//
//  JMMyOrderListViewController.m
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyOrderListViewController.h"
#import "JMTitlesView.h"
#import "JMOrderStatusTableViewCell.h"
#import "JMOrderCellData.h"

@interface JMMyOrderListViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,JMOrderStatusTableViewCellDelegate>
@property (strong, nonatomic) JMTitlesView *titleView;
@property (strong, nonatomic) UITableView *tableView1;
@property (strong, nonatomic) UITableView *tableView2;
@property (strong, nonatomic) UITableView *tableView3;

@property(nonatomic,strong)JMOrderCellData *orderCellData;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)BOOL isSpread;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *BGView;

@end
static NSString *cellID = @"statusCellID";

@implementation JMMyOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)initView{
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.BGView];
    [self.BGView addSubview:self.tableView1];
    [self.BGView addSubview:self.tableView2];
    [self.BGView addSubview:self.tableView3];

}

-(void)setCurrentIndex{
    __weak typeof(self) ws = self;
//  [self.scrollView setContentOffset:CGPointMake(_index * SCREEN_WIDTH, 0) animated:YES];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        self.scrollView.contentOffset.x = -_index * SCREEN_WIDTH;
        CGRect Frame = ws.BGView.frame;
        Frame.origin.x = -_index * SCREEN_WIDTH;
        ws.BGView.frame = Frame;
//        //        CGRect Frame2 = ws.partTimeJobVC.view.frame;
//        //        Frame2.origin.x = -_index * SCREEN_WIDTH;
//        //        ws.partTimeJobVC.view.frame = Frame2;
//

    } completion:nil];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSpread) {
        return 256;
    }
    return 164;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JMOrderStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _orderCellData = [JMOrderCellData new];
    if (_isSpread) {
        _orderCellData.isSpread = YES;
    }
    
    [cell setOrderCellData:_orderCellData];
    // Configure the cell...
    
    return cell;
}

-(void)didClickDetail_isSpread:(BOOL)isSpread indexPath:(nonnull NSIndexPath *)indexPath{
    _isSpread = isSpread;
    [self.tableView1 reloadData];
    
}

#pragma mark - Getter
- (UITableView *)tableView1 {
    if (!_tableView1) {
        _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView1.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView1.separatorStyle = NO;
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView1.sectionHeaderHeight = 0;
        [_tableView1 registerNib:[UINib nibWithNibName:@"JMOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];

    }
    return _tableView1;
}

- (UITableView *)tableView2 {
    if (!_tableView2) {
        _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView2.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView2.separatorStyle = NO;
        _tableView2.delegate = self;
        _tableView2.dataSource = self;
        _tableView2.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView2.sectionHeaderHeight = 0;
        [_tableView2 registerNib:[UINib nibWithNibName:@"JMOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        
    }
    return _tableView2;
}
- (UITableView *)tableView3 {
    if (!_tableView3) {
        _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView3.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView3.separatorStyle = NO;
        _tableView3.delegate = self;
        _tableView3.dataSource = self;
        _tableView3.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView3.sectionHeaderHeight = 0;
        [_tableView3 registerNib:[UINib nibWithNibName:@"JMOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        
    }
    return _tableView3;
}

        
- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"等待发货", @"已发货", @"已完成"]];
        __weak JMMyOrderListViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            _index = index;
            [weakSelf setCurrentIndex];
        };
    }
    
    return _titleView;
}



-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0,43, SCREEN_WIDTH*3, SCREEN_HEIGHT)];
        _BGView.backgroundColor = MASTER_COLOR;
        
    }
    return _BGView;
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
