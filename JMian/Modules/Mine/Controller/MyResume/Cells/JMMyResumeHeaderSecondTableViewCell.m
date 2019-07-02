//
//  JMMyResumeHeaderSecondTableViewCell.m
//  JMian
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMyResumeHeaderSecondTableViewCell.h"

NSString *const JMMyResumeHeaderSecondTableViewCellIdentifier = @"JMMyResumeHeaderSecondTableViewCellIdentifier";
@interface JMMyResumeHeaderSecondTableViewCell ()

@end

@implementation JMMyResumeHeaderSecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setWorkStatus:(NSString *)workStatus{
    
    if ([workStatus isEqualToString:@"4"]) {
        
        self.rightLab.text = @"应届生";
    }else if ([workStatus isEqualToString:@"1"]) {
        self.rightLab.text = @"在职";

    }else if ([workStatus isEqualToString:@"2"]) {
        self.rightLab.text = @"离职";

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
