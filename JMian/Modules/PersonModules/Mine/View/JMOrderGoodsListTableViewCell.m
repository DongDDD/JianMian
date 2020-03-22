//
//  JMOrderGoddsListTableViewCell.m
//  JMian
//
//  Created by mac on 2020/2/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMOrderGoodsListTableViewCell.h"
#import "DimensMacros.h"
#import "APIStringMacros.h"
NSString *const JMOrderGoodsListTableViewCellIdentifier = @"JMOrderGoodsListTableViewCellIdentifier";

@implementation JMOrderGoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//http://app.jmzhipin.com
-(void)setValuesWithImageUrl:(NSString *)imageUrl title:(NSString *)title price:(NSString *)price quantity:(NSString *)quantity sku_mark:(NSString *)sku_mark{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",IMG_BASE_URL_STRING,imageUrl];
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.titleLab.text = title;
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@",price];
    self.quantityLab.text = [NSString stringWithFormat:@"x%@",quantity];
    if (sku_mark.length > 0) {
        [self.sku_markLab setHidden:NO];
        self.sku_markLab.text = [NSString stringWithFormat:@"产品规格: %@",sku_mark];
    }else{
        [self.sku_markLab setHidden:YES];

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
