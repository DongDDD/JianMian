//
//  JMNotificationTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMNotificationTableViewCell.h"
#import "DimensMacros.h"
#import "Masonry.h"

@implementation JMNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView * xian1View = [[UIView alloc]init];
        xian1View.backgroundColor = XIAN_COLOR;
        [self addSubview:xian1View];
        
        [xian1View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(82);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self);
        }];
        
        
        UILabel *massageLab = [[UILabel alloc]init];
        massageLab.text = @"恭喜。你的实名认证已经通过";
        massageLab.textColor = TEXT_GRAY_COLOR;
        massageLab.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:massageLab];
        
        [massageLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(13);
            make.left.mas_equalTo(self.contentView.mas_left).offset(82);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        
        
    }
     return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
