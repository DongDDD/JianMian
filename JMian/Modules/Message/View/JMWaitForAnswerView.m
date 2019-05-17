//
//  JMWaitForAnswerView.m
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWaitForAnswerView.h"
#import "DimensMacros.h"
#import "Masonry.h"

@implementation JMWaitForAnswerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"等待对方接听...";
    lab.textColor = [UIColor whiteColor];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
    UIButton *hangupBtn = [[UIButton alloc]init];
    [hangupBtn setImage:[UIImage imageNamed:@"hangUpButton"] forState:UIControlStateNormal];
    [hangupBtn addTarget: self action:@selector(hangupBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hangupBtn];
    
    [hangupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(60);
        make.top.mas_equalTo(lab).mas_offset(100);
        make.centerX.mas_equalTo(self);
    }];

    UILabel *closeLab = [[UILabel alloc]init];
    closeLab.text = @"取消";
    closeLab.textColor = [UIColor whiteColor];
    [self addSubview:closeLab];
    
    [closeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(hangupBtn);
        make.top.mas_equalTo(hangupBtn.mas_bottom).mas_offset(10);
    }];
    
}


-(void)hangupBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(hangupBtnAction)]) {
        [_delegate hangupBtnAction];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
