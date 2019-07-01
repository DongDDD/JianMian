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
    
    _money = [[UILabel alloc]init];
    _money.text = @"00.00";
    _money.textColor = [UIColor whiteColor];
    _money.font = [UIFont systemFontOfSize:30];
    [self addSubview:_money];
    
    UILabel *moneyBottomLab = [[UILabel alloc]init];
    moneyBottomLab.text = @"可用金额";
    moneyBottomLab.font = [UIFont systemFontOfSize:12];
    moneyBottomLab.textColor = [UIColor whiteColor];
    [self addSubview:moneyBottomLab];
    
    _money2 = [[UILabel alloc]init];
    _money2.text = @"00.00";
    _money2.textColor = [UIColor whiteColor];
    _money2.font = [UIFont systemFontOfSize:30];
    [self addSubview:_money2];
    
    UILabel *moneyBottomLab2 = [[UILabel alloc]init];
    moneyBottomLab2.text = @"冻结金额";
    moneyBottomLab2.font = [UIFont systemFontOfSize:12];
    moneyBottomLab2.textColor = [UIColor whiteColor];
    [self addSubview:moneyBottomLab2];
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:centerView];
    
    
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
    
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(BGImgView);
        make.left.mas_equalTo(self.mas_left).offset(SCREEN_WIDTH*0.2);
        
    }];
    
    [moneyBottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_money);
        make.top.mas_equalTo(_money.mas_bottom).offset(18);
    }];
    
    [_money2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(BGImgView);
        make.right.mas_equalTo(self.mas_right).offset(-SCREEN_WIDTH*0.2);
        
    }];
    
    [moneyBottomLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_money2);
        make.top.mas_equalTo(_money2.mas_bottom).offset(18);
    }];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(moneyBottomLab);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(1);
    }];
    
}


-(void)setUserModel:(JMUserInfoModel *)userModel{
    if ([userModel.type isEqualToString:B_Type_UESR]) {
        self.money.text = [NSString stringWithFormat:@"%@",userModel.available_amount_b];
        self.money2.text = [NSString stringWithFormat:@"%@",userModel.unusable_amount_b];
    }else{
        self.money.text = [NSString stringWithFormat:@"%@",userModel.available_amount_c];
        self.money2.text = [NSString stringWithFormat:@"%@",userModel.unusable_amount_c];
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
