//
//  JMComfirmPostBottomView.m
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMComfirmPostBottomView.h"
@interface JMComfirmPostBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *didReadBtn;


@end

@implementation JMComfirmPostBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        _didReadBtn.selected = YES;
        [_didReadBtn setImage:[UIImage imageNamed:@"YES_Post"] forState:UIControlStateSelected];
        [_didReadBtn setImage:[UIImage imageNamed:@"gou_partTime"] forState:UIControlStateNormal];
    }
    
    return self;
}

- (IBAction)didReadAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
