//
//  JMOderInfoBtnTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOderInfoBtnTableViewCell.h"
NSString *const JMOderInfoBtnTableViewCellIdentifier = @"JMOderInfoBtnTableViewCellIdentifier";
@interface JMOderInfoBtnTableViewCell ()


@end

@implementation JMOderInfoBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//-(void)setViewType:(JMOderInfoBtnTableViewCelllType)viewType{
//    switch (self.viewType) {
//        case JMOderInfoBtnTypeTradeSuccessfully:
//            [self.btn2 setHidden:NO];
//            break;
//        case JMOderInfoBtnTypeNoPay:
//            [self.btn2 setHidden:NO];
//            break;
//        case JMOderInfoBtnTypeDidRefund:
//            [self.btn2 setHidden:NO];
//            break;
//        case JMOderInfoBtnTypeDidDeliverGoods:
//            [self.btn2 setHidden:NO];
//            [self.btn4 setHidden:NO];
//            break;
//        default:
//            break;
//    }
//    
//}

- (IBAction)btnAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBtnWithBtnTtitle:)]) {
        [_delegate didClickBtnWithBtnTtitle:sender.titleLabel.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
