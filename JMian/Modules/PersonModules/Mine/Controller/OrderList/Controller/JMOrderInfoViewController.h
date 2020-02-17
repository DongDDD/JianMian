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
     JMOrderInfoViewSetRefund,//对方发起退款
    JMOrderInfoViewTypeRefuseRefund,//卖家拒绝退款
    JMOrderInfoViewTypeDidRefund,
    JMOrderInfoViewTypeWaitSalesReturn,
    JMOrderInfoViewTypeWaitDeliverGoods,
    JMOrderInfoViewTypeNoPay,
    JMOrderInfoViewDidDeliverGoods,
    JMOrderInfoViewTakeDeliveryGoods,//已收货
    JMOrderInfoViewFinish,//交易完成
    JMOrderInfoViewWaitRefund,//等待退货
    JMOrderInfoViewAfterSales,//售后中


};

@interface JMOrderInfoViewController : BaseViewController
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,assign)JMOrderInfoViewType viewType;
@property(nonatomic,assign)BOOL isExtension;
@end

NS_ASSUME_NONNULL_END
