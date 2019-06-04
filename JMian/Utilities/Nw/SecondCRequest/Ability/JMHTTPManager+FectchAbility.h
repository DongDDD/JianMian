//
//  JMHTTPManager+FectchAbility.h
//  JMian
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMHTTPManager (FectchAbility)
- (void)fectchAbilityList_city_id:(nullable NSString *)city_id
                    type_label_id:(nullable NSString *)type_label_id
                     industry_arr:(nullable NSMutableArray *)industry_arr
                    myDescription:(nullable NSString *)myDescription
                       video_path:(nullable NSString *)video_path
                      video_cover:(nullable NSString *)video_cover
                        image_arr:(nullable NSArray *)image_arr
                           status:(nullable NSString *)status
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
