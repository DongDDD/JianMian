//
//  JMAllMessageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAllMessageTableViewCell.h"


@implementation JMAllMessageTableViewCellData


@end

@interface JMAllMessageTableViewCell ()

@property (nonatomic, strong) JMAllMessageTableViewCellData *data;

@end

@implementation JMAllMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(JMAllMessageTableViewCellData *)data
{
    _data = data;
//    _headImageView.image = [UIImage imageNamed:_data.head];
//    _timeLabel.text = _data.time;
//    _titleLabel.text = _data.title;
//    _subTitleLabel.text = _data.subTitle;
//    [_unReadView setNum:_data.unRead];
//    [self defaultLayout];
}


@end
