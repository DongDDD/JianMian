//
//  JMUserProfileAdressTableViewCell.m
//  JMian
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMUserProfileAdressTableViewCell.h"
NSString *const JMUserProfileAdressTableViewCellIdentifier = @"JMUserProfileAdressTableViewCellIdentifier";

@implementation JMUserProfileAdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCompanyInfoModel *)model{
    self.adressLab.text = model.address;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
