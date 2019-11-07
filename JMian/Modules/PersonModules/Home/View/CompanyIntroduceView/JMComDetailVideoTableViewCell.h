//
//  JMComDetailVideoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMComDetailVideoTableViewCellIdentifier;

@protocol JMComDetailVideoTableViewCellDelegate <NSObject>
-(void)playVideoActionWithUrl:(NSString *)url;

@end
@interface JMComDetailVideoTableViewCell : UITableViewCell
@property(nonatomic,strong)JMCompanyInfoModel *model;
@property(nonatomic,weak)id<JMComDetailVideoTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
