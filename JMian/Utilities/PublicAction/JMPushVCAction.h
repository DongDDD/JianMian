//
//  JMPushVCAction.h
//  JMian
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 本文件包含跳转4大详情页的方法
 1.H5跳页面
 2.IM推送跳页面
 */
@interface JMPushVCAction : NSObject
+(void)gotoMyVCWithtypeStr:(NSString *)typeStr typeId:(NSString *)typeId;
@end

NS_ASSUME_NONNULL_END
