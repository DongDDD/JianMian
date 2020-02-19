//
//  JMWXShareAction.h
//  JMian
//
//  Created by mac on 2020/2/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMWXShareAction : NSObject

/// 微信分享
/// @param n 分享类型
/// @param title 标题
/// @param desc 描述
/// @param ImageUrl 图标
/// @param shareUrl 分享链接
+ (void)wxShare:(int)n title:(NSString *)title desc:(NSString *)desc imageUrl:(NSString *)ImageUrl shareUrl:(NSString *)shareUrl;
@end

NS_ASSUME_NONNULL_END
