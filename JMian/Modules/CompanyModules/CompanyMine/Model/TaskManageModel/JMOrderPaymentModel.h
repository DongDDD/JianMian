//
//  JMOrderPaymentModel.h
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMOrderPaymentModel : NSObject
@property (nonatomic, copy) NSString *wx_sign;
@property (nonatomic, copy) NSString *wx_partnerid;
@property (nonatomic, copy) NSString *wx_package;
@property (nonatomic, copy) NSString *wx_noncestr;
@property (nonatomic, assign) UInt32 wx_timestamp;
@property (nonatomic, copy) NSString *wx_appid;
@property (nonatomic, copy) NSString *wx_prepayid;

@property (nonatomic, copy) NSString *serial_no;

@property (nonatomic, copy) NSString *alipay;

@end

NS_ASSUME_NONNULL_END
