//
//  JMBUserMineSectionView.m
//  JMian
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserMineSectionView.h"
#import "DimensMacros.h"

@interface JMBUserMineSectionView ()


@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation JMBUserMineSectionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"tiao"];
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(4);
            make.left.mas_equalTo(self).offset(13);
            make.centerY.mas_equalTo(self);
        }];
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = TITLE_COLOR;
        _titleLab.font = kFont(16);
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self);
            make.left.mas_equalTo(self).offset(30);
            make.centerY.mas_equalTo(self);
            
        }];
    }
    return self;
}

-(void)setTitleStr:(NSString *)titleStr{

    _titleLab.text = titleStr;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
