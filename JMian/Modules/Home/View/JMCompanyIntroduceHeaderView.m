//
//  JMCompanyIntroduceHeaderView.m
//  JMian
//
//  Created by mac on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCompanyIntroduceHeaderView.h"
#import "DimensMacros.h"
#import "Masonry.h"


@implementation JMCompanyIntroduceHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
 
        UIImageView *iconImg = [[UIImageView alloc]init];
        iconImg.image = [UIImage imageNamed:@"JIANMIAN_logo"];
        iconImg.layer.borderWidth = 0.5;
        iconImg.layer.borderColor = XIAN_COLOR.CGColor;
        
        [self addSubview:iconImg];
        
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.mas_left).offset(17);
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_top).offset(23);
            make.height.and.width.mas_equalTo(96);
            
        }];
        
        
        
        
        
        
        
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
