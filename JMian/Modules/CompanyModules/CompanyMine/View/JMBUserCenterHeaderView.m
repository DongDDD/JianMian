//
//  JMBUserCenterHeaderView.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserCenterHeaderView.h"
#import "DimensMacros.h"

@interface JMBUserCenterHeaderView ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *settingBtn;



@end

@implementation JMBUserCenterHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initView];
        [self initLayout];
    }
    return self;
}



-(void)initView{
    //    _barBackgroundImageView = [[UIImageView alloc]init];
    //    _barBackgroundImageView.image = [UIImage imageNamed:@"mine_peijing"];
    //    [self addSubview:_barBackgroundImageView];
    _VIPImg = [[UIImageView alloc]init];
    JMVersionModel *model = [JMVersionManager getVersoinInfo];
    if ([model.test isEqualToString:@"1"]) {
        _VIPImg.image = [UIImage imageNamed:@""];

    }else{
        _VIPImg.image = [UIImage imageNamed:@"vvip"];
    
    }
    [_VIPImg setHidden:YES];
//    [self addSubview:_VIPImg];

    
    _titleLab = [[UILabel alloc]init];
    _titleLab.text = @"企业用户";
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = kFont(16);
    [self addSubview:_titleLab];
    
    
    _settingBtn = [[UIButton alloc]init];
    [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    [_settingBtn setImage:[UIImage imageNamed:@"bule_upinstall"] forState:UIControlStateNormal];
    [self addSubview:_settingBtn];
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
    
//    [_VIPImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).offset(20);
//        make.centerY.mas_equalTo(_titleLab);
//        make.size.mas_equalTo(CGSizeMake(38, 17));
//    }];
    
    
}

-(void)settingAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickSetting)]) {
        [_delegate didClickSetting];
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
