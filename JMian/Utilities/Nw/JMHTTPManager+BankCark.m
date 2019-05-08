//
//  JMHTTPManager+BankCark.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+BankCark.h"

@implementation JMHTTPManager (BankCark)

- (void)fecthBankCardList_bank_id:(nullable NSString *)bank_id
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{@"bank_id":bank_id};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fetch_BankCardList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)createBankCard_full_name:(NSString *)full_name
                       bank_name:(NSString *)bank_name
                     card_number:(NSString *)card_number
                     bank_branch:(nullable NSString *)bank_branch
                      image_path:(nullable NSString *)image_path
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"full_name":full_name,
                           @"bank_name":bank_name,
                           @"card_number":card_number,
                           @"bank_branch":bank_branch,
                           @"image_path":image_path
                           };
    
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Create_BankCard_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

- (void)deleteBankCard_Id:(NSString *)Id
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Delete_BankCard_URL stringByAppendingFormat:@"/%@",Id];

    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
