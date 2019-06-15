//
//  JMMakeOutBillHeaderView.m
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMakeOutBillHeaderView.h"
@interface JMMakeOutBillHeaderView ()


@end

@implementation JMMakeOutBillHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
//        [_YESBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateSelected];
//        [_YESBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
//        [_NOBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateSelected];
//        [_NOBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    }
    return self;
}

- (IBAction)YESAction:(UIButton *)sender {
    [_NOBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];
    [_YESBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];

    if (_delegate && [_delegate respondsToSelector:@selector(didClickBillActionWithTag:) ]) {
        [_delegate didClickBillActionWithTag:sender.tag];
    }
}

- (IBAction)NOAction:(UIButton *)sender {
    [_NOBtn setImage:[UIImage imageNamed:@"组 54"] forState:UIControlStateNormal];
    [_YESBtn setImage:[UIImage imageNamed:@"椭圆 3"] forState:UIControlStateNormal];

    if (_delegate && [_delegate respondsToSelector:@selector(didClickBillActionWithTag:) ]) {
        [_delegate didClickBillActionWithTag:sender.tag];
    }
}
- (IBAction)adressAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(chooseAdressAction) ]) {
        [_delegate chooseAdressAction];
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
