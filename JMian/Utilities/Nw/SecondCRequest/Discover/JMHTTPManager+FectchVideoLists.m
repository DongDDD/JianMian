//
//  JMHTTPManager+FectchVideoLists.m
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+FectchVideoLists.h"

@implementation JMHTTPManager (FectchVideoLists)

- (void)fectchVideoList_mode:(NSString *)mode
                     city_id:(nullable NSString *)city_id
                        type:(nullable NSString *)type
               contact_phone:(nullable NSString *)contact_phone
                    per_page:(nullable NSString *)per_page
                    successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic =  @{
                           @"mode":mode,
                           @"city_id":city_id,
                           @"type":type,
                           @"contact_phone":contact_phone,
                           @"per_page":per_page,
                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Fectch_VideoList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}

-(void)recordLookTimesWithVideoID:(NSString *)videoID
                             mode:(NSString *)mode
                     successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    NSString *urlStr = [Record_VideoLook_URL stringByAppendingFormat:@"/%@",videoID];
    NSDictionary *dic =  @{
                           @"mode":mode,

                           };
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:urlStr parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}



@end
