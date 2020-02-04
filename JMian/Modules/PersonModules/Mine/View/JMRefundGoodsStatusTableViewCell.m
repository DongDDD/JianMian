//
//  JMRefundGoodsStatusTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/4.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMRefundGoodsStatusTableViewCell.h"
NSString *const JMRefundGoodsStatusTableViewCellIdentifier = @"JMRefundGoodsStatusTableViewCellIdentifier";

@implementation JMRefundGoodsStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.imageRight setImage:[UIImage imageNamed:@"add_selected"]];
        
    }else{
        [self.imageRight setImage:[UIImage imageNamed:@"圆角矩形 5"]];
    }
    // Configure the view for the selected state
}

@end
