//
//  JMCompanyLikeTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMBTypeLikeModel.h"
#import "JMCTypeLikeModel.h"

@protocol JMCompanyLikeTableViewCellDelegate <NSObject>

-(void)deleteActionWithFavorite_id:(NSString *)favorite_id;
-(void)chatAction;


@end

NS_ASSUME_NONNULL_BEGIN

@interface JMCompanyLikeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic, strong)JMBTypeLikeModel *BTypeLikeModel;
@property (nonatomic, strong)JMCTypeLikeModel *CTypeLikeModel;
@property (nonatomic, weak)id<JMCompanyLikeTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
