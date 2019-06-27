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

@property (nonatomic, copy) NSString *share_url;

@property (nonatomic, copy) NSString *vita_description;
@property (nonatomic, copy) NSString *user_job_id;
@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *job_label_id;
@property (nonatomic, copy) NSString *industry_label_id;
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSNumber *salary_min;
@property (nonatomic, copy) NSNumber *salary_max;


@property (nonatomic, copy) NSString *userNickname;
@property (nonatomic, copy) NSString *userAvatar;

@property (nonatomic, strong) NSDate *vitaWork_start_date;
@property (nonatomic, strong) NSNumber *vitaWork_status;
@property (nonatomic, copy) NSString *vitaEducation;

@property (nonatomic, copy) NSNumber *workLabel_id;
@property (nonatomic, copy) NSString *workName;

@property (nonatomic, strong) NSNumber *cityCity_id;
@property (nonatomic, copy) NSString *cityCity_name;
@property (nonatomic, strong) NSNumber *cityIs_hot;

@property (nonatomic, copy) NSString *video_file_path;
@property (nonatomic, copy) NSString *video_status;




@end

NS_ASSUME_NONNULL_END
