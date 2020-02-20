//
//  JMMyStoreManager1TableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMShopInfoModel.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMMyStoreManager1TableViewCellIdentifier;
@protocol JMMyStoreManager1TableViewCellDelegate <NSObject>

-(void)didSelectStoreManager1ItemWithRow:(NSInteger)row;
-(void)didSelectedShopStatus:(NSString *)status;
@end
@interface JMMyStoreManager1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (nonatomic,weak)id<JMMyStoreManager1TableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (nonatomic,strong)JMShopInfoModel *model;
@end

NS_ASSUME_NONNULL_END
