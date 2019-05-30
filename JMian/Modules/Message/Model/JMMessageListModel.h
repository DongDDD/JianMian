//
//  JMMessageListModel.h
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMAllMessageTableViewCellData.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TConvType) {
    TConv_Type_C2C      = 1,
    TConv_Type_Group    = 2,
    TConv_Type_System   = 3,
};

@interface JMMessageListModel : NSObject
//后台数据
@property(nonatomic,copy)NSString *sender_user_id;
@property(nonatomic,copy)NSString *sender_type;
@property(nonatomic,copy)NSString *sender_avatar;
@property(nonatomic,copy)NSString *sender_nickname;
@property(nonatomic,copy)NSString *sender_company_position;

@property(nonatomic,copy)NSString *sender_mark; 
@property(nonatomic,copy)NSString *recipient_mark;


@property(nonatomic,copy)NSString *recipient_user_id;
@property(nonatomic,copy)NSString *recipient_type;
@property(nonatomic,copy)NSString *recipient_avatar;
@property(nonatomic,copy)NSString *recipient_nickname;
@property(nonatomic,copy)NSString *recipient_company_position;

@property(nonatomic,copy)NSString *work_work_id;
@property(nonatomic,copy)NSString *work_description;
@property(nonatomic,copy)NSString *work_salary_max;
@property(nonatomic,copy)NSString *work_salary_min;
@property(nonatomic,copy)NSString *work_work_name;
@property(nonatomic,copy)NSString *work_education;
@property(nonatomic,copy)NSString *work_work_experience_min;
@property(nonatomic,copy)NSString *work_work_experience_max;

//workInfo是一个对象
@property (copy, nonatomic) NSString *workInfo_company_name;
@property (copy, nonatomic) NSString *workInfo_financing;
@property (copy, nonatomic) NSString *workInfo_company_id;
@property (copy, nonatomic) NSString *workInfo_logo_path;
@property (copy, nonatomic) NSString *workInfo_industry;
@property (copy, nonatomic) NSString *workInfo_employee;
@property (copy, nonatomic) NSString *workInfo_industry_label_id;


@property(nonatomic,copy)NSString *job_user_job_id;
@property(nonatomic,copy)NSString *chat_id;
//腾讯云数据
@property (nonatomic, strong) JMAllMessageTableViewCellData *data;


@end



NS_ASSUME_NONNULL_END
