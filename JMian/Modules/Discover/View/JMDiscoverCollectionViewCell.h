//
//  JMDiscoverCollectionViewCell.h
//  JMian
//
//  Created by mac on 2019/6/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVideoListCellData.h"
NS_ASSUME_NONNULL_BEGIN

@protocol JMDiscoverCollectionViewCellDelegate <NSObject>

-(void)didClickPlayAction_data:(JMVideoListCellData *)data;

@end

@interface JMDiscoverCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)JMVideoListCellData *data;
@property(nonatomic, weak)id<JMDiscoverCollectionViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
