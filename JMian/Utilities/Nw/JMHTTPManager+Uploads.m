//
//  JMHTTPManager+Uploads.m
//  JMian
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+Uploads.h"
#import "APIStringMacros.h"


@implementation JMHTTPManager (Uploads)

- (void)uploadsWithFiles:(NSArray *)files successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"files":files};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodUpload path:Uploads_Image_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}


- (void)uploadsWithMP4Files:(NSArray *)files successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSDictionary *dic = @{@"files":files};
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodUploadMP4 path:Uploads_Image_URL parameters:dic] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}




@end
