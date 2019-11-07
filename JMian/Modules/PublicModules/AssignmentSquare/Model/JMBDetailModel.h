//
//  JMBDetailModel.h
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBDetailModel : NSObject
@property(nonatomic, copy)NSString *share_url;
//@property(nonatomic, copy)NSArray *images;

//@property(nonatomic, copy)NSString *user_nickname;
//@property(nonatomic, copy)NSString *user_avatar;
//@property(nonatomic, copy)NSString *user_id;

@property(nonatomic, copy)NSString *favorites_id;

@property(nonatomic, copy)NSString *type_label_name;
@property(nonatomic, copy)NSString *type_label_label_id;

@property (copy, nonatomic) NSString *ability_id;
@property (copy, nonatomic) NSString *myDescription;
@property (copy, nonatomic) NSString *status;

@property (copy, nonatomic) NSString *user_userId;
@property (copy, nonatomic) NSString *user_companyId;
@property (copy, nonatomic) NSString *user_nickname;
@property (copy, nonatomic) NSString *user_avatar;
@property (copy, nonatomic) NSString *user_reputation;

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
@interface JMBDetailImageModel : NSObject

@property(nonatomic, copy)NSString *file_path;
@property(nonatomic, copy)NSString *status;


@end
@interface JMBDetailIndustryModel : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *label_id;


@end

NS_ASSUME_NONNULL_END
