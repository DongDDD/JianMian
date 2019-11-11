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
@end

NS_ASSUME_NONNULL_END
