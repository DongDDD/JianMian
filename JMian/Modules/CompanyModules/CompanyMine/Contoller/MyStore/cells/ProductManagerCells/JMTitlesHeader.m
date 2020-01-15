//
//  JMTitlesHeader.m
//  JMian
//
//  Created by mac on 2020/1/11.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMTitlesHeader.h"
#import "DimensMacros.h"
@implementation JMTitlesHeader


-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)];
        _btn1.titleLabel.font = kFont(15);
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn1 setTitle:@"一级类目" forState:UIControlStateNormal];
        _btn2 = [[UIButton alloc]initWithFrame:CGRectMake( _btn1.frame.size.width, 0, self.frame.size.width/2, self.frame.size.height)];
        _btn2.titleLabel.font = kFont(15);
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn2 setTitle:@"二级类目" forState:UIControlStateNormal];
        
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, _btn1.frame.size.width, 1)];
        _footerView.backgroundColor = MASTER_COLOR;
        [self addSubview:_btn1];
        [self addSubview:_btn2];
        [self addSubview:_footerView];
        
     
    }
    return self;
}

-(void)btn1Selected{
    _viewType = JMCategoriesTypeFirst;
    [_btn2 setHidden:YES];
    [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _footerView.frame = CGRectMake(0, self.frame.size.height - 1, _btn1.frame.size.width, 1);

    }];
    
}

-(void)btn2Selected{
    _viewType = JMCategoriesTypeSecond;
    [_btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btn2 setHidden:NO];
    [UIView animateWithDuration:0.2 animations:^{
        _footerView.frame= CGRectMake( _btn1.frame.size.width, self.frame.size.height - 1, _btn1.frame.size.width, 1);

    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
