//
//  JMVersionModel.m
//  JMian
//
//  Created by mac on 2019/7/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVersionModel.h"

@implementation JMVersionModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"appDescription":@"description",
   
             };
    
}
@end
