//
//  JMBUserPostPositionTableViewCell.h
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMBUserPostPositionTableViewCellDelegate <NSObject>

@end
@interface JMBUserPostPositionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, weak)id<JMBUserPostPositionTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
