//
//  JMTaskMessageTableViewCell.m
//  JMian
//
//  Created by mac on 2020/3/22.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMTaskMessageTableViewCell.h"

@implementation JMTaskMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillWithData:(JMTaskMessageCellData *)data;
{
    [super fillWithData:data];
    self.taskData = data;
}
@end
