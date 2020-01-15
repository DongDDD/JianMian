//
//  JMMyStroreViewController.m
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMMyStroreViewController.h"
#import "JMMyStoreConfigure.h"
#import "JMStroreNotificationViewController.h"
#import "JMProductManagerViewController.h"

@interface JMMyStroreViewController ()<UITableViewDelegate,UITableViewDataSource,JMMyStoreManager1TableViewCellDelegate,JMMyStoreManager2TableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMMyStoreConfigure *cellConfigures;

@end

@implementation JMMyStroreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
    self.title = @"我的店铺";
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
        return 4;
 
}

 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [self.cellConfigures numberOfRowsInSection:section];
 }

 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return [self.cellConfigures heightForRowsInSection:indexPath.section];
 }

 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return [self.cellConfigures heightForFooterInSection:section];
 }

// -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//     return [self.cellConfigures heightForHeaderInSection:section];
// }

// -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//     return [self.cellConfigures headerViewInSection:section];
// }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMMyStoreTypeTitleHeader: {
            JMMyStoreTitleHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyStoreTitleHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
            //        [cell setModel:self.userModel viewType:JMUserProfileHeaderCellTypeB];
            return cell;
        }
        case JMMyStoreTypeOrderStatus: {
            JMMyStoreOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyStoreOrderStatusTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        case JMMyStoreTypeOrderManager1: {
            JMMyStoreManager1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyStoreManager1TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
        case JMMyStoreTypeOrderManager2: {
            JMMyStoreManager2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyStoreManager2TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            return cell;
        }
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

#pragma mark - delegate
-(void)didSelectStoreManager1ItemWithRow:(NSInteger)row{
    if (row == 0) {
        
    }else if (row == 1) {
        JMStroreNotificationViewController *vc = [[JMStroreNotificationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)didSelectStoreManager2ItemWithRow:(NSInteger)row{
    if (row == 2) {
        JMProductManagerViewController *vc = [[JMProductManagerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }

}

#pragma mark - Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColorFromHEX(0xF5F5F6);
//        _tableView.backgroundColor = [UIColor whiteColor];;

        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;

        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreTitleHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreTitleHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreOrderStatusTableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreOrderStatusTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager1TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager1TableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMMyStoreManager2TableViewCell" bundle:nil] forCellReuseIdentifier:JMMyStoreManager2TableViewCellIdentifier];
          
        
        
    }
    return _tableView;
}

-(JMMyStoreConfigure *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMMyStoreConfigure alloc]init];
    }
    return _cellConfigures;
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
