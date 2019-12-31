//
//  JMVideoJoblistTableViewCell.h
//  JMian
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JMHomeWorkModel.h"
#import "JMCompanyInfoModel.h"
 
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMVideoJoblistTableViewCellIdentifier;

@interface JMVideoJoblistTableViewCell : UITableViewCell

//@property(nonatomic,strong)JMHomeWorkModel *model;
@property(nonatomic,strong)JMWorkModel *model;
@end

NS_ASSUME_NONNULL_END
