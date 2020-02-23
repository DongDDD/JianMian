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
@protocol JMProductManagerTableViewCellDelegate <NSObject>
-(void)didSelectedBtnWithTitle:(NSString *)title data:(JMGoodsData *)data;
@end

@interface JMProductManagerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn1;//复制
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn2;//下架
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn3;//商家
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (nonatomic,strong) JMGoodsData *data;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (nonatomic,weak)id<JMProductManagerTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
