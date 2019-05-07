//
//  JMHomeWorkModel.h
//  JMian
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMHomeWorkModel : NSObject

@property (nonatomic, strong) NSString *work_id;
@property (nonatomic, strong) NSString *company_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, copy) NSString *work_label_id;
@property (nonatomic, copy) NSString *work_name;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *work_experience_min;
@property (nonatomic, strong) NSString *work_experience_max;
@property (nonatomic, strong) NSString *salary_min;
@property (nonatomic, strong) NSString *salary_max;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSString *status;

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *companyLogo_path;
@property (nonatomic, copy) NSString *companyFinancing;
@property (nonatomic, copy) NSString *companyEmployee;
@property (nonatomic, copy) NSString *companyCityId;
@property (nonatomic, copy) NSString *companyAddress;
@property (nonatomic, copy) NSString *companyLongitude;
@property (nonatomic, copy) NSString *companyLatitude;
@property (nonatomic, strong) NSArray *companyLabels;
@property (nonatomic, copy) NSString *companyIndustry_label;
@property (nonatomic, copy) NSString *companyCity;

@property (nonatomic, copy) NSString *videoCompanyId;
@property (nonatomic, copy) NSString *videoCompanyFile_path;













//@property (nonatomic, strong) NSArray *labels;



@end

NS_ASSUME_NONNULL_END
