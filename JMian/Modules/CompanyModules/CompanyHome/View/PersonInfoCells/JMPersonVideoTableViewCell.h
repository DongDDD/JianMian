//
//  JMPersonVideoTableViewCell.h
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const JMPersonVideoTableViewCellIdentifier;

@protocol JMPersonVideoTableViewCellDelegate <NSObject>

-(void)playVideoAction;

@end
@interface JMPersonVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic,strong)JMVitaDetailModel *model;
@property (nonatomic, weak)id<JMPersonVideoTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
