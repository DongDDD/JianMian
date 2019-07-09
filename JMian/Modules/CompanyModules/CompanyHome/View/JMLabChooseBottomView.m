//
//  JMLabChooseView.m
//  JMian
//
//  Created by mac on 2019/7/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMLabChooseBottomView.h"

@implementation JMLabChooseBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
       
    }
    return self;
}

- (IBAction)leftAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(labChooseBottomLeftAction)]) {
        [_delegate labChooseBottomLeftAction];
    }
    
}

- (IBAction)rightAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(labChooseBottomRightAction)]) {
        [_delegate labChooseBottomRightAction];
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
