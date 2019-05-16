//
//  JMHTTPManager+IDcard.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+IDcard.h"
#import "APIStringMacros.h"
@implementation JMHTTPManager (IDcard)

- (void)identifyIDcardWithFiles:(NSArray *)files
                    card_side:(NSString *)card_side
successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock{
   
    NSDictionary *dic = @{@"files":files,@"card_side":card_side};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodPOST path:Ocr_idcard_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


@end
