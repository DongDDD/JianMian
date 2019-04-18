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
        UILabel *companyNameLab = [[UILabel alloc]init];
        companyNameLab.text = @"广州空间智能科技有限公司";
        companyNameLab.textColor = MASTER_COLOR;
        companyNameLab.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:companyNameLab];
        
        [companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(20);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(16);
        }];
        
        
        UILabel *jobNameLab =  [[UILabel alloc]init];
        jobNameLab.text = @"项目经理";
        jobNameLab.textColor = TITLE_COLOR;
        jobNameLab.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:jobNameLab];

        [jobNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(companyNameLab);
            make.top.mas_equalTo(companyNameLab.mas_bottom).offset(17);
            make.height.mas_equalTo(15);
        }];
        

        UILabel *dateLab =  [[UILabel alloc]init];
        dateLab.text = @"2016年7月-2019年3月";
        dateLab.textColor = TEXT_GRAY_COLOR;
        dateLab.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:dateLab];

        [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(jobNameLab);
            make.top.mas_equalTo(jobNameLab.mas_bottom).offset(22);
            make.height.mas_equalTo(13);
        }];
        
        
        self.contentLabel =  [[UILabel alloc]init];
        self.contentLabel.text = @" 1、参与营销广告、创意海报、App、专题页面设计。\n  2、负责公司宣传物料设计（名片、宣传海报、文化       tee、纪";
        self.contentLabel.textColor = TITLE_COLOR;
        self.contentLabel.font = [UIFont systemFontOfSize:13.0f];
        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        NSString  *testString2 = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输\n3.岀优质的界果图够通过视觉元素有效把控网站的整体设计风格";
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString2];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString2 length])];
        [self.contentLabel  setAttributedText:setString];
        [paragraphStyle  setLineSpacing:13.5];
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
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
