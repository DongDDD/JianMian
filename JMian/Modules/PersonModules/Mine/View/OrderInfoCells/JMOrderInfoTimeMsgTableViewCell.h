//
//  JMOrderInfoTimeMsgTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOrderInfoTimeMsgTableViewCellIdentifier;

@interface JMOrderInfoTimeMsgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time1Lab;
@property (weak, nonatomic) IBOutlet UILabel *time2Lab;
@property (weak, nonatomic) IBOutlet UILabel *time3Lab;
@property (weak, nonatomic) IBOutlet UILabel *time4Lab;

-(void)setValuesWithTime1:(NSString *)time1 time2:(NSString *)time2 logName:(NSString *)logName time4:(NSString *)time4;

@end

NS_ASSUME_NONNULL_END
