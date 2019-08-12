//
//  JMSnapshotWebViewController.h
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBaseWebViewController.h"
#import "JMTaskOrderListCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMSnapshotWebViewController : JMBaseWebViewController

@property(nonatomic, strong)JMTaskOrderListCellData *data;

@end

NS_ASSUME_NONNULL_END
