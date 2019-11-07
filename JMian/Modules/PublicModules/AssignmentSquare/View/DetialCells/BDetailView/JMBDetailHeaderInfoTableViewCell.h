//
//  JMBDetailHeaderInfoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMBDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMBDetailHeaderInfoTableViewCellIdentifier;
@protocol JMBDetailHeaderInfoTableViewCellDelegate <NSObject>

-(void)clickHeaderActionWithImageView:(UIImageView *)imageView;

@end

@interface JMBDetailHeaderInfoTableViewCell : UITableViewCell

@property(nonatomic,strong)JMBDetailModel *model;
@property(nonatomic,weak)id<JMBDetailHeaderInfoTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
