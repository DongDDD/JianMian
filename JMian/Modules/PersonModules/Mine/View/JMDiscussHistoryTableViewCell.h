//
//  JMDiscussHistoryTableViewCell.h
//  JMian
//
//  Created by mac on 2020/2/18.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMDiscussHistoryCellData.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *const JMDiscussHistoryTableViewCellIdentifier;

@interface JMDiscussHistoryTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *msgLab;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imageArr;
@property(nonatomic,strong)JMDiscussHistoryCellData *data;
@end

NS_ASSUME_NONNULL_END
