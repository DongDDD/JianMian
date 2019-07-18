//
//  JMVIPInvoicePayTableViewCell.m
//  JMian
//
//  Created by mac on 2019/7/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMVIPInvoicePayTableViewCell.h"
@interface JMVIPInvoicePayTableViewCell ()

@end
@implementation JMVIPInvoicePayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectedImageView.image = [UIImage imageNamed:@"组 54"];
        if (_delegate && [_delegate respondsToSelector:@selector(didChoosePayWayWithPayName:)]) {
            [_delegate didChoosePayWayWithPayName:self.titleNameLab.text];
        }
        NSLog(@"被选");
    }else{
        self.selectedImageView.image = [UIImage imageNamed:@"椭圆 3"];

        NSLog(@"没被选");

    }
    // Configure the view for the selected state
}


@end
