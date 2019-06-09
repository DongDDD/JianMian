//
//  JMBUserSquareTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/6.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMBUserSquareTableViewCell.h"
#import "DimensMacros.h"
@interface JMBUserSquareTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerIconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *jobLabs;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;



@end

@implementation JMBUserSquareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMPartTimeJobModel *)model{
    
    self.titleLab.text = model.type_name;
    self.nameLab.text = model.user_nickname;
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
