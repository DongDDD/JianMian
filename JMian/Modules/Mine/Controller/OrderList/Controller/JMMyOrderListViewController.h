//
//  JMMyOrderListViewController.h
//  JMian
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMMyOrderListViewControllerCUser,
    JMMyOrderListViewControllerBUser,
} JMMyOrderListViewType;


@interface JMMyOrderListViewController : BaseViewController
@property(nonatomic, assign)JMMyOrderListViewType viewType;

@end

NS_ASSUME_NONNULL_END
