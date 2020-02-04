//
//  JMGoodsCollectionViewCell.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsCollectionViewCell.h"
#import "DimensMacros.h"
NSString *const JMGoodsCollectionViewCellIdentifier = @"JMGoodsCollectionViewCellIdentifier";

@implementation JMGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMGoodsData *)data{
    self.titleLab.text = data.title;
    self.priceLab.text = data.price;
    self.topLeftLab.text = [NSString stringWithFormat:@"  佣金:¥ %@   ",data.salary];
    JMGoodsImageData *imageData = data.images[0];
    NSString *file_path = [NSString stringWithFormat:@"http://app.jmzhipin.com%@",imageData.file_path];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:file_path] placeholderImage:[UIImage imageNamed:@"break"]];

}
@end
