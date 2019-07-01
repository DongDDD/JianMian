//
//  JMDidUploadVideoView.m
//  JMian
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMDidUploadVideoView.h"
#import "DimensMacros.h"
#import "Masonry.h"
@implementation JMDidUploadVideoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    _imgView = [[UIImageView alloc]init];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 12.5;
    _imgView.layer.borderWidth = 0.5;
    _imgView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
    [self addSubview:_imgView];
    
    UIButton *playBtn = [[UIButton alloc]init];
    playBtn.layer.cornerRadius = 34;
    [playBtn setImage:[UIImage imageNamed:@"bofang"]forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtn];
    
    
    
    _leftBtn = [[UIButton alloc]init];
    [_leftBtn setTitle:@"重新上传" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.layer.cornerRadius = 18.5;
    _leftBtn.layer.borderWidth = 0.5;
    _leftBtn.layer.borderColor = MASTER_COLOR.CGColor;
    [self addSubview:_leftBtn];
    
    _rightBtn = [[UIButton alloc]init];
    _rightBtn.backgroundColor = MASTER_COLOR;
    [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setTitle:@"重新拍摄" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightBtn.layer.cornerRadius = 18.5;
    [self addSubview:_rightBtn];
   
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(27);
        make.right.mas_equalTo(self).offset(-27);
        make.top.mas_equalTo(self).offset(28);
        make.bottom.mas_equalTo(self).offset(-92);
    }];
    
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.mas_equalTo(_imgView);
        make.width.and.height.mas_equalTo(68);
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(18);
        make.right.mas_equalTo(_rightBtn.mas_left).offset(-20);
        make.height.mas_equalTo(37);
        make.width.mas_equalTo(SCREEN_WIDTH*0.36);
        make.top.mas_equalTo(_imgView.mas_bottom).offset(25);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-18);
        make.width.mas_equalTo(_leftBtn);
        make.height.mas_equalTo(_leftBtn);
        make.top.mas_equalTo(_leftBtn);
    }];
    
    
    
    
}


-(void)rightClick{
    if (_delegate && [_delegate respondsToSelector:@selector(rightAction)]) {
        [_delegate rightAction];
    }

}

-(void)leftClick{
    if (_delegate && [_delegate respondsToSelector:@selector(leftAction)]) {
        [_delegate leftAction];
    }
    
}

-(void)playClick{
    if (_delegate && [_delegate respondsToSelector:@selector(playAction)]) {
        [_delegate playAction];
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
