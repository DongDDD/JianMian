//
//  JMCreatChatAction.h
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCreatChatAction : NSObject
+(void)createC2CTypeChatRequstWithChat_type:(NSString *)chat_type
                                foreign_key:(NSString *)foreign_key
                                    user_id:(NSString *)user_id
                                sender_mark:(nullable NSString *)sender_mark
                             recipient_mark:(nullable NSString *)recipient_mark;
+(void)create4TypeChatRequstWithAccount:(NSString *)account;
@end

NS_ASSUME_NONNULL_END
