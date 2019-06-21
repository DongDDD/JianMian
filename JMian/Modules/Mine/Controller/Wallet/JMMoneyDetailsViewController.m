//
//  JMMoneyDetailsViewController.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMoneyDetailsViewController.h"
#import "JMMoneyDetailTableViewCell.h"
#import "JMHTTPManager+FectchMoneyDetail.h"
#import "JMHTTPManager+FectchWalletDetails.h"
#import "JMWalletDetailsCellData.h"
@interface JMMoneyDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *arrayList;

@end

@implementation JMMoneyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包明细";
    [self.view addSubview:self.tableView];
    [self getData];
    // Do any additional setup after loading the view.
}

#pragma mark - 获取数据
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchWalletDetailListWithPage:nil per_page:nil successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.arrayList = [JMWalletDetailsCellData mj_objectArrayWithKeyValuesArray:responsObject[@"data"]];
        }
        [self.tableView reloadData];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMMoneyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TTextMessageCell_ReuseId];
    if(cell == nil){
        cell = [[JMMoneyDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TTextMessageCell_ReuseId];
    }
    
    [cell setData:self.arrayList[indexPath.row]];
    return cell;
    
    
}


#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BG_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 10;
        _tableView.rowHeight = 66;
        [_tableView registerNib:[UINib nibWithNibName:@"JMMoneyDetailTableViewCell" bundle:nil] forCellReuseIdentifier:TTextMessageCell_ReuseId];

        
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
