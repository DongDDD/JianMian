//
//  JMVideoListCellData.h
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMVideoListCellData : NSObject

@property(nonatomic, copy)NSString *user_job_id;
@property(nonatomic, copy)NSString *user_id;
@property(nonatomic, copy)NSString *job_label_id;

@property(nonatomic, copy)NSString *user_user_id;
@property(nonatomic, copy)NSString *user_nickname;
@property(nonatomic, copy)NSString *user_avatar;
@property(nonatomic, copy)NSString *user_reputation;
@property(nonatomic, copy)NSString *user_amigo;

@property(nonatomic, copy)NSString *vita_work_start_date;
@property(nonatomic, copy)NSString *vita_work_status;
@property(nonatomic, copy)NSString *vita_education;
@property(nonatomic, copy)NSString *vita_description;

@property(nonatomic, copy)NSString *work_label_id;
@property(nonatomic, copy)NSString *work_name;

@property(nonatomic, copy)NSString *video_user_id;
@property(nonatomic, copy)NSString *video_file_id;
@property(nonatomic, copy)NSString *video_type;
@property(nonatomic, copy)NSString *video_file_path;
@property(nonatomic, copy)NSString *video_status;
@property(nonatomic, copy)NSString *video_denial_reason;
@property(nonatomic, copy)NSString *video_cover;



//C端视频data
@property(nonatomic, copy)NSString *company_id;
@property(nonatomic, copy)NSString *company_name;
@property(nonatomic, copy)NSString *city_id;
@property(nonatomic, copy)NSString *logo_path;

@property(nonatomic, copy)NSString *city_city_id;
@property(nonatomic, copy)NSString *city_city_name;

@property(nonatomic, copy)NSArray *labels;
@property(nonatomic, copy)NSArray *video;

@end

@interface JMCVideoLabsModel : NSObject

@property(nonatomic, copy)NSString *company_id;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *pivot_company_id;
@property(nonatomic, copy)NSString *pivot_label_id;

@end

@interface JMCVideoModel : NSObject

@property(nonatomic, copy)NSString *file_path;
@property(nonatomic, copy)NSString *status;
@property(nonatomic, copy)NSString *denial_reason;
@property(nonatomic, copy)NSString *file_id;
@property(nonatomic, copy)NSString *company_id;
@property(nonatomic, copy)NSString *cover;

@end

NS_ASSUME_NONNULL_END
