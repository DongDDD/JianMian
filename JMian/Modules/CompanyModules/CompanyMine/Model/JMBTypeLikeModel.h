//
//  JMBTypeLikeModel.h
//  JMian
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBTypeLikeModel : NSObject

@property (nonatomic, copy) NSString *job_user_id;
@property (nonatomic, copy) NSString *job_salary_min;
@property (nonatomic, copy) NSString *job_salary_max;
@property (nonatomic, copy) NSString *job_user_nickname;
@property (nonatomic, copy) NSString *job_user_avatar;

@property (nonatomic, copy) NSString *job_vita_education;
@property (nonatomic, copy) NSString *job_vita_description;

@property (nonatomic, copy) NSString *job_work_name;
@property (nonatomic, copy) NSString *favorite_id;

@end

NS_ASSUME_NONNULL_END
