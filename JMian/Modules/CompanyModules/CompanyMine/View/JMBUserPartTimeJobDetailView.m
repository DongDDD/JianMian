//
//  JMBUserPartTimeJobDetailView.m
//  JMian
//
//  Created by mac on 2019/6/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPartTimeJobDetailView.h"
@interface JMBUserPartTimeJobDetailView ()
@end
@implementation JMBUserPartTimeJobDetailView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickRightBtnWithTag:)]) {
        [_delegate didClickRightBtnWithTag:sender.tag];
    }
}

- (IBAction)textFieldEndEditing:(UITextField *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didWriteRightTextFieldWithtag:text:)]) {
        [_delegate didWriteRightTextFieldWithtag:sender.tag text:sender.text];
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
