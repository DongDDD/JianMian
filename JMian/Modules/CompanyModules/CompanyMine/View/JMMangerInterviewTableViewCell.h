//
//  JMMangerInterviewTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMInterVIewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMMangerInterviewTableViewCell : UITableViewCell

@property(nonatomic,strong)JMInterVIewModel *model;
@property (weak, nonatomic) IBOutlet UILabel *interviewTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;


@end

NS_ASSUME_NONNULL_END
