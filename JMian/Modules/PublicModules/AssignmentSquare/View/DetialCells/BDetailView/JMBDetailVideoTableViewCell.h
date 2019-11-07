//
//  JMBDetailVideoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMBDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMBDetailVideoTableViewCellIdentifier;
@protocol JMBDetailVideoTableViewCellDelegate <NSObject>

-(void)playVideoActionWithUrl:(NSString *)url;


@end

@interface JMBDetailVideoTableViewCell : UITableViewCell

@property(nonatomic,strong)JMBDetailModel *model;

@property(nonatomic,weak)id<JMBDetailVideoTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
