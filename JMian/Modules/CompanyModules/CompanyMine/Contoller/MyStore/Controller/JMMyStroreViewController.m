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
#import "JMCreatChatAction.h"
#import "JMHTTPManager+GetMyShopInfo.h"
#import "JMShopHomeViewController.h"
#import "JMHTTPManager+UpdateShopInfo.h"
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self upDateUserData];
    [self getData];

}

#pragma mark - data
-(void)getData{
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];

    [[JMHTTPManager sharedInstance]getMyShopInfoWithShop_id:model.shop_shop_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject) {
            self.cellConfigures.model = [JMShopInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self.tableView reloadData];
        }
        
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];

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
             [cell setModel:self.cellConfigures.model];
            return cell;
        }
        case JMMyStoreTypeOrderStatus: {
            JMMyStoreOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyStoreOrderStatusTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValueWithAll:self.cellConfigures.model.all_total dfh:self.cellConfigures.model.dfh_total shz:self.cellConfigures.model.shz_total wfk:self.cellConfigures.model.wfk_total];
            return cell;
        }
        case JMMyStoreTypeOrderManager1: {
            JMMyStoreManager1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMMyStoreManager1TableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            [cell setModel:self.cellConfigures.model];
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
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if (row == 0) {
        JMStroreNotificationViewController *vc = [[JMStroreNotificationViewController alloc]init];
        vc.viewType = JMStroreNotificationViewPoster;
        vc.title = @"店铺简介";
        vc.content = self.cellConfigures.model.shop_poster;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (row == 1) {
        JMStroreNotificationViewController *vc = [[JMStroreNotificationViewController alloc]init];
        vc.viewType = JMStroreNotificationViewDesc;
        vc.title = @"店铺公告";
        vc.content =  self.cellConfigures.model.shop_description;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (row == 3) {
        JMShopHomeViewController *vc = [[JMShopHomeViewController alloc]init];
        vc.title = @"店铺首页";
        vc.shop_id = self.cellConfigures.model.shop_id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)didSelectStoreManager2ItemWithRow:(NSInteger)row{
    if (row == 0) {
        JMShopHomeViewController *vc = [[JMShopHomeViewController alloc]init];
        vc.shop_id = self.cellConfigures.model.shop_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
        [JMCreatChatAction createServiceChat];
    }
    
    if (row == 2) {
        JMProductManagerViewController *vc = [[JMProductManagerViewController alloc]init];
        vc.shop_id = self.cellConfigures.model.shop_id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

-(void)didSelectedShopStatus:(NSString *)status{
    if ([status isEqualToString:@" 停业整顿"]) {
        [self upDateShopStatus:@"-1"];
    }else if ([status isEqualToString:@" 暂停营业"]) {
        [self upDateShopStatus:@"0"];
    }else if ([status isEqualToString:@" 正常营业"]) {
        [self upDateShopStatus:@"1"];
        
    }
    
}

-(void)upDateShopStatus:(NSString *)status{
    JMUserInfoModel *model  = [JMUserInfoManager getUserInfo];
       [[JMHTTPManager sharedInstance]updateShopInfoWithShop_id:model.shop_shop_id shop_logo:@"" shop_poster:@"" description:@"" status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
    
           
       } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
           
       }];
}


#pragma mark - Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
