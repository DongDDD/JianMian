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
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChatTimeLbel;

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
    self.iconImageView.image = [UIImage imageNamed:_data.head];
    self.lastChatTimeLbel.text = _data.time;
    self.lastChatLabel.text = _data.subTitle;
    self.userNameLabel.text = _data.title;
//    [_unReadView setNum:_data.unRead];
//    [self defaultLayout];
}


@end
