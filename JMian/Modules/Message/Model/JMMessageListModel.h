//
//  JMMessageListModel.h
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMMessageListModel : NSObject

@property(nonatomic,copy)NSString *sender_user_id;
@property(nonatomic,copy)NSString *sender_type;
@property(nonatomic,copy)NSString *sender_avatar;
@property(nonatomic,copy)NSString *sender_nickname;
@property(nonatomic,copy)NSString *sender_company_position;


@property(nonatomic,copy)NSString *recipient_user_id;
@property(nonatomic,copy)NSString *recipient_type;
@property(nonatomic,copy)NSString *recipient_avatar;
@property(nonatomic,copy)NSString *recipient_nickname;
@property(nonatomic,copy)NSString *recipient_company_position;

@property(nonatomic,copy)NSString *work_work_name;


@end

NS_ASSUME_NONNULL_END
