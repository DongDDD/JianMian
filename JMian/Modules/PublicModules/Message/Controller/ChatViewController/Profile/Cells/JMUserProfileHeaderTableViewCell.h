//
//  JMUserProfileHeaderTableViewCell.h
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMUserProfileHeaderTableViewCellIdentifier;
typedef NS_ENUM(NSInteger, JMUserProfileHeaderCellType){
    JMUserProfileHeaderCellTypeB = 0 ,
    JMUserProfileHeaderCellTypeC
};
@interface JMUserProfileHeaderTableViewCell : UITableViewCell

@property(nonatomic,strong)JMUserInfoModel *model;
@property(nonatomic,assign)JMUserProfileHeaderCellType viewType;
-(void)setModel:(JMUserInfoModel *)model viewType:(JMUserProfileHeaderCellType)viewType;
@end

NS_ASSUME_NONNULL_END
