//
//  JMAllMessageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAllMessageTableViewCell.h"
#import "DimensMacros.h"

//@implementation JMAllMessageTableViewCellData 
//
//@end


@interface JMAllMessageTableViewCell ()

//@property (nonatomic, strong) JMAllMessageTableViewCellData *data;
@property (nonatomic ,strong) JMMessageListModel *data;


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

//- (void)setData:(JMAllMessageTableViewCellData *)data
//{
//    _data = data;
////    [_unReadView setNum:_data.unRead];
////    [self defaultLayout];
//}

- (void)setData:(JMMessageListModel *)data
{
    _data = data;
    self.userNameLabel.text = data.recipient_nickname;
    self.iconImageView.image = GETImageFromURL(data.recipient_avatar);
    self.userLabel.text = data.work_work_name;
    
    self.lastChatTimeLbel.text = data.data.time;
    self.lastChatLabel.text = data.data.subTitle;
    
}

@end
