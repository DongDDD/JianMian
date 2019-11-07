//
//  JMPersonInfoConfigures.h
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMCompanyHomeModel.h"
#import "JMPersonHeaderTableViewCell.h"//个人简介
#import "JMPersonVideoTableViewCell.h" //个人视频
#import "JMPersonIntensionTableViewCell.h" //求职意向
#import "JMPersonWorkExpTableViewCell.h" //工作经历
#import "JMPesonDescTableViewCell.h" //自我描述
#import "JMPesonEducationTableViewCell.h" //教育经历

NS_ASSUME_NONNULL_BEGIN

@interface JMPersonInfoConfigures : NSObject

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
@end

NS_ASSUME_NONNULL_END
