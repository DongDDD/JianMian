//
//  JMMessageListModel.h
//  JMian
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@property(nonatomic,copy)NSString *work_work_name;


//腾讯云数据
@property (nonatomic, strong) NSString *convId;
@property (nonatomic, assign) TConvType convType;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) int unRead;

@end

NS_ASSUME_NONNULL_END
