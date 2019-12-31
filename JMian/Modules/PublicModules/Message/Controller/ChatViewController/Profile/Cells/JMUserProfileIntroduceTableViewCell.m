//
//  JMUserProfileIntroduceTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfileIntroduceTableViewCell.h"
NSString *const JMUserProfileIntroduceTableViewCellIdentifier = @"JMUserProfileIntroduceTableViewCellIdentifier";

@implementation JMUserProfileIntroduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setIntroduceStr:(NSString *)introduceStr{
    self.introduceLab.text = introduceStr;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
