//
//  JMTaskApplyForView.m
//  JMian
//
//  Created by mac on 2019/7/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMTaskApplyForView.h"

@implementation JMTaskApplyForView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        _isReadBtn.selected = NO;
        [_isReadBtn setImage:[UIImage imageNamed:@"YES_Post"] forState:UIControlStateSelected];
        [_isReadBtn setImage:[UIImage imageNamed:@"gou_partTime"] forState:UIControlStateNormal];
    }
    return self;
}
    
- (IBAction)isReadAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(isReadProtocol:)]) {
        
        [_delegate isReadProtocol:sender.selected];
    }
    
}
    
- (IBAction)leftAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(applyForViewDeleteAction)]) {
       
        [_delegate applyForViewDeleteAction];
    }
    
}
- (IBAction)comfirmAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(applyForViewComfirmAction)]) {
       
        [_delegate applyForViewComfirmAction];
    }
}
    
@end
