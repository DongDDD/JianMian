//
//  JMCompanyInfoModel.h
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCompanyInfoModel : NSObject

@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *abbreviation;
@property (nonatomic, copy) NSString *work_time;
@property (nonatomic, copy) NSString *work_week;

@property (nonatomic, copy) NSString *type_label_id;
@property (nonatomic, copy) NSString *type_label_label_id;
@property (nonatomic, copy) NSString *type_label_name;


@property (nonatomic, copy) NSString *industry_label_id;
@property (nonatomic, copy) NSString *industry_name;


@property (nonatomic, copy) NSString *financing;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *city_city_id;
@property (nonatomic, copy) NSString *city_city_name;
@property (nonatomic, copy) NSString *city_name_relation;


@property (nonatomic, strong) NSArray *files;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *subways;
@property (nonatomic, strong) NSArray *video;
@property (nonatomic, strong) NSArray *work;


@property (nonatomic, copy) NSString *employee;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *comDescription;
@property (nonatomic, copy) NSString *reg_capital;
@property (nonatomic, copy) NSString *reg_date;
@property (nonatomic, copy) NSString *reg_address;
@property (nonatomic, copy) NSString *unified_credit_code;
@property (nonatomic, copy) NSString *business_scope;
@property (nonatomic, copy) NSString *license_path;
@property (nonatomic, copy) NSString *logo_path;
@property (nonatomic, copy) NSString *status;


@end

@interface JMFilesModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *files_file_path;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *file_id;
@property (nonatomic, copy) NSString *file_cover;
@property (nonatomic, copy) NSString *denial_reason;



@end

@interface JMlabelsModel : NSObject

@property (nonatomic, copy) NSString *labels_name;

@end

@interface JMSubwaysModel : NSObject

@property (nonatomic, copy) NSString *subways_line;
@property (nonatomic, copy) NSString *subways_station;

@end

@interface JMWorkModel : NSObject

@property (nonatomic, copy) NSString *company_id;
@property (nonatomic, copy) NSString *work_label_id;
@property (nonatomic, copy) NSString *work_id;
@property (nonatomic, copy) NSString *work_name;
@property (nonatomic, copy) NSString *education;
@property (nonatomic, copy) NSString *work_experience_min;
@property (nonatomic, copy) NSString *work_experience_max;
@property (nonatomic, copy) NSString *salary_min;
@property (nonatomic, copy) NSString *salary_max;
@property (nonatomic, copy) NSString *workDescription;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *city_name;

@end

NS_ASSUME_NONNULL_END
