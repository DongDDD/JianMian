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
    
    
    
    UIButton *left = [[UIButton alloc]init];
    [left setTitle:@"重新上传" forState:UIControlStateNormal];
    [left setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    left.layer.cornerRadius = 18.5;
    left.layer.borderWidth = 0.5;
    left.layer.borderColor = MASTER_COLOR.CGColor;
    [self addSubview:left];
    
    UIButton *right = [[UIButton alloc]init];
    right.backgroundColor = MASTER_COLOR;
    [right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"重新拍摄" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    right.layer.cornerRadius = 18.5;
    [self addSubview:right];
   
    
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
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(18);
        make.right.mas_equalTo(right.mas_left).offset(-20);
        make.height.mas_equalTo(37);
        make.width.mas_equalTo(SCREEN_WIDTH*0.36);
        make.top.mas_equalTo(_imgView.mas_bottom).offset(25);
    }];
    
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-18);
        make.width.mas_equalTo(left);
        make.height.mas_equalTo(left);
        make.top.mas_equalTo(left);
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
