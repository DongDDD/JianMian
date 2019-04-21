//
//  JMMyResumeCellConfigures.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeCellConfigures.h"

@implementation JMMyResumeCellConfigures

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)initDataWithSection:(NSInteger)section {
    switch (section) {
        case JMMyResumeCellTypeIcon:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 98;
            self.cellId = JMMyResumeIconTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeHeader:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 75;
            self.cellId = JMMyResumeHeaderTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeCareerStatus:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 98;
            self.cellId = JMMyResumeCareerStatusTableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeCareerObjective:
            self.rowsNum = 4;
            self.footerheight = 10;
            self.height = 70;
            self.cellId = JMMyResumeCareerObjectiveTableViewCellIdentifier;
            break;

        case JMMyResumeCellTypeHeader2:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 75;
            self.cellId = JMMyResumeHeader2TableViewCellIdentifier;
            break;
        case JMMyResumeCellTypeWorkExperience:
            self.rowsNum = self.workExperienceArr.count;
            self.footerheight = 0;
            self.height = 300;
            break;
        case JMMyResumeCellTypeAction:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 99;
            break;
        case JMMyResumeCellTypeHeader3:
            self.rowsNum = 1;
            self.footerheight = 10;
            self.height = 75;
            break;
        case JMMyResumeCellTypeHeader4:
//            self.rowsNum = self.educationalExperienceArr.count>0?1:0;
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 75;
            break;
        case JMMyResumeCellTypeEducationalExperience:
            self.rowsNum = self.educationalExperienceArr.count;
            self.footerheight = 10;
            self.height = 83;
            break;
        case JMMyResumeCellTypeHeaderOnlyLabel:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 83;
            break;
        case JMMyResumeCellTypyText:
            self.rowsNum = 1;
            self.footerheight = 0;
            self.height = 83;
            break;
        default:
            break;
    }

}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.rowsNum;
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.footerheight;
}

- (CGFloat)heightForRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.height;
}

- (NSString *)cellIdForSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.cellId;
}

- (void)didSelectedRowAtSection:(NSInteger)section {
    
}

-(void)setModel:(JMVitaDetailModel *)model {
    _model = model;
    self.careerObjectiveRightArr = @[model.work_name?:@"",model.salary_max?:@"",model.city_name?:@"",model.vita_work_start_date?:@""];
    self.careerObjectiveLeftArr = @[@"期望职位",@"薪资要求",@"工作城市",@"参加工作时间"];
    
    self.workExperienceArr = model.experiences;
    self.educationalExperienceArr = model.education;
    
    self.vita_description = model.vita_description;
}
@end
