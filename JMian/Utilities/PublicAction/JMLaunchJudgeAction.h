//
//  JMLaunchJugeAction.h
//  JMian
//
//  Created by mac on 2020/2/24.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMLaunchJudgeAction : NSObject

@property (strong, nonatomic) NSData *deviceToken;
+(void)launch;
@end

NS_ASSUME_NONNULL_END
