//
//  JMCDetailCellConfigures.h
//  JMian
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMTaskDetailHeaderTableViewCell.h"
#import "JMCDetailTaskDecriTableViewCell.h"
#import "JMCDetailTaskDecri2TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMTaskDetailTableViewCellType){
    JMTaskDetailCellTypeHeader = 0,
    JMTaskDetail2CellType,
 
};

@interface JMCDetailCellConfigures : NSObject

@end

NS_ASSUME_NONNULL_END
