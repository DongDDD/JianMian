//
//  JMAfterSalesDetailTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMAfterSalesDetailTableViewCell.h"
NSString *const JMAfterSalesDetailTableViewCellIdentifier = @"JMAfterSalesDetailTableViewCellIdentifier";

@implementation JMAfterSalesDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setValuesWithTime:(NSString *)time price:(NSString *)price msg:(NSString *)msg{
    self.titleLab1.text = [NSString stringWithFormat:@"申请时间 :   %@",time];;
    self.titleLab2.text = [NSString stringWithFormat:@"退款金额 :  ¥ %@",price];
    self.titleLab3.text = [NSString stringWithFormat:@"退款原因 :  %@",msg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
