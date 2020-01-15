//
//  JMProductSpefiColorCollectionViewCell.h
//  JMian
//
//  Created by mac on 2020/1/13.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMProductColorData.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMProductSpefiColorCollectionViewCellIdentifier;

@interface JMProductSpefiColorCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)JMProductColorData *data;

@end

NS_ASSUME_NONNULL_END
