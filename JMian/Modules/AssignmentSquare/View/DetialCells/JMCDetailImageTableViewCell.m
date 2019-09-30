//
//  JMCDetailImageTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailImageTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMCDetailImageTableViewCellIdentifier = @"JMCDetailImageTableViewCellIdentifier";

@interface JMCDetailImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JMCDetailImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUrl:(NSString *)url{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"NO_Data"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
