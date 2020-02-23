//
//  JMOrderInfoViewController.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMOrderInfoViewType){
    JMOrderInfoViewTypeSuccessfully = 0,
    JMOrderInfoViewTypeDidRefund,//已退款
    JMOrderInfoViewTypeDidDeleteOrder,//订单已取消 1
     JMOrderInfoViewSetRefund,//对方发起退款
    JMOrderInfoViewTypeRefuseRefund,//卖家拒绝退款 9
    JMOrderInfoViewTypeWaitGoodsReturn,//等待退货
    JMOrderInfoViewTypeWaitSalesReturn,
    JMOrderInfoViewTypeWaitDeliverGoods,
    JMOrderInfoViewTypeNoPay,// 0
    JMOrderInfoViewTypeDidPay,
    JMOrderInfoViewDidDeliverGoods,//已发货 6
    JMOrderInfoViewTakeDeliveryGoods,//已收货 12
    JMOrderInfoViewFinish,//交易完成
    JMOrderInfoViewWaitRefund,//等待退货
    JMOrderInfoViewAfterSales,//售后中
    JMOrderInfoViewCDidDeliverGoods,//买家已发货/已退货 10 


};

@interface JMOrderInfoViewController : BaseViewController
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,assign)JMOrderInfoViewType viewType;
@property(nonatomic,assign)BOOL isExtension;
@end

NS_ASSUME_NONNULL_END
