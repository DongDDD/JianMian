//
//  JMPersonVideoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/11/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMPersonVideoTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMPersonVideoTableViewCellIdentifier = @"JMPersonVideoTableViewCellIdentifier";

@implementation JMPersonVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMVitaDetailModel *)model{
    
    if ([model.video_status isEqualToString:@"2"] && model.video_file_path.length > 0) {
        [self.videoImageView setHidden:NO];
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.video_cover] placeholderImage:[UIImage imageNamed:@"loading"]];
        [self.playBtn setHidden:NO];
    }else{
        [self.videoImageView setHidden:YES];
        [self.playBtn setHidden:YES];

    }
    
    
}
- (IBAction)playActoin:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playVideoAction)]) {
        [_delegate playVideoAction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
