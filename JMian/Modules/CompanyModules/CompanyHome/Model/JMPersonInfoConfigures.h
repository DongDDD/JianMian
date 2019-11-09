//
//  JMPersonInfoConfigures.h
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMCompanyHomeModel.h"
#import "JMVitaDetailModel.h"
#import "JMPersonHeaderTableViewCell.h"//个人简介
#import "JMPersonVideoTableViewCell.h" //个人视频
#import "JMPersonIntensionTableViewCell.h" //求职意向
#import "JMPersonWorkExpTableViewCell.h" //工作经历
#import "JMPesonDescTableViewCell.h" //自我描述
#import "JMPesonEducationTableViewCell.h" //教育经历
#import "JMPersonContactTableViewCell.h" //联系方式

NS_ASSUME_NONNULL_BEGIN

@interface JMPersonInfoConfigures : NSObject

@property (nonatomic, strong)JMVitaDetailModel *model;

//@property(nonatomic,strong)JMCompanyHomeModel *model;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (CGFloat)heightForRowsInSection:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
