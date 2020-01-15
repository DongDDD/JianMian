//
//  JMPostProductHeaderTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMPostProductHeaderTableViewCell.h"
#import "SDCycleScrollView.h"
#import "DimensMacros.h"
#import "ZJImageMagnification.h"

NSString *const JMPostProductHeaderTableViewCellIdentifier = @"JMPostProductHeaderTableViewCellIdentifier";

@interface JMPostProductHeaderTableViewCell ()
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView2;

@end


@implementation JMPostProductHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(SDCycleScrollView *)cycleScrollView2{
    if (!_cycleScrollView2) {
        _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) delegate:self placeholderImage:[UIImage imageNamed:@"break"]];
        _cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    }
    return _cycleScrollView2;
    
}

@end
