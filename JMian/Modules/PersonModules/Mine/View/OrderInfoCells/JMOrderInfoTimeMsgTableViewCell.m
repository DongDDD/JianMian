//
//  JMOrderInfoTimeMsgTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderInfoTimeMsgTableViewCell.h"
NSString *const JMOrderInfoTimeMsgTableViewCellIdentifier = @"JMOrderInfoTimeMsgTableViewCellIdentifier";

@implementation JMOrderInfoTimeMsgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setValuesWithTime1:(NSString *)time1 time2:(NSString *)time2{
    
    self.time1Lab.text =  [NSString stringWithFormat:@"创建时间 :%@",time1];
    if (time2) {
        self.time2Lab.text =  [NSString stringWithFormat:@"付款时间 :%@",time2];
    }else{
        [self.time2Lab setHidden:YES];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
