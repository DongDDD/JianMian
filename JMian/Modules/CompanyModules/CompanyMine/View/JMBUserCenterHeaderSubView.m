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
        [self initView];
        [self initLayout];

    }
    return self;
}

-(void)initView{
    _centerBtn = [[UIButton alloc]init];
    [_centerBtn addTarget:self action:@selector(centerAction) forControlEvents:UIControlEventTouchUpInside];
    [_centerBtn setImage:[UIImage imageNamed:@"B_indent"] forState:UIControlStateNormal];
    [self addSubview:_centerBtn];
    _centerLab = [[UILabel alloc]init];
    _centerLab.text = @"订单列表";
    _centerLab.font = kFont(12);
    _centerLab.textColor = TEXT_GRAY_COLOR;
    [self addSubview:_centerLab];
    
    _leftBtn = [[UIButton alloc]init];
    [_leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:[UIImage imageNamed:@"B_task"] forState:UIControlStateNormal];
    [self addSubview:_leftBtn];
    _leftLab = [[UILabel alloc]init];
    _leftLab.text = @"任务管理";
    _leftLab.font = kFont(12);
    _leftLab.textColor = TEXT_GRAY_COLOR;
    [self addSubview:_leftLab];
    
//
    
    _rightBtn = [[UIButton alloc]init];
    [_rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setImage:[UIImage imageNamed:@"VIP"] forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
    _rightLab = [[UILabel alloc]init];
    _rightLab.textColor = TEXT_GRAY_COLOR;
    _rightLab.text = @"VIP会员";
    _rightLab.font = kFont(12);
    [self addSubview:_rightLab];
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.email isEqualToString:@"379247111@qq.com"]) {
        [_rightBtn setHidden:YES];
        [_rightLab setHidden:YES];
    }else{
        [_rightBtn setHidden:NO];
        [_rightLab setHidden:NO];
    }
    
    
    _taskBadgeView = [[UIView alloc]init];
    _taskBadgeView.backgroundColor = [UIColor redColor];
    _taskBadgeView.layer.cornerRadius = 5;
    [_taskBadgeView setHidden:YES];
    [self addSubview:_taskBadgeView];
    
    _orderBadgeView = [[UIView alloc]init];
    _orderBadgeView.layer.cornerRadius = 5;
    _orderBadgeView.backgroundColor = [UIColor redColor];
    [_orderBadgeView setHidden:YES];
    [self addSubview:_orderBadgeView];
    
}

-(void)initLayout{
    //订单列表
    [_centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-55);
        make.size.mas_equalTo(CGSizeMake(29, 28));

    }];
    [_centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_centerBtn);
        make.top.mas_equalTo(_centerBtn.mas_bottom).offset(10);

    }];
    [_orderBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_centerBtn).mas_offset(5);
        make.top.mas_equalTo(_centerBtn).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(10,10));
    }];
    
    //任务管理
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(-SCREEN_WIDTH*0.25);
        make.bottom.mas_equalTo(self).offset(-55);
        make.size.mas_equalTo(CGSizeMake(29, 28));
        
    }];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_leftBtn);
        make.top.mas_equalTo(_leftBtn.mas_bottom).offset(10);
        
    }];
    
    [_taskBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_leftBtn).mas_offset(5);
        make.top.mas_equalTo(_leftBtn).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(10,10));
    }];
    
    //VIP
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(SCREEN_WIDTH*0.25);
        make.bottom.mas_equalTo(self).offset(-55);
        make.size.mas_equalTo(CGSizeMake(29, 28));
    }];

    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_rightBtn);
        make.top.mas_equalTo(_rightBtn.mas_bottom).offset(10);
    }];
}



-(void)leftAction{
    if (_delegate && [_delegate respondsToSelector:@selector(BTaskClick)]) {
        [_delegate BTaskClick];
    }
    
}
-(void)centerAction{
    if (_delegate && [_delegate respondsToSelector:@selector(BOrderClick)]) {
        [_delegate BOrderClick];
    }

}
-(void)rightAction{
    if (_delegate && [_delegate respondsToSelector:@selector(BVIPClick)]) {
        [_delegate BVIPClick];
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
