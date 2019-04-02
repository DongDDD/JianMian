//
//  MapView.m
//  JMian
//
//  Created by mac on 2019/3/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MapView.h"
#import "Masonry.h"


@implementation MapView



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
       //放地图
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor blueColor];
        [bgView addSubview:view];

        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(bgView);
            make.height.mas_equalTo(224);
            make.top.mas_equalTo(iconImg.mas_bottom).offset(13);
        }];
        
        UILabel *adrContentLab = [[UILabel alloc]init];
        adrContentLab.text = @"广州 - 天河区 - 华夏路30号富力盈通";
        adrContentLab.font = [UIFont systemFontOfSize:15];
        adrContentLab.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:1.0];
        [bgView addSubview:adrContentLab];
        
        [adrContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconImg.mas_right).offset(10);
            make.height.mas_equalTo(14);
            make.centerY.mas_equalTo(iconImg);
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
