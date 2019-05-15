//
//  JMEducationView.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMEducationView.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMEducationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"教育经历";
        titleLabel.font = [UIFont systemFontOfSize:19];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(19);
            make.top.mas_equalTo(self.mas_top).offset(35);
        }];
        
        //内容
        
        UILabel *schoolLabel = [[UILabel alloc]init];
        schoolLabel.font = [UIFont systemFontOfSize:15];
        schoolLabel.textColor =  TITLE_COLOR;
        schoolLabel.text = @"广州美术学院";
        
        [self addSubview:schoolLabel];
        //
        [schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_left);
            make.right.mas_equalTo(self).offset(-38);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(30);
        }];
        
        
        UILabel *label2 = [[UILabel alloc]init];
        label2.font = [UIFont systemFontOfSize:14];
        label2.textColor =  TEXT_GRAY_COLOR;
        label2.text = @"本科/计算机应用";
        
        [self addSubview:label2];
        //
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(schoolLabel.mas_left);
            make.right.mas_equalTo(self).offset(-38);
            make.top.mas_equalTo(schoolLabel.mas_bottom).offset(13);
        }];
        
        UILabel *label3 = [[UILabel alloc]init];
        label3.font = [UIFont systemFontOfSize:14];
        label3.textColor =  TEXT_GRAY_COLOR;
        label3.text = @"2014-2018";
        label3.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(100);
//            make.left.mas_equalTo(label2.mas_right).offset(155);
            make.right.mas_equalTo(self).offset(-20);
            make.top.mas_equalTo(label2.mas_top);
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
