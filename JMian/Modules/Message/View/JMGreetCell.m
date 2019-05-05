//
//  JMGreetCell.m
//  JMian
//
//  Created by mac on 2019/5/4.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMGreetCell.h"
#import "Masonry.h"

@implementation JMGreetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"copyreader"] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(15);
            make.centerY.mas_equalTo(self.contentView);
            make.width.and.height.mas_equalTo(13);
        }];
//        [self setupViews];
    }
    return self;
}


@end
