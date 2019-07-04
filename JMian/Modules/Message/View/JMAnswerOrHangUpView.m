//
//  JMAnswerOrHangUpView.m
//  JMian
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAnswerOrHangUpView.h"
#import "DimensMacros.h"
#import "Masonry.h"

@implementation JMAnswerOrHangUpView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        [self initView];
        [self playSounds];
        [_player play];
    }
    return self;
}

-(void)initView{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = @"对方邀请你视频面试...";
    lab.textColor = [UIColor whiteColor];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
    UIButton *answerBtn = [[UIButton alloc]init];
    [answerBtn setImage:[UIImage imageNamed:@"answer"] forState:UIControlStateNormal];
    [answerBtn addTarget: self action:@selector(answerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:answerBtn];
    
    [answerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(60);
        make.top.mas_equalTo(lab).mas_offset(220);
        make.centerX.mas_equalTo(self).offset(-90);
    }];
    
    UILabel *answerLab = [[UILabel alloc]init];
    answerLab.text = @"接听";
    answerLab.textColor = [UIColor whiteColor];
    [self addSubview:answerLab];

    [answerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(answerBtn);
        make.top.mas_equalTo(answerBtn.mas_bottom).mas_offset(10);
    }];
    
    
    UIButton *hangupBtn = [[UIButton alloc]init];
    [hangupBtn setImage:[UIImage imageNamed:@"hangUpButton"] forState:UIControlStateNormal];
    [hangupBtn addTarget: self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:hangupBtn];
    
    [hangupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(60);
        make.top.mas_equalTo(lab).mas_offset(220);
        make.centerX.mas_equalTo(self).offset(90);
    }];
    
    
    UILabel *hangupLab = [[UILabel alloc]init];
    hangupLab.text = @"挂断";
    hangupLab.textColor = [UIColor whiteColor];
    [self addSubview:hangupLab];
    
    [hangupLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(hangupBtn);
        make.top.mas_equalTo(hangupBtn.mas_bottom).mas_offset(10);
    }];
    
}


-(void)answerBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(answerAction)]) {
        [_delegate answerAction];
    }
}

-(void)closeBtnAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickClose)]) {
        [_delegate didClickClose];
    }
   
}


-(void)playSounds{
    NSError *err;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"videoMeet" withExtension:@"mp3"];
    //    初始化播放器
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    //    设置播放器声音
    //    设置播放速率
    _player.rate = 1.0;
    //    设置播放次数 负数代表无限循环
    _player.numberOfLoops = -1;
    //    准备播放
    [_player prepareToPlay];
    
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(change) userInfo:nil repeats:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
