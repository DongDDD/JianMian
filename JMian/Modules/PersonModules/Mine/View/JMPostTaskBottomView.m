//
//  JMPostTaskBottomView.m
//  JMian
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostTaskBottomView.h"

@implementation JMPostTaskBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}

- (IBAction)postTaskAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(didClickPostAction)]) {
        [_delegate didClickPostAction];
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
