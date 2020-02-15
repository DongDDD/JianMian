//
//  JMRefundDetailViewController.h
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMRefundDetailViewTypeWait,
    JMRefundDetailViewTypeRefuse,
} JMRefundDetailViewType;

@interface JMRefundDetailViewController : BaseViewController
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,assign)JMRefundDetailViewType viewType;
@end

NS_ASSUME_NONNULL_END
