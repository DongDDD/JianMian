//
//  JMProductManagerTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMProductManagerTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMProductManagerTableViewCellIdentifier = @"JMProductManagerTableViewCellIdentifier";

@implementation JMProductManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMGoodsData *)data{
    self.titleLab.text = data.title;
    self.priceLab.text =  [NSString stringWithFormat:@"¥  %@", data.price];
    if ([data.status isEqualToString:@"1"]) {
        [self.bottomBtn1 setHidden:NO];
        [self.bottomBtn2 setHidden:YES];
        [self.bottomBtn3 setHidden:NO];
    }else if ([data.status isEqualToString:@"0"]) {
        [self.bottomBtn1 setHidden:NO];
        [self.bottomBtn2 setHidden:NO];
        [self.bottomBtn3 setHidden:YES];
    }
    
    
}

- (IBAction)btnAction:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
