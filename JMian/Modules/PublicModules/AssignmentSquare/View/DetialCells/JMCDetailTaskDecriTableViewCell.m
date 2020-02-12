//
//  JMCDetailTaskDecriTableViewCell.m
//  JMian
//
//  Created by mac on 2019/8/20.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMCDetailTaskDecriTableViewCell.h"
NSString *const JMCDetailTaskDecriTableViewCellIdentifier = @"JMCDetailTaskDecriTableViewCellIdentifier";
@interface JMCDetailTaskDecriTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *taskTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;
@property (weak, nonatomic) IBOutlet UILabel *paymentMoney;
@property (weak, nonatomic) IBOutlet UILabel *frontMoney;
@property (weak, nonatomic) IBOutlet UILabel *quantityMax;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *industry;
@property (weak, nonatomic) IBOutlet UILabel *paymentMethod;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyConstrant;
@property (weak, nonatomic) IBOutlet UILabel *industryTitle;

@end

@implementation JMCDetailTaskDecriTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(JMCDetailModel *)model{
    self.taskTitleLab.text = model.task_title;
    [self.taskTitleLab sizeToFit];
    
    if ([model.payment_method isEqualToString:@"1"]) {
        if (model.goods.count > 0) {
            NSMutableArray *arr = [NSMutableArray array];
            for (JMGoodsData *data in model.goods) {
                [arr addObject:data.salary];
            }
            //最大值
            double max_value = [[arr valueForKeyPath:@"@max.doubleValue"] doubleValue];
            int max_value2 =  fabs(max_value);
            //最小值
            double min_value = [[arr valueForKeyPath:@"@min.doubleValue"] doubleValue];
            int min_value2 =  fabs(min_value);
            self.paymentMoney.text = [NSString stringWithFormat:@"%d ~ %d",min_value2,max_value2];
        }else{
            self.moneyConstrant.constant = 20;
            [self.paymentMoney setHidden:YES];
            [self.unitLab setHidden:YES];
            
        }
        
        
        
        
    }else{
        [self.paymentMoney setHidden:NO];
        [self.unitLab setHidden:NO];
        self.moneyConstrant.constant = 61;
        self.paymentMoney.text = model.payment_money;
    }
    
    
     
    if ([model.payment_method isEqualToString:@"3"]) {
        self.paymentMethod.text = @"完工结";
    }else if ([model.payment_method isEqualToString:@"1"]){
        self.paymentMethod.text = @"即结";
        [self.industryTitle  setHidden:YES];
    }
    if ([model.front_money isEqualToString:@"0"]) {
        self.frontMoney.text = @"无定金";
    }else{
        self.frontMoney.text = @"有定金";
    }
    self.quantityMax.text = [NSString stringWithFormat:@"%@人",model.quantity_max];
    if (model.city_name.length > 0) {
        self.city.text = model.city_name;
    }else{
        self.city.text = @"不限地区";
    }
    NSMutableArray *industryNameArray = [NSMutableArray array];
    for (JMCDetailindustryModel *industryModel in model.industry) {
        [industryNameArray addObject:industryModel.name];
    }
    NSString *industry = [industryNameArray componentsJoinedByString:@"/"];
    self.industry.text = industry;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
