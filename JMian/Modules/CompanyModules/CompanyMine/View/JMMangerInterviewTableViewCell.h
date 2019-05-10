//
//  JMMangerInterviewTableViewCell.h
//  JMian
//
//  Created by mac on 2019/4/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMInterViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JMMangerInterviewTableViewCellDelegate <NSObject>

-(void)cellLeftBtnActionWith_model:(JMInterViewModel *)model;
-(void)cellRightBtnAction_model:(JMInterViewModel *)model;

@end

@interface JMMangerInterviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLab;
@property(nonatomic,strong)JMInterViewModel *model;
@property (weak, nonatomic) IBOutlet UILabel *interviewTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImg;

@property (nonatomic,assign)NSInteger myRow;

@property (nonatomic, weak) id<JMMangerInterviewTableViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
