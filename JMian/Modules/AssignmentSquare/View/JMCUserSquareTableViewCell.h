//
//  JMCUserSquareTableViewCell.h
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTaskListCellData.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMCUserSquareTableViewCell : UITableViewCell
@property(nonatomic,strong)JMTaskListCellData *model;
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(JMTaskListCellData *)model;
@end

NS_ASSUME_NONNULL_END
