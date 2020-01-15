//
//  JMSendCustumMsg.h
//  JMian
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMSendCustumMsg : NSObject

+(void)setCustumMessage_receiverID:(NSString *)receiverID dic:(NSDictionary * __nonnull)dic title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
