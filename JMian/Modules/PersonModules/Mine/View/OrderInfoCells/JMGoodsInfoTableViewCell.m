//
//  JMGoodsInfoTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/14.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsInfoTableViewCell.h"
#import "DimensMacros.h"
NSString *const JMGoodsInfoTableViewCellIdentifier = @"JMGoodsInfoTableViewCellIdentifier";
@implementation JMGoodsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMGoodsInfoCellData *)data{
    
    self.titleLab.text = data.title;
    self.titleLab2.text = [NSString stringWithFormat:@"数量：x%@",data.quantity];
    self.titleLab3.text = [NSString stringWithFormat:@"¥ %@",data.price];
    self.titleLab3.textColor = [UIColor systemRedColor];
}

-(void)setValuesWithImageUrl:(NSString *)ImageUrl title:(NSString *)title quantity:(NSString *)quantity  price:(NSString *)price{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:ImageUrl] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
      self.titleLab.text = title;
       self.titleLab2.text = [NSString stringWithFormat:@"数量：x%@",quantity];
       self.titleLab3.text = [NSString stringWithFormat:@"¥ %@",price];
       self.titleLab3.textColor = [UIColor systemRedColor];
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
