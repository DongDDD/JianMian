//
//  JMAfterSalesInfoViewController.m
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMAfterSalesInfoViewController.h"
#import "JMHTTPManager+FectchOrderInfo.h"
#import "JMCreatChatAction.h"
#import "JMHTTPManager+ChangeOrderStatus.h"
#import "JMRefundDetailViewController.h"
#import "JMApplyForRefundViewController.h"
#import "JMAfterSalesInfoConfigure.h"

@interface JMAfterSalesInfoViewController ()
@property(nonatomic,strong)UITableView *tableView;
/// 333
@property(nonatomic,strong)JMAfterSalesInfoConfigure *cellConfigures;
@end

@implementation JMAfterSalesInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款详情";
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

-(void)changOrderStatus:(NSString *)status order_id:(NSString *)order_id{
    [[JMHTTPManager sharedInstance]changeOrderStatusWithOrder_id:order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}
#pragma mark - Delegate
-(void)didClickBtnWithBtnTtitle:(NSString *)btnTtitle{
    if ([btnTtitle isEqualToString:@"联系买家"]) {
        NSString *user_id = [NSString stringWithFormat:@"%@a",self.cellConfigures.model.user_id];
        [JMCreatChatAction create4TypeChatRequstWithAccount:user_id];
    }else if ([btnTtitle isEqualToString:@"申请退款"]){
        JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
        vc.viewType = JMApplyForRefundViewTypeRefund;
        vc.model  = self.cellConfigures.model;
        vc.title = @"申请退款";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTtitle isEqualToString:@"售后中"]){
        JMAfterSalesInfoViewController *vc = [[JMAfterSalesInfoViewController alloc]init];
        vc.viewType = JMAfterSalesInfoViewTypeWait;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTtitle isEqualToString:@"申请售后"]){
        JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
        vc.viewType = JMApplyForRefundViewTypeAfterSales;
        vc.order_id = self.order_id;
        vc.title = @"申请退款";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTtitle isEqualToString:@"联系卖家"]){
         NSString *user_id = [NSString stringWithFormat:@"%@b",self.cellConfigures.model.after_sale_boss_id];
          [JMCreatChatAction create4TypeChatRequstWithAccount:user_id];
    }else if ([btnTtitle isEqualToString:@"客服介入"]){
         NSString *user_id = [NSString stringWithFormat:@"%@b",self.cellConfigures.model.after_sale_boss_id];
//           foreign_key = @"0";
//              chat_type = @"3";
             NSString *recipient_mark = [NSString stringWithFormat:@"%@b",kFetchMyDefault(@"service_id")];
//              recipient_id = messagelistModel.service_id;
            JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
              NSString *str_b = [NSString stringWithFormat:@"%@b",self.cellConfigures.model.after_sale_boss_id];
              NSString *str_a = [NSString stringWithFormat:@"%@a",self.cellConfigures.model.user_id];
              NSString *sender_mark = ([userModel.type isEqualToString:B_Type_UESR]) ? str_b : str_a;
//              [self createChatRequstWithType:chat_type foreign_key:foreign_key recipient:recipient_id sender_mark:sender_mark recipient_mark:recipient_mark model:messagelistModel];
        [JMCreatChatAction createServiceTypeChatRequstWithChat_type:@"3" foreign_key:@"0" user_id:self.cellConfigures.model.user_id sender_mark:sender_mark recipient_mark:recipient_mark];
    }else if ([btnTtitle isEqualToString:@"撤销申请"]){
        [self changOrderStatus:@"6" order_id:self.order_id];
        
    }else if ([btnTtitle isEqualToString:@"再次申请"]){
        JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
        vc.viewType = JMApplyForRefundViewTypeRefund;
        vc.model = self.cellConfigures.model;
        vc.title = @"申请退款";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case JMAfterSalesInfoTypeTitleHeader: {
            JMOrderInfoHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_viewType == JMAfterSalesInfoViewTypeWait) {
                cell.titleLab.text = @"等待商家处理";
            }else if (_viewType == JMAfterSalesInfoViewTypeRefuse) {
                cell.titleLab.text = @"商家拒绝退款";

            }else if (_viewType == JMAfterSalesInfoViewTypeBeingAfterSales) {
                cell.titleLab.text = @"售后中";

            }else if (_viewType == JMAfterSalesInfoViewTypeSetRefund) {
                cell.titleLab.text = @"对方发起退款";

            }else if (_viewType == JMAfterSalesInfoViewTypeRefuseRefund) {
                cell.titleLab.text = @"卖家拒绝退款";

            }
            //        self.userModel.company_real_company_name = self.cellConfigures.model.company_name;
//            [cell setModel:model];
            return cell;
        }
        case JMAfterSalesInfoTypeRefundTitle: {
            JMAfterSalesRefundTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMAfterSalesRefundTitleTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMAfterSalesInfoTypeGoodsList: {
            JMGoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMGoodsInfoTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            JMGoodsCellData *data = self.cellConfigures.model.goods[indexPath.row];
            NSString *cover_path = [NSString stringWithFormat:@"http://app.jmzhipin.com%@",data.cover_path];

            [cell setValuesWithImageUrl:cover_path title:data.title quantity:data.quantity price:data.price];
            return cell;
        }
        case JMAfterSalesInfoTypeDetail: {
            JMAfterSalesDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMAfterSalesDetailTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValuesWithTime:self.cellConfigures.model.after_sale_created_at price:self.cellConfigures.model.pay_amount msg:@""];
            return cell;
        }
        case JMAfterSalesInfoTypeHistory: {
            JMDiscussHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMDiscussHistoryTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case JMAfterSalesInfoTypeBtn: {
            JMOderInfoBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOderInfoBtnTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            if (_viewType == JMAfterSalesInfoViewTypeWait) {
                [cell.btn2 setHidden:NO];
                [cell.btn10 setHidden:NO];
            }else if (_viewType == JMAfterSalesInfoViewTypeRefuse) {
                [cell.btn2 setHidden:NO];
                [cell.btn3 setHidden:NO];
                [cell.btn10 setHidden:NO];
            }else if (_viewType == JMAfterSalesInfoViewTypeBeingAfterSales) {
                JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn1 setHidden:NO];
                    [cell.btn2 setHidden:NO];
                    [cell.btn3 setHidden:NO];
                    [cell.btn12 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    [cell.btn3 setHidden:NO];
                    [cell.btn10 setHidden:NO];
                    
                }
            }else if (_viewType == JMAfterSalesInfoViewTypeRefuseRefund) {
                [cell.btn11 setHidden:NO];
                [cell.btn3 setHidden:NO];
                [cell.btn0 setHidden:NO];
            }
            
            
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
//        _tableView.backgroundColor = [UIColor whiteColor];

        _tableView.separatorStyle = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;

        [_tableView registerNib:[UINib nibWithNibName:@"JMOrderInfoHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:JMOrderInfoHeaderTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMAfterSalesRefundTitleTableViewCell" bundle:nil] forCellReuseIdentifier:JMAfterSalesRefundTitleTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMGoodsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:JMGoodsInfoTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMAfterSalesDetailTableViewCell" bundle:nil] forCellReuseIdentifier:JMAfterSalesDetailTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMDiscussHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:JMDiscussHistoryTableViewCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"JMOderInfoBtnTableViewCell" bundle:nil] forCellReuseIdentifier:JMOderInfoBtnTableViewCellIdentifier];
        
    }
    return _tableView;
}

-(JMAfterSalesInfoConfigure *)cellConfigures{
    if (!_cellConfigures) {
        _cellConfigures = [[JMAfterSalesInfoConfigure alloc]init];
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
