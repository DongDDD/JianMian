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
    JMOrderInfoViewTypeDidRefund,
    JMOrderInfoViewTypeWaitSalesReturn,
    JMOrderInfoViewTypeWaitDeliverGoods,

};

@interface JMOrderInfoViewController : BaseViewController
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,assign)JMOrderInfoViewType viewType;
@end

NS_ASSUME_NONNULL_END
