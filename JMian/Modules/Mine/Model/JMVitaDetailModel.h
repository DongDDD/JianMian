//
//  JMVitaDetailModel.h
//  JMian
//
//  Created by chitat on 2019/4/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMVitaDetailModel : NSObject

@property (copy, nonatomic) NSString *user_job_id;

@property (copy, nonatomic) NSString *user_id;
@property (copy, nonatomic) NSString *job_label_id;
@property (copy, nonatomic) NSString *industry_label_id;
@property (copy, nonatomic) NSString *city_id;
@property (copy, nonatomic) NSString *salary_min;
@property (copy, nonatomic) NSString *salary_max;
@property (copy, nonatomic) NSString *user_nickname;
@property (copy, nonatomic) NSString *user_avatar;
@property (copy, nonatomic) NSString *vita_work_start_date;
@property (copy, nonatomic) NSString *vita_work_status;
@property (copy, nonatomic) NSString *vita_education;
@property (copy, nonatomic) NSString *vita_description;
@property (copy, nonatomic) NSString *work_start_date;
@property (copy, nonatomic) NSString *work_label_id;
@property (copy, nonatomic) NSString *work_name;
@property (copy, nonatomic) NSString *city_city_id;
@property (copy, nonatomic) NSString *city_name;
@property (copy, nonatomic) NSString *city_is_hot;
@property (copy, nonatomic) NSString *city_label_id;
@property (strong, nonatomic) NSArray *experiences;
@property (strong, nonatomic) NSArray *shielding;
@property (strong, nonatomic) NSArray *education;

@end

@interface JMExperiencesModel : NSObject

@property (copy, nonatomic) NSString *user_job_id;
@property (copy, nonatomic) NSString *experience_id;
@property (copy, nonatomic) NSString *start_date;
@property (copy, nonatomic) NSString *end_date;
@property (copy, nonatomic) NSString *experiences_description;
@property (copy, nonatomic) NSString *company_id;
@property (copy, nonatomic) NSString *company_name;
@property (copy, nonatomic) NSString *work_label_id;
@property (copy, nonatomic) NSString *work_name;

@end

@interface JMShieldingModel : NSObject

@property (copy, nonatomic) NSString *shielding_id;
@property (copy, nonatomic) NSString *company;
@property (copy, nonatomic) NSString *company_id;
@property (copy, nonatomic) NSString *company_name;

@end

@interface JMEducationModel : NSObject

@property (copy, nonatomic) NSString *education_id;
@property (copy, nonatomic) NSString *education;
@property (copy, nonatomic) NSString *major;
@property (copy, nonatomic) NSString *s_date;
@property (copy, nonatomic) NSString *e_date;
@property (copy, nonatomic) NSString *education_description;
@property (copy, nonatomic) NSString *school_name;


@end

NS_ASSUME_NONNULL_END
