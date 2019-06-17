//
//  JMPartTimeJobLikeModel.h
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBPartTimeJobLikeModel : NSObject
@property (nonatomic, copy) NSString *ability_type_label_name;
@property (nonatomic, copy) NSString *ability_typeLabel_id;
@property (nonatomic, copy) NSString *ability_description;
@property (nonatomic, copy) NSString *ability_ability_id;

@property (nonatomic, strong) NSArray *ability_industry;

@property (nonatomic, copy) NSString *ability_user_reputation;
@property (nonatomic, copy) NSString *ability_user_user_id;
@property (nonatomic, copy) NSString *ability_user_nickname;
@property (nonatomic, copy) NSString *ability_user_company_id;
@property (nonatomic, copy) NSString *ability_user_avatar;

@property (nonatomic, copy) NSString *favorite_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *foreign_key;



@end

@interface JMBLikeIndustryModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *label_id;

@end

NS_ASSUME_NONNULL_END
