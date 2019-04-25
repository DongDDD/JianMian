//
//  JMUserChangeWindowView.m
//  JMian
//
//  Created by mac on 2019/4/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserChangeWindowView.h"

@implementation JMUserChangeWindowView

//+(JMUserChangeWindowView *)sharedUserChangeWindow{
//    static dispatch_once_t onceToken;
//    static JMUserChangeWindowView *shareUserChangeWindow;
//    dispatch_once(&onceToken, ^{
//        shareUserChangeWindow = [[JMUserChangeWindowView alloc]init];
//    });
//    return shareUserChangeWindow;
//}
//
//
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"JMUserChangeWindowView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
   
    return self;
}
- (IBAction)OKAction:(UIButton *)sender {
    [self.delegate OKAction];
}
- (IBAction)deleteAction:(UIButton *)sender {
    [self.delegate deleteAction];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
