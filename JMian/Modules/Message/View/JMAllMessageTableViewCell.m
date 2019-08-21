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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}


- (void)setData:(JMMessageListModel *)data
{
    _data = data;
    self.userLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;    //中间的内容以……方式省略，显示头尾的文字内容
    if ([data.data.convId isEqualToString:@"dominator"]) {
        self.userNameLabel.text = @"系统消息";
        [self.iconImageView setImage:[UIImage imageNamed:@"notification"]];
        [self.userLabel setHidden:YES];
    }
    
    
    JMUserInfoModel *model = [JMUserInfoManager getUserInfo];
/*****这里思路是假设一种情况先，我登录了B端账号，判断自己是不是sender就行，是的话我要去n哪边的值才是合理的，！！否则相反！！，！！否则相反！！！！否则相反！！没可能我是B端我把B端的东西赋值上去吧*****/
    if([model.type isEqualToString:B_Type_UESR]){
        //B端情况下,你显示的永远只是work_name，我是企业看到的肯定是工作职位，我看毛公司名称啊！
        if ([data.type isEqualToString:@"2"]) {
            //兼职类型
            self.userLabel.text = data.job_type_label_name;

        }else if ([data.type isEqualToString:@"1"]) {
            //全职类型
            self.userLabel.text = data.work_work_name;

        }
        
    }else if ([model.type isEqualToString:C_Type_USER]) {
        //否则相反:我登录了C端账号，判断自己是不是sender就行（最简单的思路，就是跟上面显示的相反就行）
        if ([data.type isEqualToString:@"2"]) {
            //兼职类型
             self.userLabel.text = [NSString stringWithFormat:@"%@-%@",data.work_task_title,data.sender_company_position];
        }else if ([data.type isEqualToString:@"1"]) {
            //全职类型
            self.userLabel.text = [NSString stringWithFormat:@"%@-%@",data.workInfo_company_name,data.sender_company_position];
            
        }
        
    }
    
    if (model.user_id == data.sender_user_id) {
        //自己是senderID ,那你要显示的信息就在recipient里面
        if (data.recipient_nickname .length > 0) {
            self.userNameLabel.text = data.recipient_nickname;
        }else{
            self.userNameLabel.text = data.recipient_phone;
        }
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.recipient_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];

        
    }else if (model.user_id == data.recipient_user_id){
        //自己是recipientID ,那你要显示的信息就在sender里面
        if (data.sender_nickname.length > 0) {
            self.userNameLabel.text = data.sender_nickname;
        }else{
            self.userNameLabel.text = data.sender_phone;
        }
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:data.sender_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    }
    
    if (data.data.unRead <= 0) {
        [self.unReadLab setHidden:YES];
    }else{
        [self.unReadLab setHidden:NO];
        
        self.unReadLab.text =  [NSString stringWithFormat:@"%d",data.data.unRead];
    }
    
    self.lastChatTimeLbel.text = data.data.time;
    self.lastChatLabel.text = data.data.subTitle;
    
}

@end
