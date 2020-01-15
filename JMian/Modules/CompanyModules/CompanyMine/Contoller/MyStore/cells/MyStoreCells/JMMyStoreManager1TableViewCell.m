//
//  JMMyStoreManager1TableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMMyStoreManager1TableViewCell.h"
NSString *const JMMyStoreManager1TableViewCellIdentifier = @"JMMyStoreManager1TableViewCellIdentifierIdentifier";

@implementation JMMyStoreManager1TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.BGView.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:31/255.0 blue:87/255.0 alpha:0.1].CGColor;
    self.BGView.layer.shadowOffset = CGSizeMake(0,1);
    self.BGView.layer.shadowOpacity = 1;
    self.BGView.layer.shadowRadius = 6;
    self.BGView.layer.cornerRadius = 10;
    self.BGView.backgroundColor = [UIColor whiteColor];
    // Initialization code
}

- (IBAction)manager1Action:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectStoreManager1ItemWithRow:)]) {
        [_delegate didSelectStoreManager1ItemWithRow:sender.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
