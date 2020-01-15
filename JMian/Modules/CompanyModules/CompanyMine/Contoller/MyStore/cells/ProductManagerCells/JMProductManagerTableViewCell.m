//
//  JMProductManagerTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductManagerTableViewCell.h"
NSString *const JMProductManagerTableViewCellIdentifier = @"JMProductManagerTableViewCellIdentifier";

@implementation JMProductManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)btnAction:(UIButton *)sender {
    [self.bottomBtn1 setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
