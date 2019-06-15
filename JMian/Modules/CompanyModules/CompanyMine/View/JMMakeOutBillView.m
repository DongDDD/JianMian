//
//  JMMakeOutBillView.m
//  JMian
//
//  Created by mac on 2019/6/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMakeOutBillView.h"
@interface JMMakeOutBillView ()

@property (weak, nonatomic) IBOutlet UIImageView *taitouImg;
@property (weak, nonatomic) IBOutlet UIView *taitouView;
@property(nonatomic, assign)BOOL isSetTaitou;
@end

@implementation JMMakeOutBillView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _isSetTaitou = NO;
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.taitouView addGestureRecognizer:tap];
    }
    return self;
}
- (void)tapAction {
    if (!_isSetTaitou) {
        _taitouImg.image = [UIImage imageNamed:@"组 54"];
        _isSetTaitou = YES;
    }else{
        _taitouImg.image = [UIImage imageNamed:@"椭圆 3"];
        _isSetTaitou = NO;

    }
}

- (IBAction)invoiceTextFieldEditingDidEnd:(UITextField *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(invoiceTextFieldDidEditingEndWithTextField:)]) {
        [_delegate invoiceTextFieldDidEditingEndWithTextField:sender];
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
