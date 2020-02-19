//
//  JMDataTransform.h
//  JMian
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMDataTransform : NSObject
///数字-文字
+(NSString *)getEducationStrWithEducationNum:(NSString *)educationNum;
///文字-数字
+(NSString *)getEducationNumWithEducationStr:(NSString *)educationStr;
/// 工资范围数据转化，除以1000，转化成k
/// @param min 最小值
/// @param max 最大值
+(NSString *)getSalaryStrWithMin:(id)min max:(id)max;
 
/// @param stringNumber 保留两位小数
+(NSString*)returnFormatter:(NSString*)stringNumber;
@end

NS_ASSUME_NONNULL_END
