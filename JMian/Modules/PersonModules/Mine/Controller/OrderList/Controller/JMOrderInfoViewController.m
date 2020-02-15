//
//  JMOrderInfoViewController.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoViewController.h"
#import "JMOrderInfoConfigure.h"
#import "JMHTTPManager+FectchOrderInfo.h"

@interface JMOrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMOrderInfoConfigure *cellConfigures;


@end

@implementation JMOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.tableView];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - data
-(void)getData{
    [[JMHTTPManager sharedInstance]fectchOrderInfoWithOrder_id:self.order_id successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        if (responsObject[@"data"]) {
            self.cellConfigures.model = [JMOrderInfoModel mj_objectWithKeyValues:responsObject[@"data"]];
            [self.tableView reloadData];
        }
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
    
    
}
    
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
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
        case JMOrderInfoTypeTitleHeader: {
            JMOrderInfoHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_viewType == JMOderInfoBtnTypeTradeSuccessfully) {
                 cell.titleLab.text = @"交易成功";
            }else if (_viewType == JMOrderInfoViewTypeDidRefund) {
                cell.titleLab.text = @"已退款";
            }else if (_viewType == JMOrderInfoViewTypeWaitSalesReturn) {
                cell.titleLab.text = @"等待退货";
            }else if (_viewType == JMOrderInfoViewTypeWaitDeliverGoods) {
                cell.titleLab.text = @"待发货";
            }
            //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
//            [cell setModel:model];
            return cell;
        }
        case JMOrderInfoTypeAdress: {
            JMOrderInfoAdressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoAdressTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValuesWithName:self.cellConfigures.model.contact_name phone:self.cellConfigures.model.contact_phone adress:self.cellConfigures.model.contact_address];
            return cell;
        }
        case JMOrderInfoTypeGoodsList: {
            JMGoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsInfoTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            JMGoodsCellData *data = self.cellConfigures.model.goods[indexPath.row];
            NSString *cover_path = [NSString stringWithFormat:@"http://app.jmzhipin.com%@",data.cover_path];

            [cell setValuesWithImageUrl:cover_path title:data.title quantity:data.quantity price:data.price];
            return cell;
        }
        case JMOrderInfoTypePrice: {
            JMOrderInfoPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoPriceTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setPrice:self.cellConfigures.model.pay_amount];
            return cell;
        }
        case JMOrderInfoTypeTimeMsg: {
            JMOrderInfoTimeMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoTimeMsgTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValuesWithTime1:self.cellConfigures.model.created_at time2:self.cellConfigures.model.pay_time];
            return cell;
        }
        case JMOrderInfoTypeBtn: {
            JMOderInfoBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOderInfoBtnTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setViewType:JMOderInfoBtnTypeTradeSuccessfully];
            
            return cell;
        }
        default:
            break;
    }
    
    return [UITableViewCell new];
    
}

#pragma mark - lazy

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

        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderInfoHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMOrderInfoHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderInfoAdressTableViewCell" bundle:nil] forCellReuseIdentifier:JMOrderInfoAdressTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsInfoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderInfoPriceTableViewCell" bundle:nil] forCellReuseIdentifier:JMOrderInfoPriceTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderInfoTimeMsgTableViewCell" bundle:nil] forCellReuseIdentifier:JMOrderInfoTimeMsgTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMOderInfoBtnTableViewCell" bundle:nil] forCellReuseIdentifier:JMOderInfoBtnTableViewCellIdentifier];


          
        
        
    }
    return _tableView;
}

-(JMOrderInfoConfigure *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMOrderInfoConfigure alloc]init];
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
