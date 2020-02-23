//
//  JMGoodsCollectionViewCell.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsCollectionViewCell.h"
#import "DimensMacros.h"
#import "APIStringMacros.h"
NSString *const JMGoodsCollectionViewCellIdentifier = @"JMGoodsCollectionViewCellIdentifier";
@interface JMGoodsCollectionViewCell ()

@property(nonatomic,strong)JMGoodsData *myData;

@end
@implementation JMGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(JMGoodsData *)data{
    _myData = data;
    self.titleLab.text = data.title;
    self.priceLab.text = data.price;
    self.topLeftLab.text = [NSString stringWithFormat:@"  佣金:¥ %@   ",data.salary];
    if (data.images.count > 0) {
        JMGoodsImageData *imageData = data.images[0];
        NSString *file_path = [NSString stringWithFormat:@"%@%@",IMG_BASE_URL_STRING,imageData.file_path];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:file_path] placeholderImage:[UIImage imageNamed:@"break"]];
    }

}
- (IBAction)shareAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickShareActionWithData:)]) {
        [_delegate didClickShareActionWithData:_myData];
    }
}
@end
