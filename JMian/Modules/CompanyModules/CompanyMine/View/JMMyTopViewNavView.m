//
//  JMMyTopViewNavView.m
//  JMian
//
//  Created by mac on 2019/6/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyTopViewNavView.h"

@implementation JMMyTopViewNavView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}

- (IBAction)leftAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(backAction)]) {
        [_delegate backAction];
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
