//
//  JMMyResumeCellConfigures.h
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "JMMyResumeIconTableViewCell.h"
#import "JMMyResumeHeaderTableViewCell.h"
#import "JMMyResumeCareerObjectiveTableViewCell.h"
#import "JMMyResumeCareerStatusTableViewCell.h"
#import "JMMyResumeWorkExperienceTableViewCell.h"
#import "JMMyReSumeActionTableViewCell.h"
#import "JMEducationalExperienceTableViewCell.h"
#import "JMMyResumeHeader2TableViewCell.h"
#import "JMMyResumeTextTableViewCell.h"
#import "JMVitaDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMMyResumeCellType){
    JMMyResumeCellTypeIcon = 0,
    JMMyResumeCellTypeHeader,
    JMMyResumeCellTypeCareerStatus,
    JMMyResumeCellTypeCareerObjective,
    JMMyResumeCellTypeHeader2,
    JMMyResumeCellTypeWorkExperience,
    JMMyResumeCellTypeAction,
    JMMyResumeCellTypeHeader3,
    JMMyResumeCellTypeHeader4,
    JMMyResumeCellTypeEducationalExperience,
    JMMyResumeCellTypeHeaderOnlyLabel,
    JMMyResumeCellTypyText,

};

@interface JMMyResumeCellConfigures : NSObject

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat footerheight;
@property (assign, nonatomic) NSInteger rowsNum;
@property (assign, nonatomic) NSInteger section;
@property (copy, nonatomic) NSString *cellId;

@property (strong, nonatomic) JMVitaDetailModel *model;

@property (strong, nonatomic) NSArray *careerObjectiveLeftArr;
@property (strong, nonatomic) NSArray *careerObjectiveRightArr;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

- (CGFloat)heightForRowsInSection:(NSInteger)section;

- (NSString *)cellIdForSection:(NSInteger)section;

- (void)didSelectedRowAtSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
