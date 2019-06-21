//
//  JMBDetailModel.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailModel.h"

@implementation JMBDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"JMBDetailImageModel",
             
             };
}


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"user_nickname":@"user.nickname",
             @"user_avatar":@"user.avatar",
             @"user_id":@"user.user_id",

             @"type_label_name":@"type.label_name",
             
             };
    
}
@end

@implementation JMBDetailImageModel


@end
