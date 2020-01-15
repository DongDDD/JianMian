//
//  JMGoodsCollectionViewCell.h
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMGoodsCollectionViewCellIdentifier;

@interface JMGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLeftLab;

@end

NS_ASSUME_NONNULL_END
