//
//  JMBUserPostPositionTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserPostPositionTableViewCell.h"
#import "DimensMacros.h"
@interface JMBUserPostPositionTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *rightLab;


@end



@implementation JMBUserPostPositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
