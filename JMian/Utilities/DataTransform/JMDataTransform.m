//
//  JMDataTransform.m
//  JMian
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMDataTransform.h"

@implementation JMDataTransform

//学历数据转化 数字 转 文字
+(NSString *)getEducationStrWithEducationNum:(NSString *)educationNum{
    NSInteger myInt = [educationNum integerValue];
    
    switch (myInt) {
        case 0:
            return @"不限";
            break;
        case 1:
            return @"初中";
            break;
        case 2:
            return @"中专";
            break;
        case 3:
            return @"高中";
            break;
        case 4:
            return @"大专";
            break;
        case 5:
            return @"本科";
            break;
        case 6:
            return @"硕士";
            break;
        case 7:
            return @"博士";
            break;
            
        default:
            break;
    }
    return @"不限";
    
}


//学历数据转化 文字 转 数字
+(NSString *)getEducationNumWithEducationStr:(NSString *)educationStr{
    if ([educationStr isEqualToString:@"初中及以下"]) {
        return @"1";
        
    }else if ([educationStr isEqualToString:@"中专/中技"]){
        return @"2";
        
    }else if ([educationStr isEqualToString:@"高中"]){
        return @"3";
        
    }else if ([educationStr isEqualToString:@"大专"]){
        return @"4";
        
    }else if ([educationStr isEqualToString:@"本科"]){
        return @"5";
        
    }else if ([educationStr isEqualToString:@"硕士"]){
        return @"6";
        
    }else if ([educationStr isEqualToString:@"博士"]){
        return @"7";
        
    }
    
    return @"5";
    
}
@end
