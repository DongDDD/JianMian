//
//  JMCustomAnnotationView.m
//  JMian
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCustomAnnotationView.h"

@implementation JMCustomAnnotationView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.layer.shadowColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:0.24].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2);
        self.layer.shadowOpacity = 1;
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
