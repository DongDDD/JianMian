//
//  JMSpecialModel.m
//  JMian
//
//  Created by mac on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSpecialModel.h"

@implementation JMSpecialModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{
             @"myId":@"id",
             @"myDescription":@"description",
             };
}

@end
