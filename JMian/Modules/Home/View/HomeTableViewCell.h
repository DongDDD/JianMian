//
//  HomeTableViewCell.h
//  JMian
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMHomeWorkModel.h"

NS_ASSUME_NONNULL_BEGIN
@class HomeTableViewCell;
@protocol HomeTableViewCellDelegate <NSObject>

-(void)playAction_cell:(HomeTableViewCell *)cell;

@end

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic,strong)JMHomeWorkModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *workExperienceLab;
@property (weak, nonatomic) IBOutlet UILabel *educationLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property(nonatomic,strong)NSIndexPath *indexpath;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic)id<HomeTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
