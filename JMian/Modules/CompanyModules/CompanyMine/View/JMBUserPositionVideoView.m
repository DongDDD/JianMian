//
//  JMBUserPositionVideoView.m
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPositionVideoView.h"

@implementation JMBUserPositionVideoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}

- (IBAction)leftBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoLeftBtnAction)]) {
        [_delegate videoLeftBtnAction];
    }
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoRightBtnAction)]) {
        [_delegate videoRightBtnAction];
    }
}

- (IBAction)playAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playBtnAction)]) {
        [_delegate playBtnAction];
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
