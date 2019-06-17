//
//  JMCUserSquareTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCUserSquareTableViewCell.h"
#import "DimensMacros.h"
@interface JMCUserSquareTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerIconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *jobLabs;
@property (weak, nonatomic) IBOutlet UILabel *paymentLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;

@end

@implementation JMCUserSquareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMTaskListCellData *)model{
    
    self.titleLab.text = model.task_title;
    if (model.address == nil) {
        self.adress.text = @"不限地区";
    }else{
        self.adress.text = model.cityName;
    }
    self.paymentLab.text = model.payment_money;
    self.unitLab.text = model.unit;
    
//    [self.headerIconImg sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
//    NSMutableArray *industryNameArray = [NSMutableArray array];
//    for (JMIndustryModel *data in model.industry) {
//        [industryNameArray addObject:data.name];
//    }
//    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
//    self.jobLabs.text = industryStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
