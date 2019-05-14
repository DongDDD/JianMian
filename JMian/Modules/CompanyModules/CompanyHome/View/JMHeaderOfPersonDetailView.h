//
//  JMHeaderOfPersonDetailView.h
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMVitaDetailModel.h"
#import "JMCompanyHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol JMHeaderOfPersonDetailViewDelegate <NSObject>

-(void)playAction;

@end

@interface JMHeaderOfPersonDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (nonatomic,strong) JMVitaDetailModel *model;
@property (nonatomic,strong) JMCompanyHomeModel *companyHomeModel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLab;
@property (weak, nonatomic) IBOutlet UILabel *experiencesLab;
@property (weak, nonatomic) IBOutlet UILabel *educationLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;
@property (weak, nonatomic) IBOutlet UILabel *workStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *workStartDate;
//视频播放
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labToheaderTop;
@property (weak, nonatomic) IBOutlet UIImageView *videoImg;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *salaryLab;

@property(nonatomic,weak)id<JMHeaderOfPersonDetailViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
