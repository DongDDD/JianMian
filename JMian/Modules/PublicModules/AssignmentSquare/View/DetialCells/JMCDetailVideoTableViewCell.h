//
//  JMCDetailVideoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCDetailModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMCDetailVideoTableViewCellIdentifier;
@protocol JMCDetailVideoTableViewCellDelegate <NSObject>

-(void)playVideoActionWithUrl:(NSString *)url;

@end

@interface JMCDetailVideoTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCDetailModel *model;
@property(nonatomic,weak)id<JMCDetailVideoTableViewCellDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
