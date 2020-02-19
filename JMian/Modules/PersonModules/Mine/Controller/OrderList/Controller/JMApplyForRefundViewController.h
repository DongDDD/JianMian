//
//  JMApplyForRefundViewController.h
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"
//#import "JMOrderCellData.h"
#import "JMOrderInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMApplyForRefundViewTypeRefund,
    JMApplyForRefundViewTypeAfterSales,
} JMApplyForRefundViewType;

@interface JMApplyForRefundViewController : BaseViewController
@property(nonatomic,assign)JMApplyForRefundViewType viewType;
//@property(nonatomic,strong)JMOrderCellData *data;
@property (strong, nonatomic) JMOrderInfoModel *model;

//@property(nonatomic,strong)NSArray *goods;

@end

NS_ASSUME_NONNULL_END
