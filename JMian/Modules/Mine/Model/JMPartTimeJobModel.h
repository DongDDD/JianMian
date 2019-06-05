//
//  JMPartTimeJobModel.h
//  JMian
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMPartTimeJobModel : NSObject

@property (copy, nonatomic) NSString *ability_id;
@property (copy, nonatomic) NSString *myDescription;
@property (copy, nonatomic) NSString *status;

@property (copy, nonatomic) NSString *user_userId;
@property (copy, nonatomic) NSString *user_companyId;
@property (copy, nonatomic) NSString *user_nickname;
@property (copy, nonatomic) NSString *user_avatar;

@property (copy, nonatomic) NSString *city_cityId;
@property (copy, nonatomic) NSString *city_cityName;

@property (copy, nonatomic) NSString *type_labelId;
@property (copy, nonatomic) NSString *type_name;

@property (copy, nonatomic) NSString *video_file_id;
@property (copy, nonatomic) NSString *video_type;
@property (copy, nonatomic) NSString *video_cover;
@property (copy, nonatomic) NSString *video_file_path;
@property (copy, nonatomic) NSString *video_status;
@property (copy, nonatomic) NSString *video_denial_reason;



@property (copy, nonatomic) NSArray *industry;
@property (copy, nonatomic) NSArray *images;

@end

@interface JMIndustryModel : NSObject

@property (copy, nonatomic) NSString *label_id;
@property (copy, nonatomic) NSString *name;



@end

@interface JMImageModel : NSObject

@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *denial_reason;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *file_id;
@property (copy, nonatomic) NSString *file_path;



@end

NS_ASSUME_NONNULL_END
