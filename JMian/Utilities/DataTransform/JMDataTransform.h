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
//数字-文字
+(NSString *)getEducationStrWithEducationNum:(NSString *)educationNum;
//文字-数字
+(NSString *)getEducationNumWithEducationStr:(NSString *)educationStr;
//工资数据转化，除以1000，转化成k
+(NSString *)getSalaryStrWithMin:(id)min max:(id)max;
@end

NS_ASSUME_NONNULL_END
