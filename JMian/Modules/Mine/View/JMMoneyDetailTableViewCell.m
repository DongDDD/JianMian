//
//  JMMoneyDetailTableViewCell.m
//  JMian
//
//  Created by mac on 2019/6/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "JMMoneyDetailTableViewCell.h"
@interface JMMoneyDetailTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end

@implementation JMMoneyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMWalletDetailsCellData *)data{
    self.titleLab.text = data.title;
    self.timeLab.text = data.created_at;
    NSString *moneyText;
    if ([data.action isEqualToString:@"1"]) {
        //收入
        moneyText = [NSString stringWithFormat:@"+ %@",data.amount];
        self.moneyLab.text = moneyText;
        self.moneyLab.textColor = [UIColor greenColor];
    }else if ([data.action isEqualToString:@"1"]){
        //支出
        moneyText = [NSString stringWithFormat:@"- %@",data.amount];
        self.moneyLab.text = moneyText;
        self.moneyLab.textColor = [UIColor redColor];
    }
//    self.moneyLab.text = NS
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
