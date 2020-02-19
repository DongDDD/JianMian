//
//  JMGoodsCollectionViewCell.h
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMGoodsData.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMGoodsCollectionViewCellIdentifier;
@protocol JMGoodsCollectionViewCellDelegate <NSObject>

-(void)didClickShareActionWithData:(JMGoodsData *)data;

@end
@interface JMGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLeftLab;
@property(nonatomic,strong)JMGoodsData *data;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property(nonatomic,weak)id<JMGoodsCollectionViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
