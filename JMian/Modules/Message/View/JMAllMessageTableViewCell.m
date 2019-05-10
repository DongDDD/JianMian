//
//  JMAllMessageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAllMessageTableViewCell.h"
#import "DimensMacros.h"
#import "JMUserInfoModel.h"

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
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
    if (model.user_id == data.sender_user_id) {
        self.userNameLabel.text = data.recipient_nickname;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.recipient_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        self.iconImageView.image = GETImageFromURL(data.recipient_avatar);
        
    }else{
        self.userNameLabel.text = data.sender_nickname;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.sender_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        
        
    }
    
    self.userLabel.text = data.work_work_name;
    self.lastChatTimeLbel.text = data.data.time;
    self.lastChatLabel.text = data.data.subTitle;
    
}

@end
