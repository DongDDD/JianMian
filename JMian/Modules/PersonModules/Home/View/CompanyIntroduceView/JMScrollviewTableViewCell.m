//
//  JMScrollviewTableViewCell.m
//  JMian
//
//  Created by mac on 2019/9/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMScrollviewTableViewCell.h"
#import "SDCycleScrollView.h"
#import "DimensMacros.h"
#import "ZJImageMagnification.h"
NSString *const JMScrollviewTableViewCellIdentifier = @"JMCDetailImageTableViewCellIdentifier";
@interface JMScrollviewTableViewCell ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView2;
@property (weak, nonatomic) IBOutlet UIView *noDataView;

@end

@implementation JMScrollviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 
}

-(void)setModel:(JMCompanyInfoModel *)model{
    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (JMFilesModel *filesModel in model.files) {
        if ([filesModel.files_type isEqualToString:@"2"]) {
            [imagesURLStrings addObject:filesModel.files_file_path];
        }

    }
   

    
    // 网络加载 --- 创建带标题的图片轮播器
    if (imagesURLStrings.count > 0) {
        [self.cycleScrollView2 setHidden:NO];
        [self.noDataView setHidden:YES];
    }else{
        [self.cycleScrollView2 setHidden:YES];
        [self.noDataView setHidden:NO];
         
    }
    [self addSubview:self.cycleScrollView2];
 
    //         --- 模拟加载延迟
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//    });
    
    
    _cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
        UIImageView *img = [[UIImageView alloc]init];
        [img sd_setImageWithURL:[NSURL URLWithString:imagesURLStrings[index]]];
        [ZJImageMagnification  scanBigImageWithImageView:img alpha:1];
    };
    
    
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
