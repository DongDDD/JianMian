//
//  JMHTTPManager+DeleteGoodsImage.m
//  JMian
//
//  Created by mac on 2019/6/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHTTPManager+DeleteGoodsImage.h"

@implementation JMHTTPManager (DeleteGoodsImage)
- (void)deleteGoodsImageWithFile_id:(NSString *)File_id
                 successBlock:(JMHTTPRequestCompletionSuccessBlock)successBlock failureBlock:(JMHTTPRequestCompletionFailureBlock)failureBlock {
    
    NSString *urlStr = [Delete_GoodsImage_URL stringByAppendingFormat:@"/%@",File_id];
    
    [[JMHTTPRequest urlParametersWithMethod:JMRequestMethodDELETE path:urlStr parameters:nil] sendRequestWithCompletionBlockWithSuccess:successBlock failure:failureBlock];
    
}
@end
