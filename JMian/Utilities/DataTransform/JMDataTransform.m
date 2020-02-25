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


#pragma mark - ============== 正则去除HTML标签 ==============
+ (NSString *)getNormalStringFilterHTMLString:(NSString *)htmlStr{
    NSString *normalStr = htmlStr.copy;
    //判断字符串是否有效
    if (!normalStr || normalStr.length == 0 || [normalStr isEqual:[NSNull null]]) return nil;
    
    //过滤正常标签
    NSRegularExpression *regularExpression=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
    normalStr = [regularExpression stringByReplacingMatchesInString:normalStr options:NSMatchingReportProgress range:NSMakeRange(0, normalStr.length) withTemplate:@""];
    
    //过滤占位符
    NSRegularExpression *plExpression=[NSRegularExpression regularExpressionWithPattern:@"&[^;]+;" options:NSRegularExpressionCaseInsensitive error:nil];
    normalStr = [plExpression stringByReplacingMatchesInString:normalStr options:NSMatchingReportProgress range:NSMakeRange(0, normalStr.length) withTemplate:@""];
    
    //过滤空格
    NSRegularExpression *spaceExpression=[NSRegularExpression regularExpressionWithPattern:@"^\\s*|\\s*$" options:NSRegularExpressionCaseInsensitive error:nil];
    normalStr = [spaceExpression stringByReplacingMatchesInString:normalStr options:NSMatchingReportProgress range:NSMakeRange(0, normalStr.length) withTemplate:@""];

    return normalStr;
}


+(NSString *)getSalaryRangeWithArr:(NSArray *)arr{
    NSString *result;
    if (arr.count == 1) {
        result = arr[0];
    }else{
        //最大值
        double max_value = [[arr valueForKeyPath:@"@max.doubleValue"] doubleValue];
        //        int max_value2 =  fabs(max_value);
        //最小值
        double min_value = [[arr valueForKeyPath:@"@min.doubleValue"] doubleValue];
        
        NSString *min_str = [NSString stringWithFormat:@"%f",min_value];
        NSString *min_str2 = [JMDataTransform returnFormatter:min_str];
        
        NSString *max_str = [NSString stringWithFormat:@"%f",max_value];
        NSString *max_str2 = [JMDataTransform returnFormatter:max_str];
        if (max_value == min_value) {
            result  = max_str2;
        }else{
            result = [NSString stringWithFormat:@"%@~%@",min_str2,max_str2];
            
        }
        
    }
    
    return result;
}

+(BOOL)isInTimeWithS_date:(NSString *)s_date e_date:(NSString *)e_date{
    
    NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
    NSString *s_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",s_date];
    NSString *e_timeStr = [NSString stringWithFormat:@"%@ 00:00:00",e_date];
    NSDate *s_Date= [self dateFromString:s_timeStr];
    NSDate *e_Date= [self dateFromString:e_timeStr];
    
    int s_result = [self compareOneDay:currentDate withAnotherDay:s_Date];
    int e_result = [self compareOneDay:currentDate withAnotherDay:e_Date];
    //s_Date < current < e_Date 在活动时间内
    if (s_result == 1 && e_result == -1) {
        return YES;
        
    }else if((s_result == 0 || e_result == 0)){
        return YES;
    }
    return NO;
}

+ (NSDate *)dateFromString:(NSString *)dateStr{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    // 注意的是下面给格式的时候,里面一定要和字符串里面的统一
    // 比如:   dateStr为2017-07-24 17:38:27   那么必须设置成yyyy-MM-dd HH:mm:ss, 如果你设置成yyyy--MM--dd HH:mm:ss, 那么date就是null, 这是需要注意的
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate * date = [formatter dateFromString:dateStr];
    return date;
    
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    NSLog(@"两者时间是同一个时间");
    return 0;
    
}

@end
