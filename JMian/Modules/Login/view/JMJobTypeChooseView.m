//
//  JMJobTypeChooseView.m
//  JMian
//
//  Created by mac on 2019/9/10.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMJobTypeChooseView.h"

@implementation JMJobTypeChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}
- (IBAction)jobAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(jobActionDelegate)]) {
        [_delegate jobActionDelegate];
    }
}
- (IBAction)partTimeJobAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(partTimeJobActionDelegate)]) {
        [_delegate partTimeJobActionDelegate];
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
