//
//  JMHTTPManager+FectchTaskList.h
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchTaskList)

- (void)fectchTaskList_user_id:(nullable NSString *)user_id
                       city_id:(nullable NSString *)city_id
                 type_label_id:(nullable NSString *)type_label_id
                  industry_arr:(nullable NSMutableArray *)industry_arr
                        status:(nullable NSString *)status
                          page:(nullable NSString *)page
                      per_page:(nullable NSString *)per_page

                  successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
