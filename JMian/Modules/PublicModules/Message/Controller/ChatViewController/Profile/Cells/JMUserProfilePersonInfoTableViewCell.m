//
//  JMUserProfilePersonInfoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfilePersonInfoTableViewCell.h"
NSString *const JMUserProfilePersonInfoTableViewCellIdentifier = @"JMUserProfilePersonInfoTableViewCellIdentifier";

@implementation JMUserProfilePersonInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setBirthDay:(NSString *)birthDay email:(NSString *)email{
    self.birthDay.text = birthDay;
    self.email.text = email;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
