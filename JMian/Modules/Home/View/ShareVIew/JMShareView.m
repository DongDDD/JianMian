//
//  JMShareView.m
//  JMian
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMShareView.h"

@implementation JMShareView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"JMShareView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (IBAction)cancel:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(shareViewCancelAction)]) {
        [_delegate shareViewCancelAction];
    }
    
}


- (IBAction)leftAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(shareViewLeftAction)]) {
        [_delegate shareViewLeftAction];
    }
    
}

- (IBAction)rightAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(shareViewRightAction)]) {
        [_delegate shareViewRightAction];
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
