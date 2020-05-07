//
//  JMGoodsDetialTitleTableViewCell.m
//  JMian
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

#import "JMGoodsDetialTitleTableViewCell.h"
#import "JMDataTransform.h"
NSString *const JMGoodsDetialTitleTableViewCellIdentifier = @"JMGoodsDetialTitleTableViewCellIdentifier";

@implementation JMGoodsDetialTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(JMGoodsInfoModel *)model{
    self.titleLab.text = model.title;
    self.priceLab.text = model.price;
    if (model.sku.count > 0) {
        NSMutableArray *arr =[NSMutableArray array];
        for (JMGoodsInfoSkuModel *skuData in model.sku) {
            [arr addObject:skuData.salary];
        }
         
        self.salarylab.text = [NSString stringWithFormat:@"佣金 ：%@ 元",[JMDataTransform getSalaryRangeWithArr:arr]];
    }else{
        self.salarylab.text = [NSString stringWithFormat:@"佣金 ：%@ 元",model.salary];
    }
    
//    if (arr.count == 1) {
//            //单个商品
//            self.salarylab.text = [NSString stringWithFormat:@"佣金 ：%@ 元", arr[0]];
//        }else{
//            //多个商品
//            //最大值
//            double max_value = [[arr valueForKeyPath:@"@max.doubleValue"] doubleValue];
//            int max_value2 =  fabs(max_value);
//            //最小值
//            double min_value = [[arr valueForKeyPath:@"@min.doubleValue"] doubleValue];
//            int min_value2 =  fabs(min_value);
//            if (min_value2 == max_value2 ) {
//                self.salarylab.text  = [NSString stringWithFormat:@"佣金 ：%d 元",max_value2];
//            }else{
//                self.salarylab.text = [NSString stringWithFormat:@"佣金：%d ~ %d 元",min_value2,max_value2];
//
//            }
//
//        }
 
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
