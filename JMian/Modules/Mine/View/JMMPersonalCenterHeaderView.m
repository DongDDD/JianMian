//
//  JMMPersonalCenterHeaderView.m
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMPersonalCenterHeaderView.h"
#import "DimensMacros.h"
#import "UIView+addGradualLayer.h"

@interface JMMPersonalCenterHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *settingBtn;

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIImageView *bottomImg;

@property(nonatomic,strong)UILabel *leftLab;
@property(nonatomic,strong)UILabel *rightLab;
@property (strong, nonatomic) UIView *barBackgroundView;
@property (strong, nonatomic)UIImageView *barBackgroundImageView;
@end


@implementation JMMPersonalCenterHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        [self initView];
        [self initLayout];
        
       
    }
    return self;
}

//-(void)initViewTest{
//    _titleLab = [[UILabel alloc]init];
//    _titleLab.text = @"个人用户";
//    _titleLab.textColor = [UIColor whiteColor];
//    _titleLab.font = kFont(16);
//    [self addSubview:_titleLab];
//
//
//    _settingBtn = [[UIButton alloc]init];
//    [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
//    [_settingBtn setImage:[UIImage imageNamed:@"bule_upinstall"] forState:UIControlStateNormal];
//    [self addSubview:_settingBtn];
//
//    _bottomImg = [[UIImageView alloc]init];
//    _bottomImg.image = [UIImage imageNamed:@"mineBottom"];
//    [self addSubview:_bottomImg];
//
//    _leftBtn = [[UIButton alloc]init];
//    [_leftBtn addTarget:self action:@selector(assignBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [_leftBtn setImage:[UIImage imageNamed:@"my_task"] forState:UIControlStateNormal];
//    [self addSubview:_leftBtn];
//    _leftLab = [[UILabel alloc]init];
//    _leftLab.text = @"我的兼职";
//    _leftLab.font = kFont(12);
//    _leftLab.textColor = [UIColor whiteColor];
//    [self addSubview:_leftLab];
//
//
////    _rightBtn = [[UIButton alloc]init];
////    [_rightBtn addTarget:self action:@selector(orderBtnAction) forControlEvents:UIControlEventTouchUpInside];
////    [self addSubview:_rightBtn];
////    _rightLab = [[UILabel alloc]init];
////    _rightLab.textColor = [UIColor whiteColor];
////
////    //        _rightLab.text = @"任务详情";
////    //        [_rightBtn setImage:[UIImage imageNamed:@"my_task"] forState:UIControlStateNormal];
////
////    _rightLab.font = kFont(18);
////    [self addSubview:_rightLab];
////    _taskBadgeView = [[UIView alloc]init];
////    _taskBadgeView.backgroundColor = [UIColor redColor];
////    _taskBadgeView.layer.cornerRadius = 5;
////    [_taskBadgeView setHidden:YES];
////    [self addSubview:_taskBadgeView];
////
////    _orderBadgeView = [[UIView alloc]init];
////    _orderBadgeView.layer.cornerRadius = 5;
////    [_orderBadgeView setHidden:YES];
////    _orderBadgeView.backgroundColor = [UIColor redColor];
////    [self addSubview:_orderBadgeView];
//
//}
//
//-(void)initLayoutTest{
//    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.top.mas_equalTo(self).offset(45);
//    }];
//
//
//    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self);
//        make.centerY.mas_equalTo(_titleLab);
//        make.size.mas_equalTo(CGSizeMake(80, 50));
//    }];
//
//
//    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.bottom.mas_equalTo(self).offset(-55);
//        make.size.mas_equalTo(CGSizeMake(29, 28));
//
//    }];
//
//    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(_leftBtn);
//        make.top.mas_equalTo(_leftBtn.mas_bottom).offset(10);
//
//    }];
//
////    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.mas_equalTo(self).offset(SCREEN_WIDTH*0.2);
////        make.top.mas_equalTo(_leftBtn);
////        make.size.mas_equalTo(CGSizeMake(29, 28));
////    }];
////
////    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.mas_equalTo(_rightBtn);
////        make.top.mas_equalTo(_rightBtn.mas_bottom).offset(10);
////    }];
//
//    [_bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self);
//        make.bottom.mas_equalTo(self);
//        make.height.mas_equalTo(49);
//    }];
//
////    [_orderBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.mas_equalTo(_rightBtn).mas_offset(5);
////        make.top.mas_equalTo(_rightBtn).mas_offset(-5);
////        make.size.mas_equalTo(CGSizeMake(10,10));
////    }];
//    [_taskBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_leftBtn).mas_offset(5);
//        make.top.mas_equalTo(_leftBtn).mas_offset(-5);
//        make.size.mas_equalTo(CGSizeMake(10,10));
//    }];
//}

-(void)initView{
//    _barBackgroundImageView = [[UIImageView alloc]init];
//    _barBackgroundImageView.image = [UIImage imageNamed:@"mine_peijing"];
//    [self addSubview:_barBackgroundImageView];
    _titleLab = [[UILabel alloc]init];
    _titleLab.text = @"个人用户";
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = kFont(16);
    [self addSubview:_titleLab];

    
    _settingBtn = [[UIButton alloc]init];
    [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    [_settingBtn setImage:[UIImage imageNamed:@"bule_upinstall"] forState:UIControlStateNormal];
    [self addSubview:_settingBtn];

    _bottomImg = [[UIImageView alloc]init];
    _bottomImg.image = [UIImage imageNamed:@"mineBottom"];
    [self addSubview:_bottomImg];
    
    _leftBtn = [[UIButton alloc]init];
    [_leftBtn addTarget:self action:@selector(assignBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:[UIImage imageNamed:@"my_task"] forState:UIControlStateNormal];
    [self addSubview:_leftBtn];
    _leftLab = [[UILabel alloc]init];
    _leftLab.text = @"我的任务";
    _leftLab.font = kFont(12);
    _leftLab.textColor = [UIColor whiteColor];
    [self addSubview:_leftLab];

    
    _rightBtn = [[UIButton alloc]init];
    [_rightBtn addTarget:self action:@selector(orderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setImage:[UIImage imageNamed:@"C_indent"] forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
    _rightLab = [[UILabel alloc]init];
    _rightLab.textColor = [UIColor whiteColor];
    _rightLab.text = @"我的订单";
 
    _rightLab.font = kFont(12);
    [self addSubview:_rightLab];
    _taskBadgeView = [[UIView alloc]init];
    _taskBadgeView.backgroundColor = [UIColor redColor];
    _taskBadgeView.layer.cornerRadius = 5;
    [_taskBadgeView setHidden:YES];
    [self addSubview:_taskBadgeView];
    
    _orderBadgeView = [[UIView alloc]init];
    _orderBadgeView.layer.cornerRadius = 5;
    [_orderBadgeView setHidden:YES];
    _orderBadgeView.backgroundColor = [UIColor redColor];
    [self addSubview:_orderBadgeView];
    


}


-(void)initLayout{
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(45);
    }];
    

    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.centerY.mas_equalTo(_titleLab);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];

    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(-SCREEN_WIDTH*0.2);;
        make.bottom.mas_equalTo(self).offset(-55);
        make.size.mas_equalTo(CGSizeMake(29, 28));
        
    }];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_leftBtn);
        make.top.mas_equalTo(_leftBtn.mas_bottom).offset(10);
        
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(SCREEN_WIDTH*0.2);
        make.top.mas_equalTo(_leftBtn);
        make.size.mas_equalTo(CGSizeMake(29, 28));
    }];

    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_rightBtn);
        make.top.mas_equalTo(_rightBtn.mas_bottom).offset(10);
    }];
    
    [_bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(49);
    }];
    
    [_orderBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_rightBtn).mas_offset(5);
        make.top.mas_equalTo(_rightBtn).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(10,10));
    }];
    [_taskBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_leftBtn).mas_offset(5);
        make.top.mas_equalTo(_leftBtn).mas_offset(-5);
        make.size.mas_equalTo(CGSizeMake(10,10));
    }];
    
}

-(void)settingAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickSetting)]) {
        [_delegate didClickSetting];
    }
}

-(void)assignBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickMyTask)]) {
        [_delegate didClickMyTask];
    }
}

-(void)orderBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickMyOrder)]) {
        [_delegate didClickMyOrder];
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
