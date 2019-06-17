//
//  JMPostGoodsImagesView.m
//  JMian
//
//  Created by mac on 2019/6/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPostGoodsImagesView.h"

@implementation JMPostGoodsImagesView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    
    }
    
    return self;
}
- (IBAction)btnAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(gotoUploadImageAction)]) {
        [_delegate gotoUploadImageAction];
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
