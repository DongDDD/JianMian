//
//  JMWorkExperienceView.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWorkExperienceView.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMWorkExperienceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)setModel:(JMExperiencesModel *)model{

    UILabel *companyNameLab = [[UILabel alloc]init];
    companyNameLab.text = model.company_name;
    companyNameLab.textColor = MASTER_COLOR;
    companyNameLab.font = [UIFont systemFontOfSize:16.0f];
    [self addSubview:companyNameLab];
    
    [companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(16);
    }];
    
    
    UILabel *jobNameLab =  [[UILabel alloc]init];
    jobNameLab.text = model.work_name;
    jobNameLab.textColor = TITLE_COLOR;
    jobNameLab.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:jobNameLab];
    
    [jobNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(companyNameLab);
        make.top.mas_equalTo(companyNameLab.mas_bottom).offset(17);
        make.height.mas_equalTo(15);
    }];
    
    
    UILabel *dateLab =  [[UILabel alloc]init];
    dateLab.text =[NSString stringWithFormat:@"%@  ~~  %@",model.start_date,model.end_date];
    dateLab.textColor = TEXT_GRAY_COLOR;
    dateLab.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:dateLab];
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(jobNameLab);
        make.top.mas_equalTo(jobNameLab.mas_bottom).offset(22);
        make.height.mas_equalTo(13);
    }];
    
    
    self.contentLabel =  [[UILabel alloc]init];
    self.contentLabel.textColor = TITLE_COLOR;
    self.contentLabel.font = [UIFont systemFontOfSize:13.0f];
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (model.experiences_description != nil) {
        NSString  *testString2 = model.experiences_description;
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString2];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString2 length])];
        [self.contentLabel  setAttributedText:setString];
        [paragraphStyle  setLineSpacing:13.5];
        
    }
    self.contentLabel.numberOfLines = 0;
    
    [self addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dateLab);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(dateLab.mas_bottom).offset(30);
    }];
    
    
    UIView * xian1View = [[UIView alloc]init];
    xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self addSubview:xian1View];
    
    [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(22);
        make.right.mas_equalTo(self.mas_right).offset(-22);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
