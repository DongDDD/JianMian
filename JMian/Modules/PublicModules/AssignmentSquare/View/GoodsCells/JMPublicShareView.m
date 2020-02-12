//
//  JMPublicShareView.m
//  JMian
//
//  Created by mac on 2020/2/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMPublicShareView.h"
#import "DimensMacros.h"
@implementation JMPublicShareView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
             UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
             view.frame = self.bounds;
        [self addSubview:view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [view addGestureRecognizer:tap];
        [self addSubview:self.shareView];
        
        
    }
    return self;
}



-(void)show{
    [self setHidden:NO];
      [UIView animateWithDuration:0.3 animations:^{
          _shareView.frame = CGRectMake(0, self.frame.size.height-205+SafeAreaBottomHeight, self.frame.size.width, 205+SafeAreaBottomHeight);
      }];
}

-(void)hide{
    [self setHidden:YES];
    _shareView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 205+SafeAreaBottomHeight);
 
}

-(void)shareViewCancelAction{
    [self hide];
}
-(void)shareViewLeftAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickShareActoinWithTag:)]) {
        [_delegate didClickShareActoinWithTag:1000];
    }
}
-(void)shareViewRightAction{
    if (_delegate && [_delegate respondsToSelector:@selector(didClickShareActoinWithTag:)]) {
         [_delegate didClickShareActoinWithTag:1001];

    }
}
-(JMShareView *)shareView{
    if (!_shareView) {
        _shareView = [[JMShareView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 205+SafeAreaBottomHeight)];
        _shareView.delegate = self;
        [_shareView.btn1 setImage:[UIImage imageNamed:@"WeChat"] forState:UIControlStateNormal];
        [_shareView.btn2 setImage:[UIImage imageNamed:@"Friendster"] forState:UIControlStateNormal];
        _shareView.lab1.text = @"微信分享";
        _shareView.lab2.text = @"朋友圈";
    }
    return _shareView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
