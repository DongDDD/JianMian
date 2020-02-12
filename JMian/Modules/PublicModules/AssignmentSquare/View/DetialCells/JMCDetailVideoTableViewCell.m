//
//  JMCDetailVideoTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailVideoTableViewCell.h"
#import "DimensMacros.h"
#import "APIStringMacros.h"

NSString *const JMCDetailVideoTableViewCellIdentifier = @"JMCDetailVideoTableViewCellIdentifier";

@interface JMCDetailVideoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong)JMCDetailModel *myModel;
@property (nonatomic, strong)JMGoodsInfoModel *myGoodsInfoModel;
@property (nonatomic, copy)NSString *video_file_path;
@end

@implementation JMCDetailVideoTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMCDetailModel *)model{
    _myModel = model;
    _video_file_path = model.video_file_path;
     [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.video_cover] placeholderImage:[UIImage imageNamed:@"NO_Data"]];
    if (!model.video_file_path) {
        [self.playBtn setHidden:YES];
    }else{
        [self.playBtn setHidden:NO];
    }
    
}

-(void)setGoodInfoModel:(JMGoodsInfoModel *)goodInfoModel{
    _myGoodsInfoModel = goodInfoModel;
    _video_file_path = goodInfoModel.video_file_path;
    NSString *url = [NSString stringWithFormat:@"http://produce.jmzhipin.com%@",goodInfoModel.video_cover_path];
//    self.imgView.image = [UIImage imageNamed:@"break"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"break"]];
       if (!goodInfoModel.video_cover_path) {
           [self.playBtn setHidden:YES];
       }else{
           [self.playBtn setHidden:NO];
       }
    
}

- (IBAction)playAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(playVideoActionWithUrl:)]) {
        NSString *url = [NSString stringWithFormat:@"http://produce.jmzhipin.com%@",_video_file_path];

        [_delegate playVideoActionWithUrl:url];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
