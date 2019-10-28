//
//  JMloginsucceedView.m
//  JMian
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMloginsucceedView.h"

@implementation JMloginsucceedView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    }
    return self;
}

- (IBAction)deleteAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(deleteLoginsucceedViewAction)]) {
        [_delegate deleteLoginsucceedViewAction];
    }
}

- (IBAction)wanshanAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(gotoVideoViewAction)]) {
        [_delegate gotoVideoViewAction];
        
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
