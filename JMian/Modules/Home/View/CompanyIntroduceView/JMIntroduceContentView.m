//
//  JMIntroduceContentView.m
//  JMian
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMIntroduceContentView.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMIntroduceContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.text = @"公司介绍";
        titleLab.font = [UIFont systemFontOfSize:17];
        titleLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
        [self addSubview:titleLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(22);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(16);
            make.top.mas_equalTo(self.mas_top).offset(28);
        }];
        
        self.contenLab =[[UILabel alloc]init];
        self.contenLab.font = [UIFont systemFontOfSize:14];
        self.contenLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
        self.contenLab.numberOfLines = 0;


        NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        NSString  *testString = @"1.负责线上产品的界面设计视觉交互设计并为\n2.新功能新产品提供创意及设计方案等负责线上产品的界面设计视觉交互6面设计面设计面设计面设计面设计面设计面设计设计\n3.并为新功能新产品提供创意及设计方案等淮准确理解产品需求和交互原型输岀优质的界果图够通过视觉元素有效把控网站的整66666666----66666666----66666666----66666666----66666666----66666666----66666666----66666666----66666666----66666666----";
        NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:testString];
        [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [testString length])];
        [self.contenLab  setAttributedText:setString];

        [paragraphStyle  setLineSpacing:14];
//        self.contenLab.text = testString;

        [self addSubview:self.contenLab];


        [self.contenLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_left);
            make.right.mas_equalTo(self.mas_right).offset(-31);
//            make.height.mas_equalTo(200);
            make.top.mas_equalTo(titleLab.mas_bottom).offset(21);
        }];
        
        
        //展开按钮

        UILabel *dotLab = [[UILabel alloc]init];
        dotLab.font = [UIFont systemFontOfSize:14];
        dotLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
        dotLab.backgroundColor = [UIColor whiteColor];
        dotLab.text = @"......";
        
        [self addSubview:dotLab];
        
        self.spreadBtn = [[UIButton alloc]init];
        [self.spreadBtn setTitle:@"展开>" forState:UIControlStateNormal];
        [self.spreadBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.spreadBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        self.spreadBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.spreadBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.spreadBtn.titleLabel.font =[UIFont systemFontOfSize:14];
        self.spreadBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.spreadBtn.backgroundColor = [UIColor whiteColor];
        

        [self addSubview:self.spreadBtn];
        
        [self.spreadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.contenLab.mas_right);
            make.width.mas_equalTo(100);
            
            //            make.top.mas_equalTo(titleLab.mas_bottom).offset(21);
            make.bottom.mas_equalTo(self.contenLab).mas_offset(0);
            
        }];
    
        [dotLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.spreadBtn.mas_left);
            make.height.mas_equalTo(self.spreadBtn);
            make.bottom.mas_equalTo(self.spreadBtn.mas_bottom);
        
        }];
        
      
        
        UIView * xian1View = [[UIView alloc]init];
        xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [self addSubview:xian1View];
        
        [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(22);
            make.right.mas_equalTo(self.mas_right).offset(-22);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.mas_top);
        }];
        
        [self layoutIfNeeded];
        
//        UITapGestureRecognizer *spreadTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(spreadAction:)];
//
//
//        [self.contenLab addGestureRecognizer:spreadTap];
//
        
         
    
    }
    
    return self;
}



#pragma mark - 按钮点击事件，通过代理模式响应
-(void)btnClick:(UIButton *)btn
{
        
    
    [self.delegate didClickButton:self.contenLab.frame.size.height];
}

//
//-(void)spreadAction:(id)tap{
//    
//    [self.contenLab mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        make.bottom.mas_equalTo(self.contenLab.mas_bottom).offset(30);
//        
//        
//    }];
//    
//    
//    
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
