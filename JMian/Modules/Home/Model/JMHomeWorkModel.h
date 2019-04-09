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

@property (nonatomic, strong) NSNumber *work_id;
@property (nonatomic, strong) NSNumber *company_id;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, copy) NSString *work_label_id;
@property (nonatomic, copy) NSString *work_name;
@property (nonatomic, strong) NSNumber *education;
@property (nonatomic, strong) NSNumber *work_experience_min;
@property (nonatomic, strong) NSNumber *work_experience_max;
@property (nonatomic, strong) NSNumber *salary_min;
@property (nonatomic, strong) NSNumber *salary_max;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *companyLogo_path;

//@property (nonatomic, strong) NSArray *labels;



@end

NS_ASSUME_NONNULL_END
