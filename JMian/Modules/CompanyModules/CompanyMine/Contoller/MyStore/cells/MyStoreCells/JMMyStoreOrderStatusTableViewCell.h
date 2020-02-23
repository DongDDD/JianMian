//
//  JMMyStoreOrderStatusTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMMyStoreOrderStatusTableViewCellIdentifier;

@protocol JMMyStoreOrderStatusTableViewCellDelegate <NSObject>
- (void)didSelectItemWithRow:(NSInteger)row;

@end

@interface JMMyStoreOrderStatusTableViewCell : UITableViewCell
-(void)setValueWithAll:(NSString *)all dfh:(NSString *)dfh shz:(NSString *)shz wfk:(NSString *)wfk;
@end

NS_ASSUME_NONNULL_END
