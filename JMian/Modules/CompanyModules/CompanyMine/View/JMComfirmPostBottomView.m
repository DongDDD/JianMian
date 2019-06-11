//
//  JMComfirmPostBottomView.m
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMComfirmPostBottomView.h"
@interface JMComfirmPostBottomView ()


@end

@implementation JMComfirmPostBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        [_didReadBtn setImage:[UIImage imageNamed:@"YES_Post"] forState:UIControlStateSelected];
        [_didReadBtn setImage:[UIImage imageNamed:@"gou_partTime"] forState:UIControlStateNormal];
    }
    
    return self;
}

- (IBAction)didReadAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(isReadProtocol:)]) {
        [_delegate isReadProtocol:sender.selected];
    }
}

- (IBAction)OKAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(OKAction)]) {
        [_delegate OKAction];
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
