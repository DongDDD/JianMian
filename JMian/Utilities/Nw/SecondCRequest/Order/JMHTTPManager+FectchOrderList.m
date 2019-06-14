//
//  JMHTTPManager+FectchOrderList.m
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchOrderList.h"

@implementation JMHTTPManager (FectchOrderList)
- (void)fectchOrderList_order_id:(nullable NSArray *)order_id
                   contact_city:(nullable NSString *)contact_city
                  contact_phone:(nullable NSString *)contact_phone
                         status:(nullable NSString *)status
                         s_date:(nullable NSString *)s_date
                         e_date:(nullable NSString *)e_date
                           page:(nullable NSString *)page
                       per_page:(nullable NSString *)per_page
                   successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"order_id":order_id,
                           @"contact_city":contact_city,
                           @"contact_phone":contact_phone,
                           @"status":status,
                           @"s_date":s_date,
                           @"e_date":e_date,
                           @"page":page,
                           @"per_page":per_page,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_OrderList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

@end
