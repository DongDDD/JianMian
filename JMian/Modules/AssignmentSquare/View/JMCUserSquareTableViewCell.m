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
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation JMCUserSquareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:95/255.0 blue:133/255.0 alpha:0.1].CGColor;
        self.bgView.layer.shadowOffset = CGSizeMake(0,2);
        self.bgView.layer.shadowOpacity = 1;
        self.bgView.layer.shadowRadius = 5;
        self.bgView.layer.borderWidth = 0.5;
        self.bgView.layer.borderColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0].CGColor;
    }
    return self;
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
