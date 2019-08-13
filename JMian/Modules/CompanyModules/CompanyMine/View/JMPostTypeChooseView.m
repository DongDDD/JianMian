//
//  JMPostTypeChooseView.m
//  JMian
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostTypeChooseView.h"

@implementation JMPostTypeChooseView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)didChoosePostType:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedPostTypeWithTag:)]) {
        [_delegate didSelectedPostTypeWithTag:sender.tag];
    }
}

@end
