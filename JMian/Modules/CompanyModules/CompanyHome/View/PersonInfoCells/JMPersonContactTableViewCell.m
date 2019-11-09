//
//  JMPersonContactTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonContactTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMPersonContactTableViewCellIdentifier = @"JMPersonContactTableViewCellIdentifier";

@implementation JMPersonContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMVitaDetailModel *)model{
    JMUserInfoModel *userModel = [JMUserInfoManager getUserInfo];
    if ([userModel.deadline isEqualToString:@"0"]) {
        
        self.telephoneLab.text =[model.user_phone stringByReplacingOccurrencesOfString:[model.user_phone substringWithRange:NSMakeRange(2,5)]withString:@"*****"];
        self.emailLab.text =[model.user_email stringByReplacingOccurrencesOfString:[model.user_email substringWithRange:NSMakeRange(3,6)]withString:@"******"];
    }else{
        self.telephoneLab.text = model.user_phone;
        self.emailLab.text = model.user_email;
        [self.vipBtn setHidden:YES];
    }

}


- (IBAction)vipAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(vipAction)]) {
        [_delegate vipAction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
