//
//  JMCompanyHomeTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCompanyHomeModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JMCompanyHomeTableViewCell;
@protocol JMCompanyHomeTableViewCellDelegate <NSObject>

-(void)playAction_cell:(JMCompanyHomeTableViewCell *)cell;

@end


@interface JMCompanyHomeTableViewCell : UITableViewCell

@property(nonatomic,strong)JMCompanyHomeModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *experinenceLab;
@property (weak, nonatomic) IBOutlet UILabel *educationLab;
@property (weak, nonatomic) IBOutlet UILabel *jobDetailLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) AVPlayer *player;

@property (weak, nonatomic)id<JMCompanyHomeTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
