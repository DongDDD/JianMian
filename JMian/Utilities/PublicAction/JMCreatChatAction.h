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
//类型聊天
+(void)createC2CTypeChatRequstWithChat_type:(NSString *)chat_type
                                foreign_key:(NSString *)foreign_key
                                    user_id:(NSString *)user_id
                                sender_mark:(nullable NSString *)sender_mark
                             recipient_mark:(nullable NSString *)recipient_mark;
//通用聊天
+(void)create4TypeChatRequstWithAccount:(NSString *)account;
//客服聊天
+(void)createServiceTypeChatRequstWithChat_type:(NSString *)chat_type
                                    foreign_key:(NSString *)foreign_key
                                        user_id:(NSString *)user_id
                                    sender_mark:(nullable NSString *)sender_mark
                                 recipient_mark:(nullable NSString *)recipient_mark;
/// 客服聊天
+(void)createServiceChat;
@end

NS_ASSUME_NONNULL_END
