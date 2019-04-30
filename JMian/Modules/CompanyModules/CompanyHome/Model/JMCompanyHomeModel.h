//
//  JMCompanyHomeModel.h
//  JMian
//
//  Created by mac on 2019/4/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCompanyHomeModel : NSObject

@property (nonatomic, strong) NSNumber *user_job_id;
@property (nonatomic, strong) NSNumber *user_id;

@property (nonatomic, strong) NSNumber *job_label_id;
@property (nonatomic, strong) NSNumber *industry_label_id;
@property (nonatomic, strong) NSNumber *city_id;
@property (nonatomic, strong) NSNumber *salary_min;
@property (nonatomic, strong) NSNumber *salary_max;


@property (nonatomic, copy) NSString *userNickname;
@property (nonatomic, copy) NSString *userAvatar;

@property (nonatomic, strong) NSDate *vitaWork_start_date;
@property (nonatomic, strong) NSNumber *vitaWork_status;
@property (nonatomic, strong) NSString *vitaEducation;

@property (nonatomic, copy) NSNumber *workLabel_id;
@property (nonatomic, copy) NSString *workName;

@property (nonatomic, strong) NSNumber *cityCity_id;
@property (nonatomic, copy) NSString *cityCity_name;
@property (nonatomic, strong) NSNumber *cityIs_hot;



@end

NS_ASSUME_NONNULL_END
