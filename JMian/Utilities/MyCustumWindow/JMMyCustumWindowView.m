//
//  JMMyCustumWindowView.m
//  JMian
//
//  Created by mac on 2019/7/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyCustumWindowView.h"

@implementation JMMyCustumWindowView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}
- (IBAction)leftAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(windowLeftAction)]) {
        [_delegate windowLeftAction];
    }
    
}

- (IBAction)rightAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(windowRightAction)]) {
        [_delegate windowRightAction];
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
