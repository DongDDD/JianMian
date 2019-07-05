//
//  JMApplyForProtocolView.m
//  JMian
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMApplyForProtocolView.h"

@implementation JMApplyForProtocolView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
        _agreeBtn.selected = YES;
        [_agreeBtn setImage:[UIImage imageNamed:@"YES_Post"] forState:UIControlStateSelected];
        [_agreeBtn setImage:[UIImage imageNamed:@"gou_partTime"] forState:UIControlStateNormal];
    }
    return self;
}

- (IBAction)agreeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(isReadProtocol:)]) {
        [_delegate isReadProtocol:sender.selected];
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
