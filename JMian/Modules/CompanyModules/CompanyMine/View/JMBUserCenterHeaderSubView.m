//
//  JMBUserCenterHeaderSubView.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserCenterHeaderSubView.h"
#import "DimensMacros.h"
@interface JMBUserCenterHeaderSubView ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *settingBtn;

//@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *centerBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIImageView *bottomImg;

@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UILabel *centerLab;
@property(nonatomic,strong)UILabel *rightLab;

@end

@implementation JMBUserCenterHeaderSubView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        //测试环境
        [self initViewTest];
        [self initLayoutTest];
        
        
    }
    return self;
}

-(void)initViewTest{

    _leftBtn = [[UIButton alloc]init];
    [_leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:[UIImage imageNamed:@"B_task"] forState:UIControlStateNormal];
    [self addSubview:_leftBtn];
    _leftLab = [[UILabel alloc]init];
    _leftLab.text = @"兼职管理";
    _leftLab.font = kFont(17);
    _leftLab.textColor = TITLE_COLOR;
    [self addSubview:_leftLab];

}

-(void)initLayoutTest{

    
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-55);
        make.size.mas_equalTo(CGSizeMake(29, 28));
        
    }];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_leftBtn);
        make.top.mas_equalTo(_leftBtn.mas_bottom).offset(10);
        
    }];
    
   
    
    

}




-(void)leftAction{
    if (_delegate && [_delegate respondsToSelector:@selector(BTaskClick)]) {
        [_delegate BTaskClick];
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
