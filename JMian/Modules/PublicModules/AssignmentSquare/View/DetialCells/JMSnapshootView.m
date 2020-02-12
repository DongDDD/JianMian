//
//  JMSnapshootView.m
//  JMian
//
//  Created by mac on 2020/2/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMSnapshootView.h"

@implementation JMSnapshootView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (IBAction)newDataAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickNewDataBtn)]) {
        [_delegate didClickNewDataBtn];
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
