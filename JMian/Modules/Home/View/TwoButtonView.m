//
//  TwoButtonView.m
//  JMian
//
//  Created by mac on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TwoButtonView.h"
#import "Masonry.h"
#import "DimensMacros.h"
#import "JMUserInfoModel.h"


@implementation TwoButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
   
        self.layer.cornerRadius = 12.5;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0].CGColor;
    
      
        

    
    }
     return self;
}

-(void)setPersonUserButtonUI{
    //和他聊聊按钮
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = MASTER_COLOR;
    
    [btn setTitle:@"和他聊聊" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor colorWithRed:59/255.0 green:199/255.0 blue:255/255.0 alpha:1.0].CGColor;
    btn.layer.cornerRadius = 18.5;
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(22);
        make.right.mas_equalTo(self).offset(-22);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(37);
    }];


}

-(void)setStatus:(NSString *)status{

    if ([status isEqualToString: @"1"]) {//在线的职位
        [self setCompanyUserButtonUI:@"下线" btn2TitleStr:@"修改编辑"];

    }else if([status isEqualToString: @"0"]){//下线了的职位
        [self setCompanyUserButtonUI:@"编辑" btn2TitleStr:@"重新发布"];

    }else if(status == nil){
        //C端情况
        
        [self setPersonUserButtonUI];
    
    }
    

}

-(void)setCompanyUserButtonUI:(NSString *)btnTitleStr btn2TitleStr:(NSString *)btn2TitleStr{

    //和他聊聊按钮
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = MASTER_COLOR;
    
    [btn setTitle:btnTitleStr forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor colorWithRed:59/255.0 green:199/255.0 blue:255/255.0 alpha:1.0].CGColor;
    btn.layer.cornerRadius = 18.5;
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(18);
        make.width.mas_equalTo(136);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(37);
    }];
    
    //投个简历按钮
    UIButton *btn2 = [[UIButton alloc]init];
    btn2.backgroundColor = MASTER_COLOR;
    [btn2 addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:btn2TitleStr forState:UIControlStateNormal];
    btn2.layer.borderWidth = 0.5;
    btn2.layer.borderColor = [UIColor colorWithRed:59/255.0 green:199/255.0 blue:255/255.0 alpha:1.0].CGColor;
    btn2.layer.cornerRadius = 18.5;
    [self addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-17);
        make.left.mas_equalTo(btn.mas_right).offset(20);
        make.height.mas_equalTo(btn);
        make.top.mas_equalTo(btn);
    }];


}

-(void)chatAction{

    [self.delegate chatAction];


}

-(void)leftBtnAction{
    
    [self.delegate btnAction];
    
}


-(void)rightBtnAction{
    
    [self.delegate btn2Action];

}



-(void)sendResume{

    [self.delegate sendResumeButton];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
