//
//  JMNotificationHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMNotificationHeaderTableViewCell.h"
#import "Masonry.h"
#import "DimensMacros.h"

@implementation JMNotificationHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
       
        
        self.backgroundColor = [UIColor whiteColor];
        UIView *iconView = [[UIView alloc]init];
        iconView.backgroundColor = MASTER_COLOR;
        iconView.layer.masksToBounds = YES;
        iconView.layer.cornerRadius = 48 / 2.0;
        
        [self.contentView addSubview:iconView];
        
        
        UIImageView *iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"share"] ];
        [iconView addSubview:iconImg];
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(48);
            make.left.mas_equalTo(self).offset(20);
            make.top.mas_equalTo(self).offset(15);
            
        }];
        
        [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
            make.center.mas_equalTo(iconView);
            
        }];
//
        UILabel *iconTipLab= [[UILabel alloc]init];
        iconTipLab.backgroundColor = [UIColor colorWithRed:255/255.0 green:56/255.0 blue:89/255.0 alpha:1.0];
        iconTipLab.layer.cornerRadius =9;
        iconTipLab.layer.masksToBounds = YES;
        iconTipLab.textColor = [UIColor whiteColor];
        iconTipLab.font = [UIFont systemFontOfSize:12];
        iconTipLab.text = @"6";
        iconTipLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:iconTipLab];

        [iconTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(18);
            make.top.mas_equalTo(iconView);
            make.right.mas_equalTo(iconView);

        }];

        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.textColor = TITLE_COLOR;
        titleLab.text = @"站内信";
        titleLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLab];

        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(iconView.mas_right).offset(15);
            make.centerY.mas_equalTo(iconView);
            make.height.mas_equalTo(15);
        }];


        UIImageView *rightImg = [[UIImageView alloc]init];
        rightImg.image = [UIImage imageNamed:@"icon_return "];
        [self.contentView addSubview:rightImg];

        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-20);
            make.centerY.mas_equalTo(titleLab);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(11);
        }];

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
