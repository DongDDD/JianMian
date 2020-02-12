//
//  JMSelectTaskTypeView.m
//  JMian
//
//  Created by mac on 2020/2/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMSelectTaskTypeView.h"
@interface JMSelectTaskTypeView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation JMSelectTaskTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:beffect];
        view.frame = self.bounds;
        [self addSubview:view];
        [self addSubview:_bgView];
    }
    return self;
}


- (IBAction)postTaskAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickTaskTypeWithTag:)]) {
        [_delegate didClickTaskTypeWithTag:sender.tag];
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
