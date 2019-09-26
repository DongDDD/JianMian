//
//  JMVideoDetailInfoView.m
//  JMian
//
//  Created by mac on 2019/9/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVideoDetailInfoView.h"

@implementation JMVideoDetailInfoView


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

@end
