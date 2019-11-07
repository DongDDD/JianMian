//
//  JMBDetailVideoView.m
//  JMian
//
//  Created by mac on 2019/9/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBDetailVideoView.h"
#import "DimensMacros.h"
@interface JMBDetailVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property(nonatomic,strong)JMBDetailModel *myModel;


@end
@implementation JMBDetailVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
    }
    return self;
}

-(void)setModel:(JMBDetailModel *)model{
    _myModel = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.video_cover] placeholderImage:[UIImage imageNamed:@"NOvideos"]];
    
}

- (IBAction)playAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(playVideoActionWithUrl:)]) {
        [_delegate playVideoActionWithUrl:self.myModel.video_file_path];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
