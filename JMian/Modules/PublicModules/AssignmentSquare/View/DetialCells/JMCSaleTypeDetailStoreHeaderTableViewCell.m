//
//  JMCSaleTypeDetailStoreHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMCSaleTypeDetailStoreHeaderTableViewCell.h"
NSString *const JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier = @"JMCSaleTypeDetailStoreHeaderTableViewCellIdentifier";

@implementation JMCSaleTypeDetailStoreHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMShopModel *)model{
    self.titleLab.text  = model.shop_name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
