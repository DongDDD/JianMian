//
//  JMOrderPaymentModel.m
//  JMian
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMOrderPaymentModel.h"

@implementation JMOrderPaymentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"wx_sign":@"wx.sign",
             @"wx_partnerid":@"wx.partnerid",
             @"wx_package":@"wx.package",
             @"wx_noncestr":@"wx.noncestr",
             @"wx_timestamp":@"wx.timestamp",
             @"wx_appid":@"wx.appid",
             @"wx_prepayid":@"wx.prepayid",
             
             };
}


@end
