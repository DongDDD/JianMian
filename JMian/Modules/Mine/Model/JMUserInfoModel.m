//
//  JMUserInfoModel.m
//  JMian
//
//  Created by chitat on 2019/4/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserInfoModel.h"
#import <MJExtension.h>

@implementation JMUserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"realName":@"real.name",@"realSex":@"real.sex",@"realBirthday":@"real.birthday",@"realStatus":@"real.status"};
}

@end
