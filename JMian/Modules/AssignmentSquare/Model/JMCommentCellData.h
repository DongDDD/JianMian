//
//  JMCommentCellData.h
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMCommentCellData : NSObject

@property(nonatomic, copy)NSString *myDescription;
@property(nonatomic, copy)NSString *reputation;
@property(nonatomic, copy)NSString *user_reputation;
@property(nonatomic, copy)NSString *user_nickname;
@property(nonatomic, copy)NSString *user_avatar;
@property(nonatomic, copy)NSString *task_title;

@end

NS_ASSUME_NONNULL_END
