//
//  JMDiscussHistoryViewController.m
//  JMian
//
//  Created by mac on 2020/2/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMDiscussHistoryViewController.h"
#import "JMHTTPManager+FectchDiscussHistoryList.h"
#import "JMDiscussHistoryTableViewCell.h"
#import "JMDiscussHistoryCellData.h"
@interface JMDiscussHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *listArray;
@end

@implementation JMDiscussHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"协商历史";
    [self getData];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - data
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchDiscussListWithOrder_id:_order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.listArray = [JMDiscussHistoryCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
            [self.tableView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMDiscussHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMDiscussHistoryTableViewCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JMDiscussHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JMDiscussHistoryTableViewCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setData:self.listArray[indexPath.row]];
    // Configure the cell...
    return cell;
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.showsVerticalScrollIndicator = NO;
     [_tableView registerNib:[UINib nibWithNibName:@"JMDiscussHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:JMDiscussHistoryTableViewCellIdentifier];

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
