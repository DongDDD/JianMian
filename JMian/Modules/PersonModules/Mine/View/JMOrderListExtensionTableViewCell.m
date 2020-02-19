//
//  JMOrderListExtensionTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderListExtensionTableViewCell.h"
#import "JMGoodsListView.h"
#import "DimensMacros.h"
@interface JMOrderListExtensionTableViewCell ()
@property(nonatomic,strong)JMGoodsListView *goodsView;
@property(nonatomic,strong)JMOrderCellData *myData;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end
@implementation JMOrderListExtensionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setOrderCellData:(JMOrderCellData *)orderCellData{
    _myData = orderCellData;
    self.goodsView.goods = orderCellData.goods;
    [self.contentView addSubview:self.goodsView];
    NSString *str = [NSString stringWithFormat:@"%@ >",_myData.shop_shop_name];
    [self.titleLab setTitle:str forState:UIControlStateNormal];
    self.salaryLab.text = [NSString stringWithFormat:@"¥ %@",orderCellData.salary_amount];
    self.timeLab.text = orderCellData.pay_time;
    
//    [self.goodsView.tableView reloadData];
    if ([orderCellData.status isEqualToString:@"0"]) {
        [self.statusRightTopLab setHidden:NO];
        [self.statusRightTopLab setTitle:@"未付款" forState:UIControlStateNormal];
        [self.statusRightTopLab setEnabled:NO];
        
    }else if ([orderCellData.status isEqualToString:@"2"] || [orderCellData.status isEqualToString:@"6"]) {
        if ([orderCellData.status isEqualToString:@"2"]) {
            [self.didSendGoodsImageView setHidden:YES];
            
        }else{
            [self.didSendGoodsImageView setHidden:NO];
        }
        
        [self.statusRightTopLab setTitle:@"" forState:UIControlStateNormal];
        [self.statusRightTopLab setHidden:NO];
        
    }else if ([orderCellData.status isEqualToString:@"12"]) {
        [self.didSendGoodsImageView setHidden:YES];
        //确认收货后
           [self.statusRightTopLab setTitle:@"已收货" forState:UIControlStateNormal];
           [self.statusRightTopLab setEnabled:NO];
           [self.statusRightTopLab setHidden:NO];

           
       }else if ([orderCellData.status isEqualToString:@"1"]) {

           [self.statusRightTopLab setTitle:@"订单已取消" forState:UIControlStateNormal];
           [self.statusRightTopLab setEnabled:NO];
           [self.statusRightTopLab setHidden:NO];
           [self.didSendGoodsImageView setHidden:YES];

       }else if ([orderCellData.status isEqualToString:@"11"]) {
             //订单已退款
           [self.statusRightTopLab setTitle:@"已退款" forState:UIControlStateNormal];
           [self.statusRightTopLab setEnabled:NO];
           [self.statusRightTopLab setHidden:NO];
           [self.didSendGoodsImageView setHidden:YES];

       }else if ([orderCellData.status isEqualToString:@"7"]) {
           //申请退款中
           [self.statusRightTopLab setTitle:@"售后中" forState:UIControlStateNormal];
           [self.statusRightTopLab setEnabled:NO];
           [self.statusRightTopLab setHidden:NO];
           [self.didSendGoodsImageView setHidden:YES];

       }else if ([orderCellData.status isEqualToString:@"9"]) {
           //卖家拒绝退款
           [self.statusRightTopLab setTitle:@"卖家拒绝退款" forState:UIControlStateNormal];
           [self.statusRightTopLab setEnabled:NO];
           [self.statusRightTopLab setHidden:NO];
           [self.didSendGoodsImageView setHidden:YES];

       }else if ([orderCellData.status isEqualToString:@"8"]) {
           //等待退货
           [self.didSendGoodsImageView setHidden:YES];
           [self.statusRightTopLab setTitle:@"等待退货" forState:UIControlStateNormal];
           [self.statusRightTopLab setEnabled:NO];
           [self.statusRightTopLab setHidden:NO];
           
       }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(JMGoodsListView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[JMGoodsListView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.myData.goods.count*60)];
    }
    return _goodsView;
    
}

@end
