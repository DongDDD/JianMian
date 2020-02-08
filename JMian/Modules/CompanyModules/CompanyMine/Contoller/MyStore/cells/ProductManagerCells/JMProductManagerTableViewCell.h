//
//  JMProductManagerTableViewCell.h
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMGoodsData.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMProductManagerTableViewCellIdentifier;

@interface JMProductManagerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn1;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn2;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn3;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic,strong) JMGoodsData *data;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@end

NS_ASSUME_NONNULL_END
