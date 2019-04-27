//
//  JMCompanyInfoModel.m
//  JMian
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyInfoModel.h"

@implementation JMCompanyInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"industry_name":@"industry_label.name",
             @"industry_label_id":@"industry_label.label_id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"labels":@"JMlabelsModel",
             @"subways":@"JMShieldingModel",
             @"subways":@"JMSubwaysModel"
             };
}

@end


@implementation JMlabelsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"labels_name":@"name",
             };
}

@end


@implementation JMFilesModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"files_type":@"type",
             @"files_file_path":@"file_path",
             };
}
@end

@implementation JMSubwaysModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"subways_line":@"line",
             @"subways_station":@"station",
             };
}

@end

    
    

