//
//  JMProductManagerViewController.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductManagerViewController.h"
#import "JMTitlesView.h"
#import "JMProductManagerTableViewCell.h"
#import "JMSelectProductCategoriesViewController.h"
@interface JMProductManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)JMTitlesView *titleView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation JMProductManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品";
    [self setRightBtnTextName:@"发布"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

-(void)rightAction{
    [self.navigationController pushViewController:[JMSelectProductCategoriesViewController new] animated:YES];

}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
        return 1;
 
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 3;
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        JMProductManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMProductManagerTableViewCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
        //        [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeB];
        return cell;
 

}
#pragma mark - lazy

- (JMTitlesView *)titleView {
    if (!_titleView) {
        _titleView = [[JMTitlesView alloc] initWithFrame:(CGRect){0, 0, SCREEN_WIDTH, 43} titles:@[@"全部", @"未上架", @"已上架"]];
//        __weak JMCompanyDetailViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
//            _index = index;
//            [weakSelf showPageContentView];
        };
    }
    
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.backgroundColor = [UIColor whiteColor];;

        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.titleView;
        _tableView.rowHeight = 154;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;

        [_tableView registerNib:[UINib nibWithNibName:@"JMProductManagerTableViewCell" bundle:nil] forCellReuseIdentifier:JMProductManagerTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreOrderStatusTableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager1TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager1TableViewCellIdentifier];
//        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager2TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager2TableViewCellIdentifier];
          
        
        
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
