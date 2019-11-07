//
//  JMMyResumeFooterView.m
//  JMian
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeFooterView.h"
#import "DimensMacros.h"

@implementation JMMyResumeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *addBtn = [[UIButton alloc]init];
        [addBtn addTarget:self action:@selector(addJobAction) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitle:@"添加求职意向" forState:UIControlStateNormal];
        [addBtn setTitleColor:MASTER_COLOR forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        addBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:254/255.0 blue:255/255.0 alpha:1.0];
        addBtn.layer.masksToBounds = YES;
        addBtn.layer.borderColor = MASTER_COLOR.CGColor;
        addBtn.layer.borderWidth = 0.5;
        [self addSubview:addBtn];
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(20);
            make.right.mas_equalTo(self).offset(-20);
            make.height.mas_equalTo(45);
            make.centerY.mas_equalTo(self);
            
        }];
        
        UIView *footer = [[UIView alloc]init];
        footer.backgroundColor = BG_COLOR;
        [self addSubview:footer];
        [footer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(10);
            make.centerX.mas_equalTo(self);
        }];
    }
    return self;
}

-(void)addJobAction{
    if (_delegate && [_delegate respondsToSelector:@selector(addJobAction)]) {
        [_delegate addJobAction];
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
