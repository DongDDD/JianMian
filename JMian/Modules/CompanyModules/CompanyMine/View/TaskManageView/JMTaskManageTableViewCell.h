//
//  JMTaskManageTableViewCell.h
//  JMian
//
//  Created by mac on 2019/6/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    JMTaskManageTableViewCellTypeNoPass,//待通过11
    JMTaskManageTableViewCellTypeDoing,
    JMTaskManageTableViewCellTypeFinish,
} JMTaskManageTableViewCellType;


@interface JMTaskManageCellData : NSObject

//@property(nonatomic, copy)NSString *

@end

@interface JMTaskManageTableViewCell : UITableViewCell

-(void)setTaskCellView_viewType:(JMTaskManageTableViewCellType)viewType data:(JMTaskManageCellData *)data;
//@property(nonatomic, assign)JMTaskManageTableViewCellType viewType;

@end

NS_ASSUME_NONNULL_END
