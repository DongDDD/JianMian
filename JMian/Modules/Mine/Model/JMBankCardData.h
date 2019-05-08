//
//  JMBankCardData.h
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBankCardData : NSObject

@property (copy, nonatomic) NSString *bank_card_id;
@property (copy, nonatomic) NSString *bank_id;
@property (copy, nonatomic) NSString *full_name;
@property (copy, nonatomic) NSString *bank_name;
@property (copy, nonatomic) NSString *bank_branch;
@property (copy, nonatomic) NSString *card_number;
@property (copy, nonatomic) NSString *created_at;

@property (copy, nonatomic) NSString *user_user_id;
@property (copy, nonatomic) NSString *user_avatar;
@property (copy, nonatomic) NSString *user_nickname;
@property (copy, nonatomic) NSString *user_phone;

@end

NS_ASSUME_NONNULL_END
