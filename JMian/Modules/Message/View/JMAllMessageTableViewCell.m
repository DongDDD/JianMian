//
//  JMAllMessageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMAllMessageTableViewCell.h"
#import "DimensMacros.h"

@implementation JMAllMessageTableViewCellData 

@end


@interface JMAllMessageTableViewCell ()

@property (nonatomic, strong) JMAllMessageTableViewCellData *data;
@property (nonatomic ,strong) JMMessageListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
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
    self.lastChatTimeLbel.text = _data.time;
    self.lastChatLabel.text = _data.subTitle;
    
//    [_unReadView setNum:_data.unRead];
//    [self defaultLayout];
}

- (void)setModel:(JMMessageListModel *)model
{
    _model = model;
    self.userNameLabel.text = model.sender_nickname;
    self.iconImageView.image = GETImageFromURL(model.sender_avatar);
    self.userLabel.text = model.work_work_name;
    
}

@end
