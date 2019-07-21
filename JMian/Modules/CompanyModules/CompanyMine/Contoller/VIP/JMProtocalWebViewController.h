//
//  JMProtocalWebViewController.h
//  JMian
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBaseWebViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMProtocalWebNoPay,
    JMProtocalWebDidPay,
} JMProtocalWebViewType;

@interface JMProtocalWebViewController : JMBaseWebViewController

@property(nonatomic,assign) JMProtocalWebViewType viewType;

@end

NS_ASSUME_NONNULL_END
