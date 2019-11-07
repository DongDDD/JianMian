//
//  JMCDetailVideoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailVideoTableViewCell.h"
#import "DimensMacros.h"

NSString *const JMCDetailVideoTableViewCellIdentifier = @"JMCDetailVideoTableViewCellIdentifier";

@interface JMCDetailVideoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong)JMCDetailModel *myModel;
@end

@implementation JMCDetailVideoTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCDetailModel *)model{
    _myModel = model;
     [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.video_cover] placeholderImage:[UIImage imageNamed:@"NO_Data"]];
    if (!model.video_file_path) {
        [self.playBtn setHidden:YES];
    }else{
        [self.playBtn setHidden:NO];

    }
    
}
- (IBAction)playAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(playVideoActionWithUrl:)]) {
        [_delegate playVideoActionWithUrl:_myModel.video_file_path];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
