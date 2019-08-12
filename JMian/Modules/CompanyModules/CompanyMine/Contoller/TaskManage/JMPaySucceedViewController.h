//
//  JMPaySucceedViewController.h
//  JMian
//
//  Created by mac on 2019/6/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "JMTaskOrderListCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMPaySucceedViewController : BaseViewController

@property(nonatomic, copy)NSString *didPayMoney;
@property(nonatomic, strong)JMTaskOrderListCellData *data;

@end

NS_ASSUME_NONNULL_END
