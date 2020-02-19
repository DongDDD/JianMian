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

//工资数据转化，除以1000，转化成k
+(NSString *)getSalaryStrWithMin:(id)min max:(id)max{
    NSInteger myint = [min integerValue];
    NSInteger intMin = myint/1000;
    
    NSInteger myint2 = [max integerValue];
    NSInteger intMax = myint2/1000;
    
    NSString *salaryStr;
    salaryStr = [NSString stringWithFormat:@"%dk~%dk",  (int)intMin, (int)intMax];
    
    return salaryStr;
}

+(NSString*)returnFormatter:(NSString*)stringNumber

{
    
    stringNumber =[NSString stringWithFormat:@"%@",stringNumber];
    
    if([stringNumber rangeOfString:@"."].location==NSNotFound) {
        
        NSString* string_comp=[NSString stringWithFormat:@"%@.00",stringNumber];
        
        return string_comp;
        
    }
    
    else
        
    {
        
        NSArray* arrays= [stringNumber componentsSeparatedByString:@"."];
        
        NSString* s_f= [arrays objectAtIndex:0];
        
        NSString* s_e = [arrays objectAtIndex:1];
        
        if(s_e.length>2) {
            
            s_e=[s_e substringWithRange:NSMakeRange(0,2)];
            
        }
        
        else if(s_e.length==1)
            
        {
            
            s_e=[NSString stringWithFormat:@"%@0",s_e];
            
        }
        
        NSString* string_combine=[NSString stringWithFormat:@"%@.%@",s_f,s_e];
        
        return string_combine;
        
    }
    
    return @"";
    
}

@end
