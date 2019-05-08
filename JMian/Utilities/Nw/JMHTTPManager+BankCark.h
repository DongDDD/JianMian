//
//  JMHTTPManager+BankCark.h
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (BankCark)

- (void)fecthBankCardList_bank_id:(nullable NSString *)bank_id
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


- (void)createBankCard_full_name:(NSString *)full_name
                       bank_name:(NSString *)bank_name
                     card_number:(NSString *)card_number
                     bank_branch:(nullable NSString *)bank_branch
                      image_path:(nullable NSString *)image_path
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;


- (void)deleteBankCard_Id:(NSString *)Id
             successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
