//
//  JMInterVIewModel.h
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMInterViewModel : NSObject

@property (nonatomic, copy) NSString *user_job_id;
@property (nonatomic, copy) NSString *interview_id;
@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *company_company_name;
@property (nonatomic, copy) NSString *company_logo_path;
@property (nonatomic, copy) NSString *company_company_id;

@property (nonatomic, copy) NSString *work_status;
@property (nonatomic, copy) NSString *work_work_id;
@property (nonatomic, copy) NSString *work_salary_min;
@property (nonatomic, copy) NSString *work_salary_max;
@property (nonatomic, copy) NSString *work_work_name;

@property (nonatomic, copy) NSString *candidate_user_id;
@property (nonatomic, copy) NSString *candidate_nickname;
@property (nonatomic, copy) NSString *candidate_avatar;

@property (nonatomic, copy) NSString *work_id;

@property (nonatomic, copy) NSString *vita_work_start_date;
@property (nonatomic, copy) NSString *vita_work_work_status;
@property (nonatomic, copy) NSString *vita_work_education;

@property (nonatomic, copy) NSString *candidate_id;

@property (nonatomic, copy) NSString *interviewer_id;

@property (nonatomic, copy) NSString *interviewer_user_id;
@property (nonatomic, copy) NSString *interviewer_nickname;
@property (nonatomic, copy) NSString *interviewer_avatar;

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *hire;













@end

NS_ASSUME_NONNULL_END
