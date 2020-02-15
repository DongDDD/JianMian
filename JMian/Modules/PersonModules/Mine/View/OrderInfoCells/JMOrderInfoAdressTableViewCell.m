//
//  JMOrderInfoAdressTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoAdressTableViewCell.h"
NSString *const JMOrderInfoAdressTableViewCellIdentifier = @"JMOrderInfoAdressTableViewCellIdentifier";

@implementation JMOrderInfoAdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setValuesWithName:(NSString *)name phone:(NSString *)phone adress:(NSString *)adress{
    
    self.nameLab.text = name;
    self.phoneLab.text = phone;
    self.adressLab.text = adress;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
