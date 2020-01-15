//
//  JMHTTPManager+GetCategoryList.m
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMHTTPManager+GetCategoryList.h"

@implementation JMHTTPManager (GetCategoryList)

- (void)getCategoryListWithFormat:(NSString *)format
successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"format":format};
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodGET path:Get_CategoryList_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
