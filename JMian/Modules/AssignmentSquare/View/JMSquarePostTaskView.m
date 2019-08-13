//
//  JMSquarePostTaskView.m
//  JMian
//
//  Created by mac on 2019/8/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMSquarePostTaskView.h"

@implementation JMSquarePostTaskView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    _postBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    _postBtn.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:43/255.0 blue:92/255.0 alpha:0.18].CGColor;
    _postBtn.layer.shadowOffset = CGSizeMake(0,0);
    _postBtn.layer.shadowOpacity = 1;
    _postBtn.layer.shadowRadius = 5;
    _postBtn.layer.cornerRadius = 2;
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (IBAction)postTaskAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(didClickPostTaskAction)]) {
        [_delegate didClickPostTaskAction];
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
