//
//  JMBUserPositionDetailView.m
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPositionDetailView.h"

@implementation JMBUserPositionDetailView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];

    }
    return self;
}

- (IBAction)textFieldEndEditing:(UITextField *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didWriteTextFieldWithTag:text:)]) {
        [_delegate didWriteTextFieldWithTag:sender.tag text:sender.text];
    }
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickRightBtnWithTag:)]) {
        [_delegate didClickRightBtnWithTag:sender.tag];
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
