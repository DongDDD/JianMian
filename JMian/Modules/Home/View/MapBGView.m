//
//  MapView.m
//  JMian
//
//  Created by mac on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MapBGView.h"
#import "Masonry.h"


@implementation MapBGView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}


-(void)setModel:(JMHomeWorkModel *)model
{

    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(386);
        make.top.mas_equalTo(self);
    }];
    
    //
    UILabel *adrLab = [[UILabel alloc]init];
    adrLab.text = @"公司地址";
    adrLab.font = [UIFont systemFontOfSize:17];
    adrLab.textColor = [UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
    [bgView addSubview:adrLab];
    
    [adrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(22);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.mas_top).offset(30);
    }];
    
    //
    //定位贴图
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.image = [UIImage imageNamed:@"Location_of_detail_page"];
    [self addSubview:iconImg];
    
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(22);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(adrLab.mas_top).offset(25);
    }];
    //
    //
    
    UILabel *adrContentLab = [[UILabel alloc]init];
    adrContentLab.text = model.address;
    adrContentLab.font = [UIFont systemFontOfSize:15];
    adrContentLab.numberOfLines = 0;
    adrContentLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
    [bgView addSubview:adrContentLab];
//    NSLog(@"-------%@",model.ade);
    [adrContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImg.mas_right).offset(10);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.top.mas_equalTo(adrLab.mas_bottom).offset(10);
    }];
    

    UIView * xian1View = [[UIView alloc]init];
    xian1View.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    [self addSubview:xian1View];
    
    [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).offset(22);
        make.right.mas_equalTo(bgView.mas_right).offset(-22);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(bgView.mas_top);
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
