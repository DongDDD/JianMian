//
//  JMOrderInfoAdressTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMOrderInfoAdressTableViewCellIdentifier;

@interface JMOrderInfoAdressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *adressLab;
-(void)setValuesWithName:(NSString *)name phone:(NSString *)phone adress:(NSString *)adress;
@end

NS_ASSUME_NONNULL_END
