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
@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, strong) NSString *work_id;
@property (nonatomic, strong) NSString *company_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *job_label_id;
@property (nonatomic, copy) NSString *work_label_label_id;
@property (nonatomic, copy) NSString *work_label_id;
@property (nonatomic, copy) NSString *work_label_name;
@property (nonatomic, copy) NSString *work_name;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *work_experience_min;
@property (nonatomic, strong) NSString *work_experience_max;
@property (nonatomic, strong) NSString *salary_min;
@property (nonatomic, strong) NSString *salary_max;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, copy) NSString *user_avatar;
@property (nonatomic, copy) NSString *user_nickname;


@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *companyLogo_path;
@property (nonatomic, copy) NSString *companyFinancing;
@property (nonatomic, copy) NSString *companyEmployee;
@property (nonatomic, copy) NSString *companyCityId;
@property (nonatomic, strong) NSArray *companyLabels;
@property (nonatomic, copy) NSString *companyIndustry_label;
@property (nonatomic, copy) NSString *companyCity;

@property (nonatomic, copy) NSString *videoCompanyId;
@property (nonatomic, copy) NSString *videoFile_path;
@property (nonatomic, copy) NSString *videoStatus;
@property (nonatomic, copy) NSString *videoDenial_reason;

@property (nonatomic, strong) NSArray *files;


@end

@interface JMComFilesModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *denial_reason;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *file_path;

@end


NS_ASSUME_NONNULL_END
