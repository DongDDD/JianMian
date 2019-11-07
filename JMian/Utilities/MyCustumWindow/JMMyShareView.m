//
//  JMMyShareView.m
//  JMian
//
//  Created by mac on 2019/11/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyShareView.h"

@implementation JMMyShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenAction)];
           [self.BGView addGestureRecognizer:tap];
    }
    return self;
}

- (IBAction)action1:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(myShareWechat1)]) {
        [_delegate myShareWechat1];
    }
}

- (IBAction)action2:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(myShareWechat2)]) {
          [_delegate myShareWechat2];
      }
}

-(void)hiddenAction{
   if (_delegate && [_delegate respondsToSelector:@selector(myShareDeleteAction)]) {
           [_delegate myShareDeleteAction];
       }

}
- (IBAction)deleteAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(myShareDeleteAction)]) {
              [_delegate myShareDeleteAction];
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
