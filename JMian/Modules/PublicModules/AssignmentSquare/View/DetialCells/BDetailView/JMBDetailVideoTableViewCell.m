//
//  JMBDetailVideoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/9/28.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailVideoTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMBDetailVideoTableViewCellIdentifier = @"JMBDetailVideoTableViewCellIdentifier";
@interface JMBDetailVideoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property(nonatomic,strong)JMBDetailModel *myModel;


@end
@implementation JMBDetailVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMBDetailModel *)model{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.video_cover] placeholderImage:[UIImage imageNamed:@"NOvideos"]];

}
- (IBAction)playAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playVideoActionWithUrl:)]) {
        [_delegate playVideoActionWithUrl:self.myModel.video_file_path];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
