//
//  JMAfterSalesInfoViewController.h
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMAfterSalesInfoViewTypeWait,
    JMAfterSalesInfoViewTypeRefuse,
    JMAfterSalesInfoViewTypeBeingAfterSales,
    JMAfterSalesInfoViewTypeSetRefund,
    JMAfterSalesInfoViewTypeRefuseRefund,//商家拒绝退款 9
    JMAfterSalesInfoViewTypeWaitGoodsReturn,
    JMAfterSalesInfoViewTypeCDidDeliverGoods,//买家已发货


} JMAfterSalesInfolViewType;

@interface JMAfterSalesInfoViewController : BaseViewController
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,assign)JMAfterSalesInfolViewType viewType;
@end

NS_ASSUME_NONNULL_END
