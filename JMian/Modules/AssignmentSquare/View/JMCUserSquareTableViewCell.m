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



@end

@implementation JMCUserSquareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMPartTimeJobModel *)model{
    
    self.titleLab.text = model.type_name;
    self.adress.text = model.city_cityName;
    [self.headerIconImg sd_setImageWithURL:[NSURL URLWithString:model.user_avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMIndustryModel *data in model.industry) {
        [industryNameArray addObject:data.name];
    }
    NSString *industryStr = [industryNameArray componentsJoinedByString:@"/"];
    self.jobLabs.text = industryStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
