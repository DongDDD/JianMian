//
//  JMAfterSalesDetailTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMAfterSalesDetailTableViewCellIdentifier;

@interface JMAfterSalesDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab1;
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (weak, nonatomic) IBOutlet UILabel *titleLab3;
-(void)setValuesWithTime:(NSString *)time price:(NSString *)price msg:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
