//
//  JMChatViewSectionView.m
//  JMian
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMChatViewSectionView.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMChatViewSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0].CGColor;
        self.layer.masksToBounds = YES;
    }

    return self;
}


-(void)initView
{
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    lab.text = @"聊得不错,邀他视频面试吧";
    lab.font = [UIFont systemFontOfSize:12];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(20);
    }];
    
    
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    [rightBtn setTitle:@"视频面试" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(self);
    }];
    
   
    UIView *shuXian = [[UIView alloc]init];
    shuXian.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self addSubview:shuXian];
    [shuXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(19);
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(rightBtn);
    }];
    
}

-(void)rightBtn:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(videoInterviewAction)]) {
        
        [_delegate videoInterviewAction];
    }

}
//    if (_delegate && [_delegate respondsToSelector:@selector(videoInterviewAction)]{
//
//
//    }
//
 
        

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
