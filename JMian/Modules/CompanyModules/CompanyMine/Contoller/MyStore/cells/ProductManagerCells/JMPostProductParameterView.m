//
//  JMPostProductParameterView.m
//  JMian
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMPostProductParameterView.h"

@implementation JMPostProductParameterView
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
