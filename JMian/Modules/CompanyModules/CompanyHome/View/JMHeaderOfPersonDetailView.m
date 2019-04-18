//
//  JMHeaderOfPersonDetailView.m
//  JMian
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMHeaderOfPersonDetailView.h"

@implementation JMHeaderOfPersonDetailView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"JMHeaderOfPersonDetailView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
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

@end
