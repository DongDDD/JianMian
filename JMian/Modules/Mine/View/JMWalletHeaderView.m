//
//  JMWalletHeaderView.m
//  JMian
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMWalletHeaderView.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMWalletHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)initView
{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    
    UIImageView *BGImgView = [[UIImageView alloc]init];
    BGImgView.image = [UIImage imageNamed:@"peijing"];
    [self addSubview:BGImgView];
    
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.backgroundColor = BG_COLOR;
    [iconImg sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    iconImg.layer.cornerRadius = 27.5;
    iconImg.layer.borderWidth = 1;
    iconImg.layer.borderColor = MASTER_COLOR.CGColor;
    iconImg.layer.masksToBounds = YES;
    [self addSubview:iconImg];
    
    UILabel *money = [[UILabel alloc]init];
    money.text = @"00.00";
    money.textColor = [UIColor whiteColor];
    money.font = [UIFont systemFontOfSize:45];
    [self addSubview:money];
    
    UILabel *moneyBottomLab = [[UILabel alloc]init];
    moneyBottomLab.text = @"我的余额";
    moneyBottomLab.font = [UIFont systemFontOfSize:12];
    moneyBottomLab.textColor = [UIColor whiteColor];
    [self addSubview:moneyBottomLab];
    
    
    [BGImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.mas_equalTo(self).offset(47);
        make.right.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(151);
    }];
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.and.height.mas_equalTo(53);
        make.top.mas_equalTo(BGImgView).offset(-26);
    }];
    
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(BGImgView);
        make.centerX.mas_equalTo(self);
        
    }];
    
    [moneyBottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(money.mas_bottom).offset(18);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
