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
@property (nonatomic, copy) NSString *share_url;

@property (copy, nonatomic) NSString *myDescription;

@property (copy, nonatomic) NSString *user_job_id;
@property (copy, nonatomic) NSString *user_id;

@property (copy, nonatomic) NSString *favorites_favorite_id;
@property (copy, nonatomic) NSString *job_label_id;
@property (copy, nonatomic) NSString *industry_label_id;
@property (copy, nonatomic) NSString *city_id;
@property (copy, nonatomic) NSString *salary_min;
@property (copy, nonatomic) NSString *salary_max;
@property (copy, nonatomic) NSString *user_email;
@property (copy, nonatomic) NSString *user_phone;
@property (copy, nonatomic) NSString *user_nickname;
@property (copy, nonatomic) NSString *user_avatar;
@property (copy, nonatomic) NSString *vita_work_start_date;
@property (copy, nonatomic) NSString *work_status;
@property (copy, nonatomic) NSString *vita_education;
@property (copy, nonatomic) NSString *vita_description;
@property (copy, nonatomic) NSString *work_start_date;
@property (copy, nonatomic) NSString *work_label_id;
@property (copy, nonatomic) NSString *work_name;
@property (copy, nonatomic) NSString *city_city_id;
@property (copy, nonatomic) NSString *city_name;
@property (copy, nonatomic) NSString *city_is_hot;
@property (copy, nonatomic) NSString *city_label_id;

@property (copy, nonatomic) NSString *video_file_path;
@property (copy, nonatomic) NSString *video_status;
@property (copy, nonatomic) NSString *video_type;

@property (strong, nonatomic) NSArray *experiences;
@property (strong, nonatomic) NSArray *shielding;
@property (strong, nonatomic) NSArray *learning;//C我的简历 的
@property (strong, nonatomic) NSArray *files;
@property (strong, nonatomic) NSArray *jobs;
@property (strong, nonatomic) NSArray *education;//B看个人详情 的




@end


@interface JMMyJobsModel : NSObject

@property (nonatomic, copy) NSString *salary_max;
@property (nonatomic, copy) NSString *salary_min;
@property (nonatomic, copy) NSString *work_name;
@property (nonatomic, copy) NSString *job_label_id;
@property (nonatomic, copy) NSString *city_city_name;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *user_job_id;



@end

@interface JMMyFilesModel : NSObject

@property (nonatomic, copy) NSString *file_path;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *user_id;


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

@interface JMLearningModel : NSObject

@property (copy, nonatomic) NSString *education_id;
@property (copy, nonatomic) NSString *education;
@property (copy, nonatomic) NSString *major;
@property (copy, nonatomic) NSString *s_date;
@property (copy, nonatomic) NSString *e_date;
//@property (strong, nonatomic) NSDate *s_date;
//@property (strong, nonatomic) NSDate *e_date;
@property (copy, nonatomic) NSString *education_description;
@property (copy, nonatomic) NSString *school_name;

@end

//B端的model，个人详情页面
@interface JMEducationModel : NSObject

@property (copy, nonatomic) NSString *s_date;
@property (copy, nonatomic) NSString *major;
@property (copy, nonatomic) NSString *e_date;
@property (copy, nonatomic) NSString *education_id;
@property (copy, nonatomic) NSString *school_school_name;
//@property (strong, nonatomic) NSDate *s_date;
//@property (strong, nonatomic) NSDate *e_date;
@property (copy, nonatomic) NSString *education;
@property (copy, nonatomic) NSString *description;

@end

NS_ASSUME_NONNULL_END
