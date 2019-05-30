//
//  JMMyResumeCellConfigures.m
//  JMian
//
//  Created by Chitat on 2019/3/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeCellConfigures.h"
#import "DimensMacros.h"

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
            self.rowsNum = self.jobstArr.count;
            self.footerheight = 100;
            self.height = 96;
            self.cellId = JMMyResumeCareerObjectiveTableViewCellIdentifier;
//            self.footerView = [self getFooterView_title:@"添加期望职位"];
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
            self.rowsNum = 0;
            self.footerheight = 0;
            self.height = 0;
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

//- (void)initFooterViewWithSection:(NSInteger)section {
//    if (JMMyResumeCellTypeCareerObjective) {
//        self.footerView = [self getFooterView_title:@"添加期望职位"];
//    }
//
//}


- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    [self initDataWithSection:section];
    return self.rowsNum;
}

//- (UIView *)footerViewInSection:(NSInteger)section {
//    [self initDataWithSection:section];
//    return self.footerView;
//}

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
//    self.careerObjectiveRightArr = @[model.work_name?:@"", model.salary_max?[NSString stringWithFormat:@"%@~%@",model.salary_min,model.salary_max]:@"",model.city_name?:@"",model.vita_work_start_date?:@""];
    self.jobstArr = model.jobs;
    
    self.workExperienceArr = model.experiences;
    self.educationalExperienceArr = model.learning;
    self.filesArr = model.files;
    self.vita_description = model.vita_description;
}

- (UIView *)getFooterView_title:(NSString *)title {
    UIView *view = [[UIView alloc]init];
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setTitle:title forState:UIControlStateNormal];
    [addBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    addBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.borderColor = MASTER_COLOR.CGColor;
    addBtn.layer.borderWidth = 0.5;
    [view addSubview:addBtn];
    
    return view;
}
@end
