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
#import "JMCreatChatAction.h"
#import "JMHTTPManager+ChangeOrderStatus.h"
#import "JMRefundDetailViewController.h"
#import "JMApplyForRefundViewController.h"
#import "JMAfterSalesInfoViewController.h"
#import "JMRefundCauseView.h"
@interface JMOrderInfoViewController ()<UITableViewDelegate,UITableViewDataSource,JMOderInfoBtnTableViewCellDelegate,JMRefundCauseViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)JMOrderInfoConfigure *cellConfigures;
@property(nonatomic,strong)JMRefundCauseView *refundCauseView;


@end

@implementation JMOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.refundCauseView];
     [self.refundCauseView setHidden:YES];
    [self getData];

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

-(void)deleteOrderStatus:(NSString *)status order_id:(NSString *)order_id msg:(NSString *)msg{
    [[JMHTTPManager sharedInstance]deleteOrderWithOrder_id:order_id status:status msg:msg successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功"
                                                      delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
        
    }];
}

//-(void)changOrderStatus:(NSString *)status order_id:(NSString *)order_id{
//    [[JMHTTPManager sharedInstance]changeOrderStatusWithOrder_id:order_id status:status successBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull responsObject) {
//        [self.tableView.mj_header beginRefreshing];
//
//    } failureBlock:^(JMHTTPRequest * _Nonnull request, id  _Nonnull error) {
//
//    }];
//}

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
        if (_viewType == JMOrderInfoViewTypeRefuseRefund) {
             vc.viewType = JMAfterSalesInfoViewTypeRefuseRefund;

        }else if (_viewType == JMOrderInfoViewAfterSales) {
            vc.viewType = JMAfterSalesInfoViewTypeBeingAfterSales;
        
        }else if (_viewType == JMOrderInfoViewTypeWaitGoodsReturn) {
            vc.viewType = JMAfterSalesInfoViewTypeWaitGoodsReturn;
        
        }else if (_viewType == JMOrderInfoViewSetRefund) {
            //对方发起退款
            vc.viewType = JMAfterSalesInfoViewTypeSetRefund;
        
        }else if (_viewType == JMOrderInfoViewCDidDeliverGoods) {
            //已退货
            vc.viewType = JMAfterSalesInfoViewTypeCDidDeliverGoods;
        
        }
        vc.order_id = self.cellConfigures.model.order_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTtitle isEqualToString:@"申请售后"]){
        JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
        vc.viewType = JMApplyForRefundViewTypeAfterSales;
        vc.model  = self.cellConfigures.model;
        vc.title = @"申请售后";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTtitle isEqualToString:@"联系卖家"]){
        NSString *user_id = [NSString stringWithFormat:@"%@b",self.cellConfigures.model.after_sale_boss_id];
        [JMCreatChatAction create4TypeChatRequstWithAccount:user_id];
    }else if ([btnTtitle isEqualToString:@"再次申请"]){
        JMApplyForRefundViewController *vc = [[JMApplyForRefundViewController alloc]init];
        vc.viewType = JMApplyForRefundViewTypeAfterSales;
        vc.model  = self.cellConfigures.model;
        vc.title = @"申请退款";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTtitle isEqualToString:@"取消订单"]){
        [self.refundCauseView show];

    }else if ([btnTtitle isEqualToString:@"客服介入"]){
        [JMCreatChatAction createServiceChat];

    }
 
}

-(void)submitActionWithMsg:(NSString *)msg{
    [self deleteOrderStatus:@"1" order_id:self.order_id msg:msg];
    

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isExtension == YES) {
        return 5;
    }else{
        return 6;
    }
    
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
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];

    switch (indexPath.section) {
        case JMOrderInfoTypeTitleHeader: {
            JMOrderInfoHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoHeaderTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_viewType == JMOrderInfoViewTypeSuccessfully) {
                 cell.titleLab.text = @"交易成功";
            }else if (_viewType == JMOrderInfoViewTypeDidRefund) {
                cell.titleLab.text = @"已退款";
            }else if (_viewType == JMOrderInfoViewTypeWaitSalesReturn) {
                cell.titleLab.text = @"等待退货";
            }else if (_viewType == JMOrderInfoViewTypeWaitDeliverGoods) {
                cell.titleLab.text = @"待发货";
            }else if (_viewType == JMOrderInfoViewTypeNoPay) {
                cell.titleLab.text = @"未付款";
            }else if (_viewType == JMOrderInfoViewDidDeliverGoods) {
                cell.titleLab.text = @"已发货";
//                if (!_isExtension) {
                [cell setOverTime:10 startTime:self.cellConfigures.model.logistics_at];
//                }
            }else if (_viewType == JMOrderInfoViewFinish) {
                cell.titleLab.text = @"交易完成";
            }else if (_viewType == JMOrderInfoViewWaitRefund) {
                cell.titleLab.text = @"等待退款";
            }else if (_viewType == JMOrderInfoViewTakeDeliveryGoods) {
                cell.titleLab.text = @"已收货";
//                if ([userModel.type isEqualToString:C_Type_USER]) {
                    if (_isExtension) {
                        cell.isExtension = YES;
                        [cell setOverTime:15 startTime:self.cellConfigures.model.logistics_at];
                    }
                    
//                }
            }else if (_viewType == JMOrderInfoViewAfterSales) {
                cell.titleLab.text = @"售后中";
            }else if (_viewType == JMOrderInfoViewSetRefund) {
                cell.titleLab.text = @"对方发起退款";
            }else if (_viewType == JMOrderInfoViewTypeRefuseRefund) {
                cell.titleLab.text = @"卖家拒绝退款";
            }else if (_viewType == JMOrderInfoViewTypeDidPay) {
                cell.titleLab.text = @"已付款";
            }else if (_viewType == JMOrderInfoViewTypeDidDeleteOrder) {
                cell.titleLab.text = @"已取消";
            }else if (_viewType == JMOrderInfoViewTypeWaitGoodsReturn) {
                cell.titleLab.text = @"等待退货";
            }else if (_viewType == JMOrderInfoViewCDidDeliverGoods) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    cell.titleLab.text = @"对方已发货";

                }else{
                    cell.titleLab.text = @"已退货";
                    
                }
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
            NSString *cover_path = [NSString stringWithFormat:@"%@%@",IMG_BASE_URL_STRING,data.cover_path];

            [cell setValuesWithImageUrl:cover_path title:data.title quantity:data.quantity price:data.price sku_mark:data.sku_mark];
            return cell;
        }
        case JMOrderInfoTypePrice: {
            JMOrderInfoPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoPriceTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            if (_viewType == JMOrderInfoViewTypeNoPay || _viewType == JMOrderInfoViewDidDeliverGoods || _viewType == JMOrderInfoViewTakeDeliveryGoods || _viewType == JMOrderInfoViewDidDeliverGoods) {
//            }else
                if (_viewType == JMOrderInfoViewTypeDidRefund || _viewType == JMOrderInfoViewTypeRefuseRefund){
                cell.titleLab.text = @"退款金额 ";
                [cell setPrice:self.cellConfigures.model.pay_amount];

            }else{
                cell.titleLab.text = @"订单金额 ";
                [cell setPrice:self.cellConfigures.model.order_amount];
            }
            return cell;
        }
        case JMOrderInfoTypeTimeMsg: {
            JMOrderInfoTimeMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOrderInfoTimeMsgTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setValuesWithTime1:self.cellConfigures.model.created_at time2:self.cellConfigures.model.pay_time logName:self.cellConfigures.model.logistics_name time4:self.cellConfigures.model.logistics_at_c time5:self.cellConfigures.model.logistics_at];
            return cell;
        }
        case JMOrderInfoTypeBtn: {
            JMOderInfoBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMOderInfoBtnTableViewCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            if (_viewType == JMOrderInfoViewTypeSuccessfully) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];                    
                }
            }else if (_viewType == JMOrderInfoViewTypeDidRefund) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];                    
                }
            }else if (_viewType == JMOrderInfoViewTypeWaitSalesReturn) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                        [cell.btn2 setHidden:NO];
                    }else{
                        [cell.btn6 setHidden:NO];
                        [cell.btn11 setHidden:NO];
                    }
                    [cell.btn8 setHidden:NO];
                
            }else if (_viewType == JMOrderInfoViewTypeWaitDeliverGoods) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];                    
                }
                [cell.btn8 setHidden:NO];

                
            }else if (_viewType == JMOrderInfoViewTypeNoPay) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    [cell.btn13 setHidden:NO];

                }
            }else if (_viewType == JMOrderInfoViewDidDeliverGoods) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    [cell.btn4 setHidden:NO];
                    
                }
                
            }else if (_viewType == JMOrderInfoViewTakeDeliveryGoods) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    [cell.btn4 setHidden:NO];
                    [cell.btn9 setHidden:NO];
                    
                }

            }else if (_viewType == JMOrderInfoViewFinish) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    
                }
                
            }else if (_viewType == JMOrderInfoViewWaitRefund) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    
                }
                [cell.btn8 setHidden:NO];
                
            }else if (_viewType == JMOrderInfoViewAfterSales) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    
                }
                [cell.btn8 setHidden:NO];
                
            }else if (_viewType == JMOrderInfoViewSetRefund) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                    
                }
                [cell.btn8 setHidden:NO];
                
            }else if (_viewType == JMOrderInfoViewTypeRefuseRefund) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];
                }
                [cell.btn8 setHidden:NO];
                
            }else if (_viewType == JMOrderInfoViewTypeDidPay) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                    [cell.btn6 setHidden:NO];

                }else{
                    [cell.btn11 setHidden:NO];
                    [cell.btn13 setHidden:NO];

                }
                
            }else if (_viewType == JMOrderInfoViewTypeDidDeleteOrder) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];

                }
                
            }else if (_viewType == JMOrderInfoViewTypeWaitGoodsReturn) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                }else{
                    [cell.btn11 setHidden:NO];

                }
                [cell.btn8 setHidden:NO];
                
            }else if (_viewType == JMOrderInfoViewCDidDeliverGoods) {
                if ([userModel.type isEqualToString:B_Type_UESR]) {
                    [cell.btn2 setHidden:NO];
                    [cell.btn8 setHidden:NO];
                    
                }else{
                    [cell.btn11 setHidden:NO];
                    [cell.btn8 setHidden:NO];
                }
                
                
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-30) style:UITableViewStyleGrouped];
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

-(JMRefundCauseView *)refundCauseView{
    if (!_refundCauseView) {
        _refundCauseView = [[JMRefundCauseView alloc]init];
        _refundCauseView.delegate = self;
        _refundCauseView.titleArray = @[@"不想买了",@"信息填写错误，重新拍" ,@"卖家缺货",@"点错了",@"其他原因"];
        _refundCauseView.titleLab.text = @"取消原因";
        _refundCauseView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _refundCauseView;
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
