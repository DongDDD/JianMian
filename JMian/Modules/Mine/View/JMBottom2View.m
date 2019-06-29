//
//  JMBottom2View.m
//  JMian
//
//  Created by mac on 2019/6/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBottom2View.h"

@implementation JMBottom2View

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}
- (IBAction)leftAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomLeftActionDelegate)]) {
        [_delegate bottomLeftActionDelegate];
    }
}
- (IBAction)rightAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomRightActionDelegate)]) {
        [_delegate bottomRightActionDelegate];
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
