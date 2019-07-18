//
//  JMVIPInvoicePayTableViewCell.h
//  JMian
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JMVIPInvoicePayTableViewCellDelegate <NSObject>

-(void)didChoosePayWayWithPayName:(NSString *)payName;

@end
@interface JMVIPInvoicePayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (nonatomic, weak) id<JMVIPInvoicePayTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
